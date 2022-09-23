package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.rabbitmq.RabbitmqInitEnum;
import com.example.frame.common.rabbitmq.RabbitmqUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


/**
 * 测试控制器
 *
 * @author Administrator
 * @date 2022/09/22
 */
@Slf4j
@Controller
@RequestMapping("/test")
public class TestController {

    @Resource
    private RabbitmqUtil rabbitmqUtil;
    @Resource
    private RabbitTemplate rabbitTemplate;


    @GetMapping(value = "/test")
    @ResponseBody
    @CheckLockAnnotation(id = "test")
    public void test() {
        System.out.println(1);
    }


}


