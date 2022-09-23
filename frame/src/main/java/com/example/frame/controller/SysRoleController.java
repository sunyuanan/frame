package com.example.frame.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.exception.BusinessException;
import com.example.frame.common.exception.code.BaseResponseCode;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.entity.SysRolePermission;
import com.example.frame.service.ISysRolePermissionService;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysRoleService;
import com.example.frame.entity.SysRole;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

import cn.dev33.satoken.annotation.SaCheckPermission;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

/**
 * <p>
 * 系统角色 前端控制器
 * </p>
 *
 * @since 2021-11-04
 */
@Api(tags = {"系统角色"})
@Slf4j
@Controller
@RequestMapping("/sysRole")
public class SysRoleController {

    @Resource
    private ISysRoleService sysRoleService;
    @Resource
    private ISysRolePermissionService sysRolePermissionService;


    @ApiOperation(value = "新增系统角色")
    @PostMapping("/add")
    @LogAnnotation(title = "系统角色", action = "新增系统角色")
    @ResponseBody
    @SaCheckPermission("sysRole-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysRole sysRole) {
        sysRole.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysRole.setId(RandomGUID.getDateUUID());
        //      权限  存入redis
        sysRolePermissionService.saveRolePermission(sysRole.getPermissionList(), sysRole.getId());
        sysRole.setDeleted(1);
        sysRoleService.save(sysRole);
        return DataResult.success();
    }

    @ApiOperation(value = "删除系统角色")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "系统角色", action = "删除系统角色")
    @ResponseBody
    @SaCheckPermission("sysRole-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        if ("11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9".equals(ids.get(0))) {
            throw new BusinessException(BaseResponseCode.OPERATION_ERRO.getCode(), "超级管理员不允许删除");
        }
        sysRoleService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新系统角色")
    @PutMapping("/update")
    @LogAnnotation(title = "系统角色", action = "更新系统角色")
    @ResponseBody
    @SaCheckPermission("sysRole-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysRole sysRole) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("role_id", sysRole.getId());
        sysRolePermissionService.remove(queryWrapper);
        //      权限  存入redis
        sysRolePermissionService.saveRolePermission(sysRole.getPermissionList(), sysRole.getId());
        sysRole.setUpdateTime(DateTimeUI.getCurrentDateTime());
        sysRoleService.updateById(sysRole);
        return DataResult.success();
    }

    @ApiOperation(value = "查询系统角色分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysRole-listByPage")
    public DataResult findListByPage(@RequestBody SysRole sysRole) {
        Page page = new Page(sysRole.getPage(), sysRole.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        if (!StringUtil.isNullorEmpty(sysRole.getName())) {
            queryWrapper.like("name", sysRole.getName());
        }
        IPage<SysRole> iPage = sysRoleService.page(page,
                queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条系统角色数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysRole-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysRoleService.getById(id));
    }


    @ApiOperation(value = "根据条件查询系统角色List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("sysRole-listByCondition")
    public DataResult listByCondition(@RequestBody SysRole sysRole) {
        QueryWrapper queryWrapper = new QueryWrapper();
        return DataResult.success(sysRoleService.list(queryWrapper));
    }

}
