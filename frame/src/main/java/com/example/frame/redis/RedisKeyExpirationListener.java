package com.example.frame.redis;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.listener.KeyExpirationEventMessageListener;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


/**
 * @author sya
 * 主要作用就是:接收过期的redis消息,获取到key
 */
@Transactional(rollbackFor = Exception.class)
@Component
public class RedisKeyExpirationListener extends KeyExpirationEventMessageListener {


    public RedisKeyExpirationListener(RedisMessageListenerContainer listenerContainer) {
        super(listenerContainer);
    }


    @Override
    public void onMessage(Message message, byte[] pattern) {
        /* redis缓存过期调用方法 */
        System.out.println(message.getBody());
        String redisKey = message.toString();
        System.out.println(redisKey);

        /*分组key 根据key 做出具体的业务操作*/
        String[] groupKey = redisKey.split(":");

        String titleKey = groupKey[0];

    }



}
