package com.example.frame.websocket;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RestController;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@Slf4j
@ServerEndpoint(value = "/websocket/{user}")
public class WebSocket {

    /**
     * 静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
     */
    private static int onlineCount = 0;
    /**
     * concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。
     */
    private static ConcurrentHashMap<String, WebSocket> webSocketMap = new ConcurrentHashMap<>();
    /**
     * 与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    private Session session;
    /**
     * 接收user
     */
    private String user = "";

    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("user") String user) {
        this.session = session;
        this.user = user;
        /* 如果存在 删除原来socket */
        if (webSocketMap.containsKey(user)) {
            webSocketMap.remove(user);
            webSocketMap.put(user, this);
            // 加入set中
        } else {
            webSocketMap.put(user, this);
            // 加入set中
            addOnlineCount();
            // 在线数加1
        }

        log.info("用户连接:" + user + ",当前在线人数为:" + getOnlineCount());

        try {
            sendMessage("连接成功");
        } catch (IOException e) {
            log.error("用户:" + user + ",网络异常!!!!!!");
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        if (webSocketMap.containsKey(user)) {
            webSocketMap.remove(user);
            // 从set中删除
            subOnlineCount();
        }
        log.info("用户退出:" + user + ",当前在线人数为:" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        log.info("用户消息:" + user + ",报文:" + message);
    }

    /**
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("用户错误:" + this.user + ",原因:" + error.getMessage());
        error.printStackTrace();
    }

    /**
     * 实现服务器主动推送
     */
    public void sendMessage(String message) throws IOException {
        this.session.getBasicRemote().sendText(message);
    }

    /**
     * 发送自定义消息
     */
    public static void sendInfo(String message, @PathParam("user") String user) throws IOException {
        log.info("发送消息到:" + user + "，报文:" + message);
        if (StringUtils.isNotBlank(user) && webSocketMap.containsKey(user)) {
            webSocketMap.get(user).sendMessage(message);
        } else {
            log.error("用户" + user + ",不在线！");
        }
    }

    /**
     * 批量发送自定义消息
     */
    public static void sendInfoBatch(String message, @PathParam("userList") List<String> list)
            throws IOException {
        log.info(JSONObject.toJSONString(webSocketMap));
        for (String user : list) {
            if (StringUtils.isNotBlank(user) && webSocketMap.containsKey(user)) {
                webSocketMap.get(user).sendMessage(message);
            } else {
                log.error("用户" + user + ",不在线！");
            }
        }
    }

    /**
     * 获取当前在线用户
     */
    public static ConcurrentHashMap getOnLineUserList() throws IOException {
        return webSocketMap;
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        com.example.frame.websocket.WebSocket.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        com.example.frame.websocket.WebSocket.onlineCount--;
    }
}
