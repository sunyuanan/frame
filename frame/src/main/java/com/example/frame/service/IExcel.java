package com.example.frame.service;

import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.utils.DataResult;

import javax.servlet.http.HttpServletResponse;

public interface IExcel {

    DataResult outportExcelModule(String type) throws Exception;

    DataResult importExcel(JSONObject jsonObject) throws Exception;

    DataResult exportExcel(JSONObject z, HttpServletResponse response) throws Exception;
}
