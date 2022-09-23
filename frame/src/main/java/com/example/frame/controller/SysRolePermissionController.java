package com.example.frame.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.entity.SysPermission;
import com.example.frame.mapper.SysPermissionMapper;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysRolePermissionService;
import com.example.frame.entity.SysRolePermission;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import cn.dev33.satoken.annotation.SaCheckPermission;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

/**
 * <p>
 * 系统角色权限 前端控制器
 * </p>
 *
 * @since 2021-11-02
 */
@Api(tags = {"系统角色权限"})
@Slf4j
@Controller
@RequestMapping("/sysRolePermission")
public class SysRolePermissionController {

    @Resource
    private ISysRolePermissionService sysRolePermissionService;
    @Resource
    private SysPermissionMapper sysPermissionMapper;

    @ApiOperation(value = "新增系统角色权限")
    @PostMapping("/add")
    @LogAnnotation(title = "系统角色权限", action = "新增系统角色权限")
    @ResponseBody
    @SaCheckPermission("sysRolePermission-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysRolePermission sysRolePermission) {
        sysRolePermission.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysRolePermission.setId(RandomGUID.getDateUUID());
        sysRolePermissionService.save(sysRolePermission);
        return DataResult.success();
    }

    @ApiOperation(value = "删除系统角色权限")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "系统角色权限", action = "删除系统角色权限")
    @ResponseBody
    @SaCheckPermission("sysRolePermission-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        sysRolePermissionService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新系统角色权限")
    @PutMapping("/update")
    @LogAnnotation(title = "系统角色权限", action = "更新系统角色权限")
    @ResponseBody
    @SaCheckPermission("sysRolePermission-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysRolePermission sysRolePermission) {
        sysRolePermissionService.updateById(sysRolePermission);
        return DataResult.success();
    }

    @ApiOperation(value = "查询系统角色权限分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysRolePermission-listByPage")
    public DataResult findListByPage(@RequestBody SysRolePermission sysRolePermission) {
        Page page = new Page(sysRolePermission.getPage(), sysRolePermission.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        //queryWrapper.eq("id", sysRolePermission.getId());
        IPage<SysRolePermission> iPage = sysRolePermissionService.page(page,
                queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条系统角色权限数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysRolePermission-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysRolePermissionService.getById(id));
    }


    @ApiOperation(value = "根据条件查询List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("sysRolePermission-listByCondition")
    public DataResult listByCondition(@RequestBody SysRolePermission sysRolePermission) {

        List<String> menusList = new LinkedList<>();

        List<SysPermission> menus = sysPermissionMapper.getFirstMenus(sysRolePermission.getRoleId(), "0",1);
        if (!menus.isEmpty()) {
            for (SysPermission sysPermission : menus) {
                List<SysPermission> secondMenus = sysPermissionMapper.getFirstMenus(sysRolePermission.getRoleId(), sysPermission.getId(),2);
                if (secondMenus.isEmpty()) {
                    menusList.add(sysPermission.getId());
                }
                for (SysPermission sysPermission1 : secondMenus) {
                    menusList.add(sysPermission1.getId());
                }
            }

        }

        List<String> permissionList = sysRolePermissionService.selectPermission(sysRolePermission.getRoleId(), "3");

        Map map = new HashMap();
        map.put("menusList", menusList);
        map.put("permissionList", permissionList);

        return DataResult.success(map);
    }
}
