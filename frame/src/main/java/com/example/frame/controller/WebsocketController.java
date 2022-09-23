package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.websocket.WebsocketClientUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.java_websocket.client.WebSocketClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Galen
 * @Date 2021/12/10 0010 10:10
 */
@Api(tags = {"Websocket手动重启机制"})
@Slf4j
@Controller
@RequestMapping("/websocket")
public class WebsocketController {

    @Autowired
    WebsocketClientUtil websocketClientUtil;

    @ApiOperation(value = "查看webSocketList")
    @PostMapping("/list")
    @LogAnnotation(title = "查看webSocketList", action = "查看webSocketList")
    @ResponseBody
    @SaCheckPermission("websocket-list")
    public DataResult list() {
        LinkedHashMap<String, WebSocketClient> linkedMap = websocketClientUtil.webSocketClientLinkedMap;
        List list = new LinkedList();

        for (String key : linkedMap.keySet()) {

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", key);
            jsonObject.put("type", websocketClientUtil.webSocketClientLinkedMap.get(key).getReadyState());
            list.add(jsonObject);
        }
        return DataResult.success(list);
    }


    @ApiOperation(value = "停止webSocket")
    @PostMapping("/stopWebsocket")
    @LogAnnotation(title = "停止webSocket", action = "停止webSocket")
    @ResponseBody
    @SaCheckPermission("websocket-stop")
    public DataResult restart(@RequestParam String websocketName) {

        if (StringUtil.isNullorEmpty(websocketName)) {
            return DataResult.fail("名称不能为空");
        }

        return websocketClientUtil.stop(websocketName);
    }


}
