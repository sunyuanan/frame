package com.example.frame.controller;

import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysUserCompanyService;
import com.example.frame.entity.SysUserCompany;
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
    * 用户单位中间表 前端控制器
    * </p>
 *
 * @since 2021-12-18
 */
@Api(tags = {"用户单位中间表"})
@Slf4j
@Controller
@RequestMapping("/sysUserCompany")
    public class SysUserCompanyController {

    @Resource
    private ISysUserCompanyService sysUserCompanyService;



    @ApiOperation(value = "新增用户单位中间表")
    @PostMapping("/add")
    @LogAnnotation(title = "用户单位中间表", action = "新增用户单位中间表")
    @ResponseBody
    @SaCheckPermission("sysUserCompany-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysUserCompany sysUserCompany){
    sysUserCompany.setCreateTime(DateTimeUI.getCurrentDateTime());
    sysUserCompany.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
    sysUserCompany.setId(RandomGUID.getDateUUID());
    sysUserCompanyService.save(sysUserCompany);
        return DataResult.success();
    }

    @ApiOperation(value = "删除用户单位中间表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "用户单位中间表", action = "删除用户单位中间表")
    @ResponseBody
    @SaCheckPermission("sysUserCompany-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
    sysUserCompanyService.removeByIds(ids);
    return DataResult.success();
    }

    @ApiOperation(value = "更新用户单位中间表")
    @PutMapping("/update")
    @LogAnnotation(title = "用户单位中间表", action = "更新用户单位中间表")
    @ResponseBody
    @SaCheckPermission("sysUserCompany-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysUserCompany sysUserCompany){
        sysUserCompany.setUpdateTime(DateTimeUI.getCurrentDateTime());
        sysUserCompanyService.updateById(sysUserCompany);
        return DataResult.success();
    }

    @ApiOperation(value = "查询用户单位中间表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysUserCompany-listByPage")
    public DataResult findListByPage(@RequestBody SysUserCompany sysUserCompany){
    Page page = new Page(sysUserCompany.getPage(), sysUserCompany.getLimit());
    QueryWrapper queryWrapper = new QueryWrapper();
    //查询条件示例
    //queryWrapper.eq("id", sysUserCompany.getId());
    IPage<SysUserCompany> iPage = sysUserCompanyService.page(page,
    queryWrapper);
    return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条用户单位中间表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysUserCompany-listById")
    public DataResult listById(@RequestParam String id){
    return DataResult.success(sysUserCompanyService.getById(id));
    }



    @ApiOperation(value = "根据条件查询用户单位中间表List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("sysUserCompany-listByCondition")
    public DataResult listByCondition(@RequestBody SysUserCompany sysUserCompany) {
    QueryWrapper queryWrapper = new QueryWrapper();
    return DataResult.success(sysUserCompanyService.list(queryWrapper));
    }
    }
