package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysPermissionService;
import com.example.frame.entity.SysPermission;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

/**
 * <p>
 * 系统权限 前端控制器
 * </p>
 *
 * @author
 * @since 2021-11-02
 */
@Api(tags = {"系统权限"})
@Slf4j
@Controller
@RequestMapping("/sysPermission")
public class SysPermissionController {

    @Resource
    private ISysPermissionService sysPermissionService;


    @ApiOperation(value = "新增系统权限")
    @PostMapping("/add")
    @LogAnnotation(title = "系统权限", action = "新增系统权限")
    @ResponseBody
    @SaCheckPermission("sysPermission-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysPermission sysPermission) {
        sysPermission.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysPermission.setId(RandomGUID.getDateUUID());
        sysPermissionService.save(sysPermission);
        return DataResult.success();
    }

    @ApiOperation(value = "删除系统权限")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "系统权限", action = "删除系统权限")
    @ResponseBody
    @SaCheckPermission("sysPermission-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestParam String id) {

        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("pid", id);
        sysPermissionService.remove(queryWrapper);
        sysPermissionService.removeById(id);
        return DataResult.success();
    }

    @ApiOperation(value = "更新系统权限")
    @PutMapping("/update")
    @LogAnnotation(title = "系统权限", action = "更新系统权限")
    @ResponseBody
    @SaCheckPermission("sysPermission-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysPermission sysPermission) {
        sysPermission.setUpdateTime(DateTimeUI.getCurrentDateTime());
        sysPermissionService.updateById(sysPermission);
        return DataResult.success();
    }

    @ApiOperation(value = "查询系统权限分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysPermission-listByPage")
    public DataResult findListByPage(@RequestBody SysPermission sysPermission) {
        Page page = new Page(sysPermission.getPage(), sysPermission.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        //菜单权限类型(1:目录;2:菜单;3:按钮)
        queryWrapper.eq("type", "1");
        queryWrapper.eq("PID", "0");
        queryWrapper.orderByAsc("ORDER_NUM");
        IPage<SysPermission> iPage = sysPermissionService.page(page, queryWrapper);
        if (!iPage.getRecords().isEmpty()) {
            for (SysPermission sysPermission1 : iPage.getRecords()) {
                QueryWrapper queryWrapper1 = new QueryWrapper();
                queryWrapper1.eq("pid", sysPermission1.getId());
                queryWrapper1.orderByAsc("ORDER_NUM");
                List<SysPermission> list = sysPermissionService.list(queryWrapper1);
                for (SysPermission sysPermission2 : list) {
                    sysPermission2.setPidName(sysPermission1.getName());
                }
                sysPermission1.setChildren(list);

            }
        }
        return DataResult.success(iPage);
    }

    @ApiOperation(value = "查询系统权限树数据")
    @PostMapping("/listByTree")
    @ResponseBody
    @SaCheckPermission("sysPermission-listByTree")
    public DataResult listByTree(@RequestBody SysPermission sysPermission) {
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        queryWrapper.eq("type", sysPermission.getType());  //菜单权限类型(1:目录;2:菜单;3:按钮)
        queryWrapper.eq("PID", "0");
        queryWrapper.orderByAsc("ORDER_NUM");
        List<SysPermission> sysPermissionList = sysPermissionService.list(queryWrapper);
        if (!sysPermissionList.isEmpty()) {
            for (SysPermission sysPermission1 : sysPermissionList) {
                QueryWrapper queryWrapper1 = new QueryWrapper();
                queryWrapper1.eq("pid", sysPermission1.getId());
                queryWrapper1.orderByAsc("ORDER_NUM");
                List<SysPermission> list = sysPermissionService.list(queryWrapper1);
                for (SysPermission sysPermission2 : list) {
                    sysPermission2.setPidName(sysPermission1.getName());
                }
                sysPermission1.setChildren(list);

            }
        }
        return DataResult.success(sysPermissionList);
    }


    @ApiOperation(value = "查询系统权限List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("sysPermission-listByCondition")
    public DataResult listByCondition(@RequestBody SysPermission sysPermission) {
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        queryWrapper.eq("type", sysPermission.getType());  //菜单权限类型(1:目录;2:菜单;3:按钮)
        if (!StringUtil.isNullorEmpty(sysPermission.getPid())) {
            queryWrapper.eq("pid", sysPermission.getPid());
        }
        if (!StringUtil.isNullorEmpty(sysPermission.getId())) {
            queryWrapper.ne("id", sysPermission.getId());
        }

        queryWrapper.orderByAsc("ORDER_NUM");
        return DataResult.success(sysPermissionService.list(queryWrapper));
    }


    @ApiOperation(value = "根据id查询单条系统权限数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysPermission-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysPermissionService.getById(id));
    }
}
