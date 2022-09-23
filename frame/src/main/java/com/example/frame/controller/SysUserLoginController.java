package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.exception.BusinessException;
import com.example.frame.common.exception.code.BaseResponseCode;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.entity.SysUserLogin;
import com.example.frame.entity.SysUserLoginView;
import com.example.frame.service.ISysUserLoginService;
import com.example.frame.service.ISysUserLoginViewService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;


/**
 * <p>
 * 用户登录账号表 前端控制器
 * </p>
 *
 * @author sya
 */
@Api(tags = {"用户登录账号表"})
@Slf4j
@Controller
@RequestMapping("/sysUserLogin")
public class SysUserLoginController {

    @Resource
    private ISysUserLoginService sysUserLoginService;
    @Resource
    private ISysUserLoginViewService sysUserLoginViewService;


    @ApiOperation(value = "新增用户登录账号表")
    @PostMapping("/add")
    @LogAnnotation(title = "用户登录账号表", action = "新增用户登录账号表")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysUserLogin sysUserLogin) {
        sysUserLogin.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysUserLogin.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysUserLogin.setId(RandomGUID.getDateUUID());
        sysUserLoginService.save(sysUserLogin);
        return DataResult.success();
    }

    @ApiOperation(value = "删除用户登录账号表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "用户登录账号表", action = "删除用户登录账号表")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        sysUserLoginService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新用户登录账号表")
    @PutMapping("/update")
    @LogAnnotation(title = "用户登录账号表", action = "更新用户登录账号表")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysUserLogin sysUserLogin) {
        sysUserLogin.setUpdateTime(DateTimeUI.getCurrentDateTime());
        sysUserLoginService.updateById(sysUserLogin);
        return DataResult.success();
    }

    @ApiOperation(value = "查询用户登录账号表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-listByPage")
    public DataResult listByPage(@RequestBody SysUserLoginView sysUserLoginView) {
        IPage<SysUserLoginView> sysUserLoginViewIPage = sysUserLoginViewService.listPage(sysUserLoginView);
        if (!sysUserLoginViewIPage.getRecords().isEmpty()) {
            for (SysUserLoginView userLoginView : sysUserLoginViewIPage.getRecords()) {
                if (userLoginView.getStatus() == 2) {
                    long disableTime = StpUtil.getDisableTime(userLoginView.getId());
                    Double tempTime = Double.valueOf(disableTime) / 60.0;
                    userLoginView.setTime(String.valueOf(Math.round(tempTime * 100) / 100));
                }
            }
        }
        return DataResult.success(sysUserLoginViewIPage);
    }


    @ApiOperation(value = "根据id查询单条用户登录账号表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysUserLoginService.getById(id));
    }


    @ApiOperation(value = "锁定用户")
    @PostMapping("/lockUser")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-lockUser")
    public DataResult lockUser(@RequestBody SysUserLoginView sysUserLoginView) {

        SysUserLoginView sysUserLoginView1 = sysUserLoginViewService.getById(sysUserLoginView.getId());
        SysUserLogin sysUserLogin = new SysUserLogin();
        sysUserLogin.setId(sysUserLoginView.getId());
        if (!StringUtil.isNullorEmpty(sysUserLoginView1)) {
            if ("超级管理员".equals(sysUserLoginView1.getRoleName())) {
                throw new BusinessException(BaseResponseCode.OPERATION_ERRO.getCode(), "超级管理员不允许锁定");
            }

            // 先踢下线
            StpUtil.kickout(sysUserLoginView.getId());

            if ("-1".equals(sysUserLoginView.getTime())) {
                sysUserLogin.setStatus(1);
                StpUtil.disable(sysUserLoginView.getId(), -1);
            } else {
                int time = Integer.parseInt(sysUserLoginView.getTime()) * 60;
                StpUtil.disable(sysUserLoginView.getId(), time);
                sysUserLogin.setStatus(2);
            }
        }
        sysUserLoginService.updateById(sysUserLogin);
        return DataResult.success();

    }

    @ApiOperation(value = "解锁用户")
    @PostMapping("/untieUser")
    @ResponseBody
    @SaCheckPermission("sysUserLogin-untieUser")
    public DataResult untieUser(@RequestParam String id) {
        SysUserLogin sysUserLogin = new SysUserLogin();
        sysUserLogin.setId(id);
        sysUserLogin.setStatus(0);
        sysUserLoginService.updateById(sysUserLogin);
        StpUtil.untieDisable(id);
        return DataResult.success();

    }

}
