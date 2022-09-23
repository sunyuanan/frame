package com.example.frame.websocket;

import com.example.frame.common.utils.DataResult;
import org.java_websocket.client.WebSocketClient;
import org.java_websocket.drafts.Draft_6455;
import org.java_websocket.handshake.ServerHandshake;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.LinkedHashMap;

/**
 * @author Galen
 * @Date 2021/12/9 0009 16:43
 */
@Component
public class WebsocketClientUtil {
    private static Logger logger = LoggerFactory.getLogger(WebsocketClientUtil.class);

    public LinkedHashMap<String, WebSocketClient> webSocketClientLinkedMap = new LinkedHashMap<>();
    public LinkedHashMap<String, Thread> threadLinkedMap = new LinkedHashMap<>();


    private String signUrl = "120.79.22.106";

    /**
     * @param webSocketName 确保唯一
     * @param token
     * @return
     */
    public WebSocketClient sendVitalSignsSocket(String webSocketName, String token, String uuid) {

        WebSocketClient client = null;
        try {
            client = new WebSocketClient(
                    new URI(
                            "ws://" + signUrl + "/cpu/webSocketServer?token="
                                    + token
                                    + "&uuid="
                                    + uuid
                                    + "&types=vitalsign,temperature,power,SOS,wearingAlarm,gpsLocation,tagVbatPercent,tagOnline,stationOnline&socketType=project&projectIds=5f1f8a1a23ba4d3f49649659"),
                    new Draft_6455()) {
                @Override
                public void onOpen(ServerHandshake serverHandshake) {
                    logger.info("握手成功");
                }

                @Override
                public void onMessage(String msg) {
                    System.out.println(msg);
                }

                @Override
                public void onClose(int i, String s, boolean b) {
                    logger.info("客户端已关闭!");
                    logger.info("开始尝试重新连接...");
                }

                @Override
                public void onError(Exception e) {
                    e.printStackTrace();
                    logger.info("发生错误");
                }
            };
            client.connect();
            heartbeat(client, webSocketName);

        } catch (URISyntaxException e) {
            e.printStackTrace();
        }

        webSocketClientLinkedMap.put(webSocketName, client);
        return client;
    }


    public Thread heartbeat(WebSocketClient client, String name) {
        /* 心跳包 */
        Thread thered = new Thread(new Runnable() {
            @Override
            public void run() {
                while (true) {
                    try {
                        Thread.sleep(1000);  //单位毫秒  发送信息是否在线连接
                        client.send("");
                    } catch (Exception e) {
                        client.reconnect();  //重新连接
                    }
                }
            }
        }, name + "心跳包线程");
        thered.start();
        threadLinkedMap.put(name, thered);
        return thered;
    }


    public DataResult stop(String name) {

        if (webSocketClientLinkedMap.containsKey(name)) {
            webSocketClientLinkedMap.get(name).close();
            threadLinkedMap.get(name).stop();
            logger.info(name + "websocke和心跳包已停止");
            return DataResult.success();
        } else {
            return DataResult.fail("该" + name + "websocket不存在");
        }
    }


}
