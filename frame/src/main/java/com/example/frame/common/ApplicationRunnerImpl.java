package com.example.frame.common;


import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.hutool.core.io.resource.ResourceUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.frame.common.utils.*;
import com.example.frame.entity.*;
import com.example.frame.mapper.SysRolePermissionMapper;
import com.example.frame.mapper.SysUserRoleMapper;
import com.example.frame.service.*;
import com.example.frame.websocket.WebsocketClientUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.*;
import java.lang.reflect.Method;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.text.ParseException;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

/**
 * @author sya
 * Created by Administrator on 2021年12月21日09:16:32
 * 项目自启动 执行方法
 **/
@Component
@Slf4j
public class ApplicationRunnerImpl implements ApplicationRunner {
    private static final Logger logger = LoggerFactory.getLogger(ApplicationRunnerImpl.class);

    @Resource
    private ISysPermissionService sysPermissionService;
    @Resource
    private ISysRolePermissionService sysRolePermissionService;
    @Resource
    private WebsocketClientUtil websocketClientUtil;
    @Resource
    private RedisUtil redisUtil;
    @Resource
    private ISysUserLoginService sysUserLoginService;
    @Resource
    private SysRolePermissionMapper sysRolePermissionMapper;
    @Resource
    private IIpBlacklistInfoService iIpBlacklistInfoService;
    @Resource
    private IWhiteRegionInfoService whiteRegionInfoService;
    @Resource
    private SysUserRoleMapper sysUserRoleMapper;


    @Value("${spring.interceptIp}")
    private boolean interceptIp;
    @Value("${spring.interceptCity}")
    private boolean interceptCity;


    @Override
    public void run(ApplicationArguments args) throws Exception {
        /* 自动配置权限*/
        //autoConfigurationPower();
        /*初始化 限制IP和城市*/
        initInterceptIpAndCity();


        /*websocket调用基站平台数据*/
        //websocketClientUtil.sendWebsocket();

    }


    /**
     * 初始化权限 存redis
     */
    public void initSysPermissionInRedis() {
        for (SysUserLogin sysUserLogin : sysUserLoginService.list()) {
            /*删除该key*/
            redisUtil.delete("sysPermission:" + sysUserLogin.getId());
            redisUtil.delete("sysRole:" + sysUserLogin.getId());

            List<String> list = sysRolePermissionMapper.showRolePermissionByLoginId(sysUserLogin.getId());
            for (String permission : list) {
                redisUtil.lpush("sysPermission:" + sysUserLogin.getId(), permission);
            }

            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("USER_ID", sysUserLogin.getId());
            queryWrapper.select("ROLE_ID");
            redisUtil.lpush("sysRole:" + sysUserLogin.getId(), sysUserRoleMapper.selectObjs(queryWrapper));

        }
    }

