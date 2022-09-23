package com.example.frame.common.satoken;


import cn.dev33.satoken.stp.StpInterface;
import com.example.frame.common.utils.RedisUtil;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


/**
 * @author sya
 * @Date 2021/12/18 21:47
 */
@Component
public class StpInterfaceImpl implements StpInterface {

    @Resource
    private RedisUtil redisUtil;


    /**
     * 返回一个账号所拥有的权限码集合
     */
    @Override
    public List<String> getPermissionList(Object loginId, String loginType) {
        List<String> list = (List<String>) (List) redisUtil.lrange("sysPermission:" + loginId, 0, -1);
        return list;
    }

    /**
     * 返回一个账号所拥有的角色标识集合 (权限与角色可分开校验)
     */
    @Override
    public List<String> getRoleList(Object loginId, String loginType) {
        List<String> list = (List<String>) (List) redisUtil.lrange("sysRole:" + loginId, 0, -1);
        return list;
    }

}