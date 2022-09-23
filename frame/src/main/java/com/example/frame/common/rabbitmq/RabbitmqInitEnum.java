package com.example.frame.common.rabbitmq;


/**
 * @title：
 * @author: sya
 * @date: 2022年07月29日 17:45
 * @description: rabbit初始化 枚举
 */


public enum RabbitmqInitEnum {

    /**
     * 测试创建Rabbitmq DEMO
     */
    TEST(
            new RabbitmqEntity.Builder()
                    .setExchange("autoE")
                    .setQueue("autoQ")
                    .setRoutingKey("autoR")
                    .create()
    );


    public final RabbitmqEntity rabbitmqEntity;


    RabbitmqInitEnum(RabbitmqEntity rabbitmqEntity) {
        this.rabbitmqEntity = rabbitmqEntity;
    }


}
