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
import com.example.frame.service.ISysDictDataService;
import com.example.frame.entity.SysDictData;
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
 * 字典数据表 前端控制器
 * </p>
 *
 * @since 2021-11-04
 */
@Api(tags = {"字典数据表"})
@Slf4j
@Controller
@RequestMapping("/sysDictData")
public class SysDictDataController {

    @Resource
    private ISysDictDataService sysDictDataService;


    @ApiOperation(value = "新增字典数据表")
    @PostMapping("/add")
    @LogAnnotation(title = "字典数据表", action = "新增字典数据表")
    @ResponseBody
    @SaCheckPermission("sysDictData-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysDictData sysDictData) {
        sysDictData.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysDictData.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysDictData.setId(RandomGUID.getDateUUID());
        sysDictDataService.save(sysDictData);
        return DataResult.success();
    }

    @ApiOperation(value = "删除字典数据表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "字典数据表", action = "删除字典数据表")
    @ResponseBody
    @SaCheckPermission("sysDictData-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        sysDictDataService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新字典数据表")
    @PutMapping("/update")
    @LogAnnotation(title = "字典数据表", action = "更新字典数据表")
    @ResponseBody
    @SaCheckPermission("sysDictData-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysDictData sysDictData) {
        sysDictData.setUpdateTime(DateTimeUI.getCurrentDateTime());
        sysDictDataService.updateById(sysDictData);
        return DataResult.success();
    }

    @ApiOperation(value = "查询字典数据表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysDictData-listByPage")
    public DataResult findListByPage(@RequestBody SysDictData sysDictData) {
        Page page = new Page(sysDictData.getPage(), sysDictData.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        if (!StringUtil.isNullorEmpty(sysDictData.getDictLabel())) {
            queryWrapper.eq("DICT_LABEL", sysDictData.getDictLabel());
        }
        queryWrapper.eq("TYPE_ID", sysDictData.getTypeId());
        IPage<SysDictData> iPage = sysDictDataService.page(page,
                queryWrapper);
        return DataResult.success(iPage);
    }




    @ApiOperation(value = "根据id查询单条字典数据表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysDictData-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysDictDataService.getById(id));
    }
}
