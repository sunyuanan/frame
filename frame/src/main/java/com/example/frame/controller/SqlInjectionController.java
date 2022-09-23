package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.service.ISysLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author Galen
 * @Date 2021/12/10 0010 15:06
 */
@Api(tags = "sql注入操作")
@Controller
@RequestMapping("/sqlInjection")
public class SqlInjectionController {


    @Resource
    private ISysLogService sysLogService;


    @ApiOperation(value = "sql注入")
    @PostMapping("/sqlInjection")
    @LogAnnotation(title = "sql注入", action = "sql注入")
    @ResponseBody
    @SaCheckPermission("sqlInjection-sql")
    public DataResult sqlInjection(@RequestParam String sql) {
        List<Map<String, Object>> linkedList = sysLogService.sqlInjection(sql);
        return DataResult.success(linkedList);
    }



    @ApiOperation(value = "查询所有表格")
    @PostMapping("/selectAllTable")
    @LogAnnotation(title = "查询所有表格", action = "查询所有表格")
    @ResponseBody
    @SaCheckPermission("sqlInjection-table")
    public DataResult selectAllTable() {
        return DataResult.success(sysLogService.selectAllTable());
    }

}
