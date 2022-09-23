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
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.ISysInterceptLogService;
import com.example.frame.entity.SysInterceptLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

/**
 * <p>
 * 拦截异常日志表 前端控制器
 * </p>
 *
 * @since 2021-10-29
 */
@Api(tags = {"拦截异常日志表"})
@Slf4j
@Controller
@RequestMapping("/sysInterceptLog")
public class SysInterceptLogController {

    @Resource
    private ISysInterceptLogService sysInterceptLogService;


    @ApiOperation(value = "新增拦截异常日志表")
    @PostMapping("/add")
    @LogAnnotation(title = "拦截异常日志表", action = "新增拦截异常日志表")
    @ResponseBody
    @SaCheckPermission("sysInterceptLog-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysInterceptLog sysInterceptLog) {
        sysInterceptLog.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysInterceptLog.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysInterceptLog.setId(RandomGUID.getDateUUID());
        sysInterceptLogService.save(sysInterceptLog);
        return DataResult.success();
    }

    @ApiOperation(value = "删除拦截异常日志表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "拦截异常日志表", action = "删除拦截异常日志表")
    @ResponseBody
    @SaCheckPermission("sysInterceptLog-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List
            <String> ids) {
        sysInterceptLogService.removeByIds(ids);
        return DataResult.success();
    }


    @ApiOperation(value = "更新拦截异常日志表")
    @PutMapping("/update")
    @LogAnnotation(title = "拦截异常日志表", action = "更新拦截异常日志表")
    @ResponseBody
    @SaCheckPermission("sysInterceptLog-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody SysInterceptLog sysInterceptLog) {
        sysInterceptLogService.updateById(sysInterceptLog);
        return DataResult.success();
    }

    @ApiOperation(value = "查询拦截异常日志表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("sysInterceptLog-listByPage")
    public DataResult findListByPage(@RequestBody SysInterceptLog sysInterceptLog) {
        Page page = new Page(sysInterceptLog.getPage(), sysInterceptLog.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.orderByDesc("sync_time");
        //查询条件示例
        if (!StringUtil.isNullorEmpty(sysInterceptLog.getIp())) {
            queryWrapper.like("ip", sysInterceptLog.getIp());
        }
        IPage<SysInterceptLog> iPage = sysInterceptLogService.page(page,
                queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条拦截异常日志表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("sysInterceptLog-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(sysInterceptLogService.getById(id));
    }
}
