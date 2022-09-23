package com.example.frame.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.file.FilePropertiesBase;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.common.utils.file.ExcelUtil;
import com.example.frame.entity.*;
import com.example.frame.mapper.*;
import com.example.frame.service.IExcel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

@Service("excelImpl")
public class ExcelImpl implements IExcel {
    private static final Logger logger = LoggerFactory.getLogger(com.example.frame.service.impl.ExcelImpl.class);

    @Autowired
    private ExcelUtil util; //自动装配的controller
    private static ExcelUtil excelUtil; //供静态main方法调用的controller

    @PostConstruct
    public void init() {
        excelUtil = util; //完成赋予操作
    }

    @Resource
    PublicAttachementMapper publicAttachementMapper;
    @Resource
    SysDictDataMapper sysDictDataMapper;

    @Override
    public DataResult outportExcelModule(String type) throws Exception {
        DataResult result = new DataResult<>();
        result.setCode(1);
        result.setMsg("导出失败");
        result.setData("");
        QueryWrapper dictWrapper = new QueryWrapper();
        /*查询系统路径配置字典*/
        dictWrapper.eq("dict_type", "systemPathConfiguration");
        dictWrapper.eq("dict_label", type);
        SysDictData sysDictData = sysDictDataMapper.selectOne(dictWrapper);
        String filePath = sysDictData.getDictValue();
        String fileName = type + ".xls";
        File dir = new File(FilePropertiesBase.getRootPath() + filePath);
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("fjlx", type);
        PublicAttachement attachement = publicAttachementMapper.selectOne(queryWrapper);
        result = excelUtil.exportModelExcel(attachement.getFjlj(), filePath, fileName);
        return result;
    }

    @Override
    @Transactional
    public DataResult importExcel(JSONObject jsonObject) throws Exception {

        String filePath = jsonObject.getString("excelPath");
        String type =  jsonObject.getString("type");
        DataResult result = new DataResult<>();
        result.setCode(1);
        result.setMsg("导入失败");
        result.setData("");
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("fjlx", type);
        PublicAttachement publicAttachement = publicAttachementMapper.selectOne(queryWrapper);
        if (StringUtil.isNullorEmpty(publicAttachement)) {
            result.setMsg("文本模板不存在");
            return result;
        }
        result = excelUtil.importExcel(publicAttachement.getFjlj(), filePath);
        if (result.getCode() == 0) {
            JSONObject respData = (JSONObject) result.getData();
            switch (type) {
//                case "设备用户导入导出模板":
//                    result = importEquipmentUserInfoData(respData);
//                    break;
//                case "设备导入导出模板":
//                    result = importEquipmentSoftwareInfoData(respData);
//                    break;
                case "":
                    break;
            }
        }

        return result;
    }




    @Override
    @Transactional(rollbackFor = Exception.class)
    public DataResult exportExcel(JSONObject jsonObject, HttpServletResponse response) {
        DataResult result = new DataResult<>();
        result.setCode(1);
        result.setMsg("导出失败");
        result.setData("");
        String type = jsonObject.getString("type");
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("fjlx", type);
        PublicAttachement attachement = publicAttachementMapper.selectOne(queryWrapper);
        QueryWrapper dictWrapper = new QueryWrapper();
        /*查询系统路径配置字典*/
        dictWrapper.eq("dict_type", "systemPathConfiguration");
        dictWrapper.eq("dict_label", type);
        SysDictData sysDictData = sysDictDataMapper.selectOne(dictWrapper);
        if (StringUtil.isNullorEmpty(attachement)) {
            result.setMsg("导入导出模板不存在");
            return result;
        }
        switch (type) {
//            case "设备用户导入导出模板":
//                result = exportEquipmentUserInfo(jsonObject, attachement, sysDictData,response);
//                break;
//            case "设备导入导出模板":
//                result = exportEquipmentSoftwareInfo(jsonObject, attachement, sysDictData,response);
//                break;
            case "":
                break;
        }
        return result;
    }


}
