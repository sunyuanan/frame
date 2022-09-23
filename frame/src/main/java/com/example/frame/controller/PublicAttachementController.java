package com.example.frame.controller;

import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.utils.StringUtil;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.IPublicAttachementService;
import com.example.frame.entity.PublicAttachement;
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
 * 附件信息表 前端控制器
 * </p>
 *
 * @since 2021-12-18
 */
@Api(tags = {"附件信息表"})
@Slf4j
@Controller
@RequestMapping("/publicAttachement")
public class PublicAttachementController {

    @Resource
    private IPublicAttachementService publicAttachementService;


    @ApiOperation(value = "新增附件信息表")
    @PostMapping("/add")
    @LogAnnotation(title = "附件信息表", action = "新增附件信息表")
    @ResponseBody
    @SaCheckPermission("publicAttachement-add")
    @CheckLockAnnotation()
    @ApiImplicitParam(
            name = "jsonObject",
            value =
                    "{\"tempPath\":\"临时缓存路径\",\"fjdl\":\"附件大类（从字典获取，不能手动输入）\",\"fjlx\":\"附件类型（从字典获取，不能手动输入）\",\"ysmc\":\"附件原始名称\"}",
            dataType = "JSONObject",
            required = true)
    public DataResult add(@RequestBody JSONObject jsonObject) {
        if (StringUtil.isNullorEmpty(jsonObject.getString("tempPath"))) {
            return DataResult.fail("临时缓存路径不能为空");
        }
        publicAttachementService.addEnclosure(jsonObject);
        return DataResult.success();

    }

    @ApiOperation(value = "删除附件信息表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "附件信息表", action = "删除附件信息表")
    @ResponseBody
    @SaCheckPermission("publicAttachement-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        publicAttachementService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新附件信息表")
    @PutMapping("/update")
    @LogAnnotation(title = "附件信息表", action = "更新附件信息表")
    @ResponseBody
    @SaCheckPermission("publicAttachement-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody PublicAttachement publicAttachement) {
        publicAttachement.setUpdateTime(DateTimeUI.getCurrentDateTime());
        publicAttachementService.updateById(publicAttachement);
        return DataResult.success();
    }

    @ApiOperation(value = "查询附件信息表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("publicAttachement-listByPage")
    public DataResult findListByPage(@RequestBody PublicAttachement publicAttachement) {
        Page page = new Page(publicAttachement.getPage(), publicAttachement.getLimit());

        IPage<PublicAttachement> iPage = publicAttachementService.listByPage(page, publicAttachement);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条附件信息表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("publicAttachement-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(publicAttachementService.getById(id));
    }


    @ApiOperation(value = "根据条件查询附件信息表List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("publicAttachement-listByCondition")
    public DataResult listByCondition(@RequestBody PublicAttachement publicAttachement) {
        QueryWrapper queryWrapper = new QueryWrapper();
        return DataResult.success(publicAttachementService.list(queryWrapper));
    }
}
