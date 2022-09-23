package com.example.frame.common.rabbitmq;

import com.alibaba.fastjson.JSONObject;
import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.*;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * @title：
 * @author: sya
 * @date: 2022年07月28日 15:47
 * @description: 消费者
 */
@Component
public class Consumer {


    /**
     *
     * 消息确认回复方法
     * 重回队列(个人不建议容易死循环，可以直接主动抛出异常，利用rabbitmq重试机制重新消费)
     *
     * channel.basicAck(msg.getMessageProperties().getDeliveryTag(),false);
     * ack表示确认消息。multiple：false只确认该delivery_tag的消息，true确认该delivery_tag的所有消息
     *
     * channel.basicReject(msg.getMessageProperties().getDeliveryTag(),false);
     * Reject表示拒绝消息。requeue：false表示被拒绝的消息是丢弃；true表示重回队列
     *
     * channel.basicNack(msg.getMessageProperties().getDeliveryTag(),false,false);
     * nack表示拒绝消息。multiple表示拒绝指定了delivery_tag的所有未确认的消息，requeue表示不是重回队列
     *
     * 注意： 对象接收需要 实体类implements Serializable
     */


    /**
     * 消息手动回复
     *
     * @param msg     消息内容
     * @param message
     * @param channel
     * @throws InterruptedException
     */
    @RabbitListener(queues = "autoQ")
    public void listenSimpleQueueMessage(JSONObject msg, Message message, Channel channel) throws InterruptedException, IOException {
        System.out.println(message);
        System.out.println("spring 消费者1接收到消息：【" + msg + "】");
        channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);

    }

}
