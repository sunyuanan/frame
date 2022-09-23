package com.example.frame.common.rabbitmq;

import lombok.Data;

/**
 * @title：
 * @author: sya
 * @date: 2022年07月29日 17:56
 * @description:
 */

@Data
public class RabbitmqEntity {

    private String exchange;
    private String queue;
    private String routingKey;


    private RabbitmqEntity(Builder builder) {
        exchange = builder.exchange;
        queue = builder.queue;
        routingKey = builder.routingKey;
    }

    public static class Builder {
        private String exchange;
        private String queue;
        private String routingKey;


        public Builder setExchange(String exchange) {
            this.exchange = exchange;
            return this;
        }

        public Builder setQueue(String queue) {
            this.queue = queue;
            return this;
        }

        public Builder setRoutingKey(String routingKey) {
            this.routingKey = routingKey;
            return this;
        }

        public RabbitmqEntity create() {
            return new RabbitmqEntity(this);
        }

    }

}
