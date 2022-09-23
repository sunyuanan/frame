package com.example.frame.common.aop.aspect;

import cn.dev33.satoken.SaManager;
import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.config.AsyncManager;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.HttpContextUtils;
import com.example.frame.common.utils.IPUtils;
import com.example.frame.entity.SysLog;
import com.example.frame.mapper.SysLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.TimerTask;
import java.util.UUID;

/**
 * @author Galen
 * @Date 2021/12/18 21:47
 */
@Aspect
@Component
@Slf4j
public class SysLogAspect {

    @Resource
    private SysLogMapper sysLogMapper;


    /**
     * 此处的切点是注解的方式 只要出现 @LogAnnotation注解都会进入
     */
    @Pointcut("@annotation(com.example.frame.common.aop.annotation.LogAnnotation)")
    public void logPointCut() {
    }

    /**
     * 环绕增强,相当于MethodInterceptor
     *
     * @param point
     * @return
     * @throws Throwable
     */
    @Around("logPointCut()")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        // 执行方法
        Object result = point.proceed();
        long beginTime = System.currentTimeMillis();
        // 执行时长(毫秒)
        long time = System.currentTimeMillis() - beginTime;
        // 保存日志
        try {
            saveSysLog(point, time, result);
        } catch (Exception e) {
            log.error("e={}", e);
        }
        return result;
    }

    @AfterReturning(value = "logPointCut()", returning = "ret")
    public void afterReturning(JoinPoint joinPoint, Object ret) {
        String methodName = joinPoint.getSignature().getName();
        if ("login".equals(methodName)) {
            long beginTime = System.currentTimeMillis();
            // 执行时长(毫秒)
            long time = System.currentTimeMillis() - beginTime;
            // 保存日志
            try {
                log.info(JSONObject.toJSONString(ret));
            } catch (Exception e) {
                log.error("e={}", e);
            }
        }
    }

    /**
     * 把日志保存
     */
    private void saveSysLog(JoinPoint joinPoint, long time, Object result) {
        MethodSignature signature = (MethodSignature) joinPoint.getSignature();
        Method method = signature.getMethod();
        SysLog sysLog = new SysLog();
        LogAnnotation logAnnotation = method.getAnnotation(LogAnnotation.class);
        if (logAnnotation != null) {
            // 注解上的描述
            sysLog.setOperation(logAnnotation.title() + "-" + logAnnotation.action());
        }
        // 请求的方法名
        String className = joinPoint.getTarget().getClass().getName();
        String methodName = signature.getName();
        sysLog.setMethod(className + "." + methodName + "()");
        log.info("请求{}.{}耗时{}毫秒", className, methodName, time);
        try {
            // 请求的参数
            Object[] args = joinPoint.getArgs();
            String params = null;
            if (args.length != 0) {
                params = JSON.toJSONString(args);
            }

            sysLog.setParams(params);
        } catch (Exception e) {

        }
        System.out.println(SaManager.getSaTokenSecondContext());
        // 获取request
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        // 设置IP地址
        sysLog.setIp(IPUtils.getIpAddr(request));
        log.info(
                "Ip{}，接口地址{}，请求方式{}，入参：{}",
                sysLog.getIp(),
                request.getRequestURL(),
                request.getMethod(),
                sysLog.getParams());

//            账号
        String account = StpUtil.getTokenSession().getString("ACCOUNT");
//            用户iD
        String loginId = StpUtil.getTokenSession().getString("LOGIN_ID");
//            用户名
        String userName = StpUtil.getTokenSession().getString("USER_NAME");

        sysLog.setUsername(account);
        sysLog.setUserId(loginId);
        sysLog.setType(logAnnotation.type());
        sysLog.setTime((int) time);
        sysLog.setId(UUID.randomUUID().toString());
        sysLog.setCreateTime(DateTimeUI.getCurrentDateTime());
        // 保存数据库
        AsyncManager.me().execute(recordOper(sysLog));

        log.info(sysLog.toString());
    }

    /**
     * 操作日志记录
     *
     * @param operLog 操作日志信息
     * @return 任务task
     */
    public TimerTask recordOper(SysLog operLog) {
        return new TimerTask() {
            @Override
            public void run() {
                sysLogMapper.insert(operLog);
            }
        };
    }
}
