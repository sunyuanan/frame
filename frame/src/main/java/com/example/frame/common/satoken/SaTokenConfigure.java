package com.example.frame.common.satoken;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.filter.SaServletFilter;
import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.jwt.StpLogicJwtForSimple;
import cn.dev33.satoken.router.SaHttpMethod;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.stp.StpLogic;
import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.config.AsyncManager;
import com.example.frame.common.ipdb.City;
import com.example.frame.common.ipdb.CityInfo;
import com.example.frame.common.utils.*;
import com.example.frame.entity.SysInterceptLog;
import com.example.frame.mapper.SysInterceptLogMapper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.TimerTask;
import java.util.UUID;


/**
 * @author sya
 * @Date 2021/12/18 21:47
 */
@Configuration
@Slf4j
public class SaTokenConfigure implements WebMvcConfigurer {
    private static final Logger logger = LoggerFactory.getLogger(SaTokenConfigure.class);

    @Resource
    private SysInterceptLogMapper sysInterceptLogMapper;
    @Resource
    private RedisUtil redisUtil;

    @Value("${spring.interceptIp}")
    private boolean interceptIp;
    @Value("${spring.interceptCity}")
    private boolean interceptCity;


    /**
     * 免权限地址配置
     */
    public List<String> getExcludePatterns() {
        //排除模式list
        List<String> excludePatterns = new LinkedList<>();
        excludePatterns.add("/login");
        excludePatterns.add("/main");
        excludePatterns.add("/doc.html");
        excludePatterns.add("/swagger-ui.html");
        excludePatterns.add("/swagger-resources/**");
        excludePatterns.add("/v2/api-docs");
        excludePatterns.add("/v2/api-docs-ext");
        excludePatterns.add("/webjars/**");
        excludePatterns.add("/druid/**");
        excludePatterns.add("/service-worker.js");
        excludePatterns.add("/sysUser/login");
        excludePatterns.add("/css/**");
        excludePatterns.add("/js/**");
        excludePatterns.add("/lib/**");
        excludePatterns.add("/static/**");
        excludePatterns.add("/websocket/**");
        excludePatterns.add("/test/**");
        return excludePatterns;
    }

    /**
     * 注册 [Sa-Token全局过滤器]
     */
    @Bean
    public SaServletFilter getSaServletFilter() {
        return new SaServletFilter()
//                // 指定 拦截路由 与 放行路由
                .addInclude("/**")
                .addExclude("/favicon.ico")

                // 认证函数: 每次请求执行
                .setAuth(obj -> {
                    //获取排除模式list
                    List<String> excludePatterns = getExcludePatterns();

                    // 登录认证 -- 拦截所有路由，并排除excludePatterns 用于开放登录
                    SaRouter.notMatch(excludePatterns).check(() -> StpUtil.checkLogin());
                })
                // 异常处理函数：每次认证函数发生异常时执行此函数
                .setError(e -> {
                    logger.info("---------- 进入Sa-Token异常处理 -----------");
                    saveInterceptLog(e.getMessage());

                    /*异常后退出清redis 缓存*/
                    StpUtil.logout();

                    return JSON.toJSONString(DataResult.fail(404040, e.getMessage()));
                })
                // 前置函数：在每次认证函数之前执行
                .setBeforeAuth(obj -> {
                    // ---------- 设置跨域响应头 ----------
                    SaHolder.getResponse()
                            // 允许指定域访问跨域资源
                            .setHeader("Access-Control-Allow-Origin", "*")
                            // 允许所有请求方式
                            .setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE,PUT")
                            // 有效时间
                            .setHeader("Access-Control-Max-Age", "3600")
                            // 允许的header参数
                            .setHeader("Access-Control-Allow-Headers", "*");

                    /* 限制ip demo 利用缓存redis存储黑名单ip */
                    HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
                    String ip = IPUtils.getIpAddr(request);
                    boolean type = true, typeRegion = true;

                    if (interceptIp) {
                        type = getPass(ip, request.getServletPath());
                    }
                    if (interceptCity) {
                        typeRegion = getRegion(ip);
                    }

                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("msg", "您无权访问！");
                    if (!type || !typeRegion) {
                        saveInterceptLog("ip黑名单访问");
                        SaRouter.back(jsonObject);
                    }

                    // 如果是预检请求，则立即返回到前端
                    SaRouter.match(SaHttpMethod.OPTIONS).free(r -> System.out.println("--------OPTIONS预检请求，不做处理")).back();
                });
    }

    /**
     * 保存错误日志信息
     *
     * @param errorInfo
     */
    private void saveInterceptLog(String errorInfo) {

        // 抓取被sa-token拦截的http信息
        HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
        SysInterceptLog sysInterceptLog = new SysInterceptLog();
        /*获取参数*/
        try {

            BufferedReader reader = request.getReader();
            sysInterceptLog.setId(UUID.randomUUID().toString());
            //异常ip
            sysInterceptLog.setIp(IPUtils.getIpAddr(request));
            sysInterceptLog.setParams(reader.readLine());
            sysInterceptLog.setMethod(request.getMethod());
            sysInterceptLog.setRequestUrl(request.getRequestURL().toString());
            sysInterceptLog.setErrorInfo(errorInfo);

        } catch (IOException e1) {
            e1.printStackTrace();
        }

        log.error("sa-token拦截Ip{}，接口地址{}，请求方式{}，入参：{}，错误内容：{}", sysInterceptLog.getIp(), request.getRequestURL(), request.getMethod(), sysInterceptLog.getParams(), errorInfo);

        AsyncManager.me().execute(recordInterceptLog(sysInterceptLog));
    }

    /**
     * 判断ip是否存在黑名单
     *
     * @param ip
     * @param url
     * @return
     */
    public boolean getPass(String ip, String url) {
        Object val = redisUtil.get("backListIp:" + ip);
        if (!StringUtil.isNullorEmpty(val)) {
            if ("*".equals(val)) {
                return false;
            }
            if (url.equals(val)) {
                return false;
            }
        }
        return true;
    }

    /**
     * 判断ip所属城市是否在白名单里
     *
     * @param ip
     * @return
     */
    public boolean getRegion(String ip) {
        try {
            if ("0:0:0:0:0:0:0:1".equals(ip)) {
                return true;
            }

            City db = new City();
            CityInfo info = db.findInfo(ip, "CN");
            if ("局域网".equals(info.getRegionName())) {
                return true;
            }
            boolean type = redisUtil.hasKey("whiteRegion:" + info.getRegionName() + ":" + info.getCityName());

            return type;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    /**
     * Sa-Token 整合 jwt (Style模式)
     */
    @Bean
    public StpLogic getStpLogicJwt() {
        return new StpLogicJwtForSimple();
    }


    /**
     * 操作日志记录
     *
     * @param sysInterceptLog 拦截异常日志信息
     * @return 任务task
     */
    public TimerTask recordInterceptLog(SysInterceptLog sysInterceptLog) {
        return new TimerTask() {
            @Override
            public void run() {
                sysInterceptLogMapper.insert(sysInterceptLog);
            }
        };
    }

    /**
     * 注册Sa-Token的注解拦截器，打开注解式鉴权功能
     *
     * @param registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 注册 Sa-Token 拦截器，打开注解式鉴权功能
        registry.addInterceptor(new SaInterceptor()).addPathPatterns("/**");
    }


}