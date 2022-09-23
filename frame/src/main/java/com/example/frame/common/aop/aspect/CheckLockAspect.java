package com.example.frame.common.aop.aspect;

import cn.dev33.satoken.stp.StpUtil;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RedisUtil;
import com.example.frame.common.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * @author sya
 * @Date 2021/11/12 0012 9:22
 */
@Aspect
@Component
@Slf4j
public class CheckLockAspect {

    /**
     * redis工具类
     */
    @Resource
    private RedisUtil redisUtil;

    /**
     * 此处的切点是注解的方式 只要出现 @LogAnnotation注解都会进入
     */
    @Pointcut("@annotation(com.example.frame.common.aop.annotation.CheckLockAnnotation)")
    public void logPointCut() {
    }

    /**
     * @param point
     * @return
     * @throws Throwable
     */
    @Around("logPointCut() && @annotation( checkLockAnnotation)")
    public Object around(ProceedingJoinPoint point, CheckLockAnnotation checkLockAnnotation) throws Throwable {
        /*获取锁参数*/
        Map<String, Object> result = getAnnotationArgs(point, checkLockAnnotation);
        Object res = new Object();
        /*redis 存锁名 分组：lockName*/
        String redisLockName = "lock:" + result.get("lockName").toString();
        long lockTime = Long.parseLong(result.get("lockTime").toString());
        try {
            //查询是否有上锁
            if (!redisUtil.hasKey(redisLockName)) {
                //添加锁
                redisUtil.set(redisLockName, "重复提交锁", lockTime, TimeUnit.SECONDS);
                /*执行方法*/
                res = point.proceed();
                //执行完后主动删除 lock
                redisUtil.delete(redisLockName);
            } else {
                System.out.print(".");
                return DataResult.fail("操作过于频繁，请稍后重试");
            }
        } catch (Exception e) {
            redisUtil.delete(redisLockName);
            e.printStackTrace();
        }
        return res;
    }

    /**
     * 获取锁参数
     *
     * @param point
     * @return
     * @throws Exception
     */
    private Map<String, Object> getAnnotationArgs(ProceedingJoinPoint point, CheckLockAnnotation checkLockAnnotation) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("lockTime", checkLockAnnotation.time());
        String lockName = "";

        /*如果带了权限方法的  则前缀加上用户Id*/
        if (!StringUtil.isNullorEmpty(StpUtil.getLoginIdByToken(StpUtil.getTokenValue()))) {
            lockName += StpUtil.getLoginIdByToken(StpUtil.getTokenValue());
        }

        /*主动添加锁Id则直接返回*/
        if (!StringUtil.isNullorEmpty(checkLockAnnotation.id())) {
            lockName += "-" + checkLockAnnotation.id();
            result.put("lockName", lockName);
            return result;
        }

        //获取类的字节码对象，通过字节码对象获取方法信息
        Class<?> targetCls = point.getTarget().getClass();
        //controller头 RequestMapping value
        String request = targetCls.getAnnotation(RequestMapping.class).value()[0];

        /*获取方法地址*/
        Signature sig = point.getSignature();
        MethodSignature methodSignature = (MethodSignature) sig;
        Object target = point.getTarget();
        Method currentMethod = target.getClass().getMethod(methodSignature.getName(), methodSignature.getParameterTypes());

        /*参数头+方法名确保唯一*/
        lockName += request + "-" + currentMethod.getName();

        result.put("lockName", lockName);
        return result;
    }
}
