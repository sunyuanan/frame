package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.stp.StpUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.*;
import com.example.frame.entity.SysLog;
import com.example.frame.entity.SysUserLoginView;
import com.example.frame.mapper.SysLogMapper;
import com.example.frame.vo.req.LoginReqVO;
import com.example.frame.vo.resp.LoginRespVO;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysUserService;
import com.example.frame.entity.SysUser;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.io.File;
import java.util.LinkedList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * <p>
 * 系统用户 前端控制器
 * </p>
 *
 * @since 2021-10-26
 */
@Api(tags = {"系统用户"})
@Slf4j
@RequestMapping("/sysUser")
@RestController
public class SysUserController {

    @Resource
    private ISysUserService sysUserService;

    @Resource
    private SysLogMapper sysLogMapper;

    @PostMapping(value = "/login")
    @ApiOperation(value = "用户登录接口")
    @LogAnnotation(title = "用户管理", action = "登录", type = 1)
    public DataResult<LoginRespVO> login(@RequestBody @Valid LoginReqVO vo) {
        DataResult<LoginRespVO> result = DataResult.success();
        result.setData(sysUserService.login(vo));
        return result;

    }


    @PostMapping("/logout")
    @ApiOperation(value = "用户登出接口")
    @LogAnnotation(title = "用户登出接口", action = "用户登出接口")
    public DataResult logout() {
        StpUtil.logout();
        return DataResult.success();
    }


    @ApiOperation(value = "新增系统用户")
    @PostMapping("/add")
    @LogAnnotation(title = "系统用户", action = "新增系统用户")
    @ResponseBody
    @SaCheckPermission("sysUser-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody @Valid SysUserLoginView sysUserLoginView) {
        sysUserService.add(sysUserLoginView);
        return DataResult.success();
    }

    @ApiOperation(value = "删除系统用户")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "系统用户", action = "删除系统用户")
    @ResponseBody
    @SaCheckPermission("sysUser-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {

        sysUserService.delete(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新系统用户")
    @PutMapping("/update")
    @LogAnnotation(title = "系统用户", action = "更新系统用户")
    @ResponseBody
    @SaCheckPermission("sysUser-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysUserLoginView sysUserLoginView) {
        sysUserService.updateUserInfo(sysUserLoginView);
        return DataResult.success();
    }

    @ApiOperation(value = "查询系统用户分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysUser-listByPage")
    public DataResult findListByPage(@RequestBody SysUser sysUser) {
        Page page = new Page(sysUser.getPage(), sysUser.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        //queryWrapper.eq("id", sysUser.getId());
        IPage<SysUser> iPage = sysUserService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条系统用户数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysUser-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysUserService.getById(id));
    }


    @ApiOperation(value = "查询盘符空间")
    @PostMapping("/diskInfo")
    @ResponseBody
    @SaCheckPermission("sysUser-diskInfo")
    public DataResult diskInfo() {
        List list = new LinkedList();
        File[] arFileRoot = File.listRoots();
        for (int i = 0; i < arFileRoot.length; i++) {

            File f = new File(arFileRoot[i].getAbsolutePath());
            long freeSpace = f.getFreeSpace();
            long totalSpace = f.getTotalSpace();

            Double ky = f.getFreeSpace() / 1073741824.0;

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", arFileRoot[i].getAbsolutePath().split(":")[0]);
            jsonObject.put("available", ky.floatValue());
            jsonObject.put("used", (totalSpace - freeSpace) / 1073741824);
            jsonObject.put("total", f.getTotalSpace() / 1073741824);
            list.add(jsonObject);

        }


        return DataResult.success(list);

    }


    @ApiOperation(value = "获取菜单")
    @PostMapping("/getAllMenus")
    @ResponseBody
    @SaCheckPermission("sysUser-getAllMenus")
    public DataResult getAllMenus(@RequestParam(value = "roleId") String roleId) {
        return DataResult.success(sysUserService.getAllMenus(roleId));
    }



}


