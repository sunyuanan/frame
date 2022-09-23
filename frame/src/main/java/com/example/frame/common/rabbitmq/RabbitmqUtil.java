package com.example.frame.common.rabbitmq;

import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.vo.RmqMessageVO;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageBuilder;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @title：
 * @author: sya
 * @date: 2022年07月29日 16:39
 * @description:
 */
@Component
public class RabbitmqUtil {


    @Resource
    private RabbitTemplate rabbitTemplate;

    public RabbitmqUtil(RabbitTemplate rabbitTemplate) {
        this.rabbitTemplate = rabbitTemplate;
    }


    /**
     * 发送信息
     *
     * @param sendData   发送内容
     * @param exchange
     * @param routingKey
     */
    public void send(Object sendData, String exchange, String routingKey) {
        CorrelationData correlationData = new CorrelationData();

        RmqMessageVO rmqMessageVO = new RmqMessageVO();
        rmqMessageVO.setData(sendData);
        rmqMessageVO.setTimestamp(DateTimeUI.getCurrentDateTimeLong());


        Message message = MessageBuilder.withBody(rmqMessageVO.toString().getBytes()).build();
        message.getMessageProperties().setMessageId(RandomGUID.getDateUUID());


        correlationData.setId(RandomGUID.getDateUUID());
        correlationData.setReturnedMessage(message);
        rabbitTemplate.convertAndSend(exchange, routingKey, sendData, correlationData);


    }


}