    /**
     * 按钮权限自动配置
     */
    public void autoConfigurationPower() {
        logger.info("---------- 自动识别controller权限配置存库------开始-----------");
        /* 清空超级管理员所有权限 */
        sysRolePermissionMapper.removePower("11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9");
        try {
            Set<Class<?>> classes = getClasses("com.example.frame.controller");
            for (Class c : classes) {
                //controller头 api value
                Api api = (Api) c.getAnnotation(Api.class);
                if (!StringUtil.isNullorEmpty(api)) {
                    //controller头 RequestMapping value
                    String request = ((RequestMapping) c.getAnnotation(RequestMapping.class)).value()[0];
                    String pid = "";
                    /* 入库 父级权限 */
                    QueryWrapper queryWrapper = new QueryWrapper();
                    queryWrapper.eq("name", api.tags()[0]);
                    queryWrapper.eq("pid", "0");
                    //菜单权限类型(1:目录;2:菜单;3:按钮)
                    queryWrapper.eq("type", "3");
                    SysPermission sysPermission1 = sysPermissionService.getOne(queryWrapper);
                    if (StringUtil.isNullorEmpty(sysPermission1)) {
                        SysPermission sysPermission2 = new SysPermission();
                        sysPermission2.setId(RandomGUID.getDateUUID());
                        sysPermission2.setName(api.tags()[0]);
                        sysPermission2.setCreateTime(DateTimeUI.getCurrentDateTime());
                        sysPermission2.setDeleted(0);
                        //菜单权限类型(1:目录;2:菜单;3:按钮)
                        sysPermission2.setType("3");
                        //状态1:正常 0：禁用
                        sysPermission2.setStatus("1");
                        sysPermission2.setPid("0");
                        sysPermissionService.save(sysPermission2);
                        pid = sysPermission2.getId();
                    } else {
                        pid = sysPermission1.getId();
                    }

                    //获取类中所有的方法
                    Method[] methods = c.getDeclaredMethods();
                    for (Method method : methods) {
                        ApiOperation apiOperation = method.getAnnotation(ApiOperation.class);
                        GetMapping getRequestMothed = method.getAnnotation(GetMapping.class);
                        PutMapping putRequestMothed = method.getAnnotation(PutMapping.class);
                        PostMapping postRequestMothed = method.getAnnotation(PostMapping.class);
                        DeleteMapping deleteRequestMothed = method.getAnnotation(DeleteMapping.class);
                        SaCheckPermission saCheckPermissionMothed = method.getAnnotation(SaCheckPermission.class);

                        /* ApiOperation SaCheckRole 不为空 才入库*/
                        if (!StringUtil.isNullorEmpty(apiOperation) && !StringUtil.isNullorEmpty(saCheckPermissionMothed)) {

                            String permissionMethod = "";
                            String permissionUrl = "";

                            if (!StringUtil.isNullorEmpty(getRequestMothed)) {
                                permissionMethod = "GET";
                                permissionUrl = request + getRequestMothed.value()[0];
                            }
                            if (!StringUtil.isNullorEmpty(putRequestMothed)) {
                                permissionMethod = "PUT";
                                permissionUrl = request + putRequestMothed.value()[0];
                            }
                            if (!StringUtil.isNullorEmpty(postRequestMothed)) {
                                permissionMethod = "POST";
                                permissionUrl = request + postRequestMothed.value()[0];
                            }
                            if (!StringUtil.isNullorEmpty(deleteRequestMothed)) {
                                permissionMethod = "DELETE";
                                permissionUrl = request + deleteRequestMothed.value()[0];
                            }

                            /*保存或修改 权限*/
                            saveOrUpdateSysPermission(pid, saCheckPermissionMothed.value()[0], apiOperation.value(), permissionMethod, permissionUrl);


                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        /**
         * 初始化权限 储存redis
         * */
        initSysPermissionInRedis();

        logger.info("---------- 自动识别controller权限配置存库------完成-----------");
    }


    public void saveOrUpdateSysPermission(String pid, String perms, String name, String method, String url) {

        QueryWrapper queryWrapper1 = new QueryWrapper();
        queryWrapper1.eq("url", url);
        queryWrapper1.eq("method", method);
        queryWrapper1.eq("pid", pid);
        //菜单权限类型(1:目录;2:菜单;3:按钮)
        queryWrapper1.eq("type", "3");
        SysPermission sysPermission = sysPermissionService.getOne(queryWrapper1);

        if (StringUtil.isNullorEmpty(sysPermission)) {
            //没有则增加
            sysPermission = new SysPermission();
            sysPermission.setId(RandomGUID.getDateUUID());
            sysPermission.setCreateTime(DateTimeUI.getCurrentDateTime());
        } else {
            sysPermission.setUpdateTime(DateTimeUI.getCurrentDateTime());
        }

        sysPermission.setPid(pid);
        sysPermission.setDeleted(0);
        sysPermission.setPerms(perms);
        sysPermission.setName(name);
        sysPermission.setUrl(url);
        sysPermission.setMethod(method);
        //菜单权限类型(1:目录;2:菜单;3:按钮)
        sysPermission.setType("3");
        //状态1:正常 0：禁用
        sysPermission.setStatus("1");
        sysPermissionService.saveOrUpdate(sysPermission);


        /* 超级管理员角色默认添加所有权限*/
        saveAdminPermission(sysPermission.getId());


    }

    public void saveAdminPermission(String id) {

        SysRolePermission sysRolePermission = new SysRolePermission();
        sysRolePermission.setId(RandomGUID.getDateUUID());
        sysRolePermission.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysRolePermission.setPermissionId(id);
        sysRolePermission.setRoleId("11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9");
        sysRolePermissionService.save(sysRolePermission);
    }

    /**
     * 初始化限制ip和城市
     */
    private void initInterceptIpAndCity() {

        if (interceptCity) {
            List<WhiteRegionInfo> whiteRegionInfos = whiteRegionInfoService.list();
            for (WhiteRegionInfo whiteRegionInfo : whiteRegionInfos) {
                redisUtil.set("whiteRegion:" + whiteRegionInfo.getRegion() + ":" + whiteRegionInfo.getCity(), "白名单");
            }
        }

        if (interceptIp) {
            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("type", 1);
            List<IpBlacklistInfo> ipBlacklistInfos = iIpBlacklistInfoService.list(queryWrapper);


            for (IpBlacklistInfo ipBlacklistInfo : ipBlacklistInfos) {
                try {
                    long time = -1;

                    if (!"-1".equals(ipBlacklistInfo.getEffectiveTime())) {
                        String banEndTime = DateUtils.getTimeByHour(ipBlacklistInfo.getCreateTime(), Integer.parseInt(ipBlacklistInfo.getEffectiveTime()));

                        Date date = DateTimeUI.parse(banEndTime, DateUtils.YYYY_MM_DD_HH_MM_SS);
                        Date cDate = new Date();

                        if (date.getTime() > cDate.getTime()) {
                            long nm = 1000 * 60;
                            long diff = date.getTime() - cDate.getTime();
                            // 计算差多少小时
                            time = diff / nm;

                        }
                    }
                    redisUtil.set("backListIp:" + ipBlacklistInfo.getIp(), "*", time, TimeUnit.MINUTES);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

            }
        }


    }


    /**
     * 根据包名获取包下面所有的类名
     *
     * @param pack
     * @return
     * @throws Exception
     */
    public static Set<Class<?>> getClasses(String pack) throws Exception {
        // 第一个class类的集合
        Set<Class<?>> classes = new LinkedHashSet<Class<?>>();
        // 是否循环迭代
        boolean recursive = true;
        // 获取包的名字 并进行替换
        String packageName = pack;
        String packageDirName = packageName.replace('.', '/');
        // 定义一个枚举的集合 并进行循环来处理这个目录下的things
        Enumeration<URL> dirs;
        try {
            dirs = Thread.currentThread().getContextClassLoader().getResources(packageDirName);
            // 循环迭代下去
            while (dirs.hasMoreElements()) {
                // 获取下一个元素
                URL url = dirs.nextElement();
                // 得到协议的名称
                String protocol = url.getProtocol();
                // 如果是以文件的形式保存在服务器上
                if ("file".equals(protocol)) {
                    // 获取包的物理路径
                    String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
                    // 以文件的方式扫描整个包下的文件 并添加到集合中
                    findClassesInPackageByFile(packageName, filePath, recursive, classes);
                } else if ("jar".equals(protocol)) {
                    // 如果是jar包文件
                    // 定义一个JarFile
                    System.out.println("jar类型的扫描");
                    JarFile jar;
                    try {
                        // 获取jar
                        jar = ((JarURLConnection) url.openConnection()).getJarFile();
                        // 从此jar包 得到一个枚举类
                        Enumeration<JarEntry> entries = jar.entries();
                        findClassesInPackageByJar(packageName, entries, packageDirName, recursive, classes);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return classes;
    }

    /**
     * 以jar的形式来获取包下的所有Class
     *
     * @param packageName
     * @param entries
     * @param packageDirName
     * @param recursive
     * @param classes
     */
    private static void findClassesInPackageByJar(String packageName, Enumeration<JarEntry> entries, String packageDirName, final boolean recursive, Set<Class<?>> classes) {
        // 同样的进行循环迭代
        while (entries.hasMoreElements()) {
            // 获取jar里的一个实体 可以是目录 和一些jar包里的其他文件 如META-INF等文件
            JarEntry entry = entries.nextElement();
            String name = entry.getName();
            // 如果是以/开头的
            if (name.charAt(0) == '/') {
                // 获取后面的字符串
                name = name.substring(1);
            }
            // 如果前半部分和定义的包名相同
            if (name.startsWith(packageDirName)) {
                int idx = name.lastIndexOf('/');
                // 如果以"/"结尾 是一个包
                if (idx != -1) {
                    // 获取包名 把"/"替换成"."
                    packageName = name.substring(0, idx).replace('/', '.');
                }
                // 如果可以迭代下去 并且是一个包
                if ((idx != -1) || recursive) {
                    // 如果是一个.class文件 而且不是目录
                    if (name.endsWith(".class") && !entry.isDirectory()) {
                        // 去掉后面的".class" 获取真正的类名
                        String className = name.substring(packageName.length() + 1, name.length() - 6);
                        try {
                            // 添加到classes
                            classes.add(Class.forName(packageName + '.' + className));
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }

    /**
     * 以文件的形式来获取包下的所有Class
     *
     * @param packageName
     * @param packagePath
     * @param recursive
     * @param classes
     */

    private static void findClassesInPackageByFile(String packageName, String packagePath, final boolean recursive, Set<Class<?>> classes) {
        // 获取此包的目录 建立一个File
        File dir = new File(packagePath);
        // 如果不存在或者 也不是目录就直接返回
        if (!dir.exists() || !dir.isDirectory()) {
            return;
        }
        // 如果存在 就获取包下的所有文件 包括目录
        File[] dirfiles = dir.listFiles(new FileFilter() {
            // 自定义过滤规则 如果可以循环(包含子目录) 或则是以.class结尾的文件(编译好的java类文件)
            @Override
            public boolean accept(File file) {
                return (recursive && file.isDirectory()) || (file.getName().endsWith(".class"));
            }
        });
        // 循环所有文件
        for (File file : dirfiles) {
            // 如果是目录 则继续扫描
            if (file.isDirectory()) {
                findClassesInPackageByFile(packageName + "." + file.getName(), file.getAbsolutePath(), recursive, classes);
            } else {
                // 如果是java类文件 去掉后面的.class 只留下类名
                String className = file.getName().substring(0, file.getName().length() - 6);
                try {
                    // 添加到集合中去
                    // classes.add(Class.forName(packageName + '.' +
                    // className));
                    classes.add(Thread.currentThread().getContextClassLoader().loadClass(packageName + '.' + className));
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }
            }
        }
    }


}