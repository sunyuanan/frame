package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.entity.SysLog;
import com.example.frame.service.ISysLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 系统日志 前端控制器
 * </p>
 *
 * @since 2021-10-28
 */
@Api(tags = {"系统日志"})
@Slf4j
@Controller
@RequestMapping("/sysLog")
@RestController
public class SysLogController {

    @Resource
    private ISysLogService sysLogService;


    @PostMapping("/logs")
    @ApiOperation(value = "分页查询系统操作日志接口")
    @SaCheckPermission("sysLog-logs")
    public DataResult pageInfo(@RequestBody SysLog sysLog) {
        Page page = new Page(sysLog.getPage(), sysLog.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.orderByDesc("create_time");
        if (!StringUtil.isNullorEmpty(sysLog.getOperation())){
            queryWrapper.like("operation", sysLog.getOperation());
        }

        return DataResult.success(sysLogService.page(page, queryWrapper));
    }

    @DeleteMapping("/logs")
    @ApiOperation(value = "删除日志接口")
    @LogAnnotation(title = "系统操作日志管理", action = "删除系统操作日志")
    @CheckLockAnnotation()
    @SaCheckPermission("sysLog-logs")
    public DataResult deleted(@RequestBody List<String> logIds) {
        sysLogService.removeByIds(logIds);
        return DataResult.success();
    }
}
