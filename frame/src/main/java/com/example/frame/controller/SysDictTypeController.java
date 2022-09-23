package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.entity.SysDictType;
import com.example.frame.service.ISysDictDataService;
import com.example.frame.service.ISysDictTypeService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 字典类型表 前端控制器
 * </p>
 *
 * @since 2021-11-04
 */
@Api(tags = {"字典类型表"})
@Slf4j
@Controller
@RequestMapping("/sysDictType")
public class SysDictTypeController {

    @Resource
    private ISysDictTypeService sysDictTypeService;
    @Resource
    private ISysDictDataService sysDictDataService;

    @ApiOperation(value = "新增字典类型表")
    @PostMapping("/add")
    @LogAnnotation(title = "字典类型表", action = "新增字典类型表")
    @ResponseBody
    @SaCheckPermission("sysDictType-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysDictType sysDictType) {
        sysDictType.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysDictType.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysDictType.setId(RandomGUID.getDateUUID());
        sysDictTypeService.save(sysDictType);
        return DataResult.success();
    }

    @ApiOperation(value = "删除字典类型表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "字典类型表", action = "删除字典类型表")
    @ResponseBody
    @SaCheckPermission("sysDictType-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        sysDictTypeService.removeByIds(ids);
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("type_id", ids.get(0));
        sysDictDataService.remove(queryWrapper);
        return DataResult.success();
    }

    @ApiOperation(value = "更新字典类型表")
    @PutMapping("/update")
    @LogAnnotation(title = "字典类型表", action = "更新字典类型表")
    @ResponseBody
    @SaCheckPermission("sysDictType-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysDictType sysDictType) {
        sysDictType.setUpdateTime(DateTimeUI.getCurrentDateTime());
        sysDictTypeService.updateById(sysDictType);
        return DataResult.success();
    }

    @ApiOperation(value = "查询字典类型表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysDictType-listByPage")
    public DataResult findListByPage(@RequestBody SysDictType sysDictType) {
        Page page = new Page(sysDictType.getPage(), sysDictType.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        if (!StringUtil.isNullorEmpty(sysDictType.getDictName())) {
            queryWrapper.like("dict_name", sysDictType.getDictName());
        }

        IPage<SysDictType> iPage = sysDictTypeService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }

    @ApiOperation(value = "查询字典类型表List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("sysDictType-listByCondition")
    public DataResult listByCondition(@RequestBody SysDictType sysDictType) {
        QueryWrapper queryWrapper = new QueryWrapper();
        //查询条件示例
        if (!StringUtil.isNullorEmpty(sysDictType.getDictType())) {
            queryWrapper.like("DICT_TYPE", sysDictType.getDictType());
        }
        String typeId = sysDictTypeService.getOne(queryWrapper).getId();
        QueryWrapper queryWrapper1 = new QueryWrapper();
        queryWrapper1.eq("TYPE_ID", typeId);

        return DataResult.success(sysDictDataService.list(queryWrapper1));
    }


    @ApiOperation(value = "根据id查询单条字典类型表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysDictType-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysDictTypeService.getById(id));
    }
}
