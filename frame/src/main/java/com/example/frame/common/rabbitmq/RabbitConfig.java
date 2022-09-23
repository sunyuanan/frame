package com.example.frame.common.rabbitmq;


import com.example.frame.common.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitAdmin;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.Resource;


/**
 * @title：
 * @author: sya
 * @date: 2022年07月29日 10:06
 * @description:
 */
@Configuration
@Slf4j
public class RabbitConfig {

    @Resource
    RabbitAdmin rabbitAdmin;


    /**
     * 创建交换机和对列,跟上面的Bean的定义保持一致
     */
    @Bean
    public void createExchangeQueue() {

        /**
         * 初始化枚举 自动创建
         */
        for (RabbitmqInitEnum rabbitmqInitEnum : RabbitmqInitEnum.values()) {

            DirectExchange directExchange = new DirectExchange(rabbitmqInitEnum.rabbitmqEntity.getExchange(), true, false);
            Queue queue = new Queue(rabbitmqInitEnum.rabbitmqEntity.getQueue(), true, false, false);

            rabbitAdmin.declareExchange(directExchange);
            rabbitAdmin.declareQueue(queue);

            if (!StringUtil.isNullorEmpty(rabbitmqInitEnum.rabbitmqEntity.getRoutingKey())) {
                rabbitAdmin.declareBinding(BindingBuilder.bind(queue).to(directExchange).with(rabbitmqInitEnum.rabbitmqEntity.getRoutingKey()));
            }

        }
    }


    /**
     * 创建初始化RabbitAdmin对象
     *
     * @param connectionFactory
     * @return
     */
    @Bean
    public RabbitAdmin rabbitAdmin(ConnectionFactory connectionFactory) {
        RabbitAdmin rabbitAdmin = new RabbitAdmin(connectionFactory);
        // 只有设置为 true，spring 才会加载 RabbitAdmin 这个类
        rabbitAdmin.setAutoStartup(true);
        return rabbitAdmin;
    }


    /**
     * 初始化配置 发送回调和消费失败回调
     *
     * @param connectionFactory
     * @return
     */
    @Bean
    public RabbitTemplate createRabbitTemplate(ConnectionFactory connectionFactory) {
        RabbitTemplate rabbitTemplate = new RabbitTemplate();
        rabbitTemplate.setConnectionFactory(connectionFactory);
        // Mandatory为true时,消息通过交换器无法匹配到队列会返回给生产者，为false时匹配不到会直接被丢弃
        rabbitTemplate.setMandatory(true);

        rabbitTemplate.setConfirmCallback(new RabbitTemplate.ConfirmCallback() {
            /**
             *  ConfirmCallback机制只确认消息是否到达exchange(交换器)，不保证消息可以路由到正确的queue;
             *  需要设置：publisher-confirm-type: CORRELATED；
             *  springboot版本较低 参数设置改成：publisher-confirms: true
             *
             *  以实现方法confirm中ack属性为标准，true到达
             *  config : 需要开启rabbitmq得ack publisher-confirm-type
             */
            @Override
            public void confirm(CorrelationData correlationData, boolean ack, String cause) {
                log.info("ConfirmCallback  确认结果 (true代表发送成功) : {}  消息唯一标识 : {} 失败原因 ：{}", ack, correlationData, cause);

            }

        });

        /**
         * 路由不到发队列时触发，成功则不触；
         */
        rabbitTemplate.setReturnCallback((message, replyCode, replyText, exchange, routingKey) -> {
            log.error("路由不到发队列时触发 {}{}{}{}", message, replyCode, replyText, exchange, routingKey);
        });

        return rabbitTemplate;
    }
}
