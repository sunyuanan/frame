package com.example.frame.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysUserRoleService;
import com.example.frame.entity.SysUserRole;
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
 * 系统用户角色 前端控制器
 * </p>
 *
 * @since 2021-11-02
 */
@Api(tags = {"系统用户角色"})
@Slf4j
@Controller
@RequestMapping("/sysUserRole")
public class SysUserRoleController {

    @Resource
    private ISysUserRoleService sysUserRoleService;


    @ApiOperation(value = "新增系统用户角色")
    @PostMapping("/add")
    @LogAnnotation(title = "系统用户角色", action = "新增系统用户角色")
    @ResponseBody
    @SaCheckPermission("sysUserRole-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysUserRole sysUserRole) {
        sysUserRole.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysUserRole.setId(RandomGUID.getDateUUID());
        sysUserRoleService.save(sysUserRole);
        return DataResult.success();
    }

    @ApiOperation(value = "删除系统用户角色")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "系统用户角色", action = "删除系统用户角色")
    @ResponseBody
    @SaCheckPermission("sysUserRole-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        sysUserRoleService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新系统用户角色")
    @PutMapping("/update")
    @LogAnnotation(title = "系统用户角色", action = "更新系统用户角色")
    @ResponseBody
    @SaCheckPermission("sysUserRole-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysUserRole sysUserRole) {
        sysUserRoleService.updateById(sysUserRole);
        return DataResult.success();
    }

    @ApiOperation(value = "查询系统用户角色分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysUserRole-listByPage")
    public DataResult findListByPage(@RequestBody SysUserRole sysUserRole) {
        Page page = new Page(sysUserRole.getPage(), sysUserRole.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        //queryWrapper.eq("id", sysUserRole.getId());
        IPage<SysUserRole> iPage = sysUserRoleService.page(page,
                queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条系统用户角色数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysUserRole-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysUserRoleService.getById(id));
    }
}
