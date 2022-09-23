package com.example.frame.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.utils.DataResult;
import com.example.frame.service.IExcel;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author sya
 * @Date 2021/12/18 21:47
 */
@Api(tags = "文件导入导出管理")
@Controller
@Slf4j
@RequestMapping(value = "/excelWeb")
public class ExcelWebController {

    @Resource
    private IExcel excelImpl;

    @PostMapping(value = "/importExcel")
    @ApiOperation(value = "导入文件")
    @ResponseBody
    @SaCheckPermission("excelWeb-importExcel")
    @ApiImplicitParam(
            name = "jsonObject",
            value =
                    "{\"excelPath\":\"临时文件路径\",\"type\":\"附件模板类型\"}",
            dataType = "JSONObject",
            required = true)
    public DataResult importExcel(@RequestBody JSONObject jsonObject) throws Exception {
        return excelImpl.importExcel(jsonObject);
    }


    @GetMapping(value = "/exportExcel")
    @ApiOperation(value = "导出文件")
    //@SaCheckPermission("excelWeb-exportExcel")
    @ApiImplicitParam(
            name = "jsonObject",
            value =
                    "{\"type\":\"附件模板类型\"}",
            dataType = "JSONObject",
            required = true)
    public void exportExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            JSONObject jsonObject = JSONObject.parseObject(request.getParameter("jsonObject"));
            excelImpl.exportExcel(jsonObject, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
