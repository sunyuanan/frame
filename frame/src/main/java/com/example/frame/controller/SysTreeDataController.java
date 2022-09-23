package com.example.frame.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysTreeDataService;
import com.example.frame.entity.SysTreeData;
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
 * 树形数据 前端控制器
 * </p>
 *
 * @since 2021-11-05
 */
@Api(tags = {"树形数据"})
@Slf4j
@Controller
@RequestMapping("/sysTreeData")
public class SysTreeDataController {

    @Resource
    private ISysTreeDataService sysTreeDataService;


    @ApiOperation(value = "新增树形数据")
    @PostMapping("/add")
    @LogAnnotation(title = "树形数据", action = "新增树形数据")
    @ResponseBody
    @SaCheckPermission("sysTreeData-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysTreeData sysTreeData) {
        sysTreeData.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysTreeData.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysTreeData.setId(RandomGUID.getDateUUID());
        if (!"0".equals(sysTreeData.getSdPid())) {
            SysTreeData sysTreeData1 = sysTreeDataService.getById(sysTreeData.getSdPid());
            //sysTreeData.setType(sysTreeData1.getType());
            sysTreeData.setSdLevel(sysTreeData1.getSdLevel() + 1);
            sysTreeData.setSdPid(sysTreeData1.getId());
            sysTreeData.setPath(sysTreeData1.getPath() + sysTreeData.getId() + "#");
            sysTreeData.setPathName(sysTreeData1.getPathName() + sysTreeData.getSdName() + "#");
            sysTreeData.setSdPath(sysTreeData1.getSdPath() + sysTreeData.getSdCode() + "#");
        } else {
            //sysTreeData.setType(sysTreeData.getSdName());
            sysTreeData.setSdLevel(1);
            sysTreeData.setSdPid("0");
            sysTreeData.setPath("#" + sysTreeData.getId() + "#");
            sysTreeData.setPathName("#" + sysTreeData.getSdName() + "#");
            sysTreeData.setSdPath("#" + sysTreeData.getSdCode() + "#");
        }
        sysTreeDataService.save(sysTreeData);
        return DataResult.success();
    }

    @ApiOperation(value = "删除树形数据")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "树形数据", action = "删除树形数据")
    @ResponseBody
    @SaCheckPermission("sysTreeData-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {

        for (String id : ids) {
            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.like("path", "#" + id + "#");
            sysTreeDataService.remove(queryWrapper);
        }
        return DataResult.success();
    }

    @ApiOperation(value = "更新树形数据")
    @PutMapping("/update")
    @LogAnnotation(title = "树形数据", action = "更新树形数据")
    @ResponseBody
    @SaCheckPermission("sysTreeData-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysTreeData sysTreeData) {

        SysTreeData oldSysTreeData = sysTreeDataService.getById(sysTreeData.getId());
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.like("path", sysTreeData.getId());
        List<SysTreeData> sysTreeDataList = sysTreeDataService.list(queryWrapper);
        for (SysTreeData sysTreeData1 : sysTreeDataList) {

            String oldSdCodePath = sysTreeData1.getSdPath();
            String newSdCodePath = oldSdCodePath.replace("#" + oldSysTreeData.getSdCode() + "#", "#" + sysTreeData.getSdCode() + "#");
            sysTreeData1.setSdPath(newSdCodePath);

            String oldSdNamePath = sysTreeData1.getPathName();
            String newSdNamePath = oldSdNamePath.replace("#" + oldSysTreeData.getSdName() + "#", "#" + sysTreeData.getSdName() + "#");
            sysTreeData1.setPathName(newSdNamePath);

            sysTreeData1.setUpdateTime(DateTimeUI.getCurrentDateTime());
            sysTreeDataService.updateById(sysTreeData1);
        }

        SysTreeData sysTreeData1 = new SysTreeData();
        sysTreeData1.setSdName(sysTreeData.getSdName());
        sysTreeData1.setSdCode(sysTreeData.getSdCode());
        sysTreeData1.setBz(sysTreeData.getBz());
        sysTreeData1.setId(sysTreeData.getId());
        sysTreeDataService.updateById(sysTreeData1);
        return DataResult.success();
    }

    @ApiOperation(value = "查询树形数据分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysTreeData-listByPage")
    public DataResult findListByPage(@RequestBody SysTreeData sysTreeData) {
        Page page = new Page(sysTreeData.getPage(), sysTreeData.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.orderByAsc("sd_level");
        //查询条件示例
        if (!StringUtil.isNullorEmpty(sysTreeData.getSdPid()) && !"0".equals(sysTreeData.getSdPid())) {
            queryWrapper.like("path", "#" + sysTreeData.getSdPid() + "#");
        }
        if (!StringUtil.isNullorEmpty(sysTreeData.getSdName())) {
            queryWrapper.like("sd_name", sysTreeData.getSdName());
        }
        IPage<SysTreeData> iPage = sysTreeDataService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条树形数据数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysTreeData-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysTreeDataService.getById(id));
    }


    @ApiOperation(value = "根据条件查询树形数据List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("sysTreeData-listByCondition")
    public DataResult listByCondition(@RequestBody SysTreeData sysTreeData) {
        QueryWrapper queryWrapper = new QueryWrapper();
        return DataResult.success(sysTreeDataService.list(queryWrapper));
    }

}