package com.example.frame.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.exception.BusinessException;
import com.example.frame.common.exception.code.BaseResponseCode;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.common.utils.file.FileProperties;
import com.example.frame.common.utils.file.FileUtil;
import com.example.frame.entity.PublicAttachement;
import com.example.frame.entity.SysDictData;
import com.example.frame.mapper.PublicAttachementMapper;
import com.example.frame.mapper.SysDictDataMapper;
import com.example.frame.service.IExcel;
import com.example.frame.service.IPublicAttachementService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 附件信息表 服务实现类
 * </p>
 *
 * @author
 * @since 2021-12-18
 */
@Service
public class PublicAttachementServiceImpl extends ServiceImpl<PublicAttachementMapper, PublicAttachement> implements IPublicAttachementService {
    @Resource
    private PublicAttachementMapper publicAttachementMapper;
    @Autowired
    private IExcel excelImpl;
    @Resource
    private SysDictDataMapper sysDictDataMapper;


    @Override
    public IPage listByPage(Page page, PublicAttachement publicAttachement) {
        return publicAttachementMapper.listByPage(page, publicAttachement);
    }

    @Override
    public void addEnclosure(JSONObject jsonObject) {
        String tempPath = jsonObject.getString("tempPath");
        String fjdl = jsonObject.getString("fjdl");
        String fjlx = jsonObject.getString("fjlx");
        String ysmc = jsonObject.getString("ysmc");


        if ("导入导出模板".equals(fjdl)) {
            QueryWrapper queryWrapper = new QueryWrapper();
            queryWrapper.eq("fjdl", fjdl);
            queryWrapper.eq("fjlx", fjlx);
            PublicAttachement attachement = publicAttachementMapper.selectOne(queryWrapper);
            if (!StringUtil.isNullorEmpty(attachement)) {
                publicAttachementMapper.deleteById(attachement.getId());
                FileUtil.deleteFile(FileProperties.getRootPath() + attachement.getFjlj());
            }
        }
        JSONObject req = new JSONObject();
        req.put("tempPath", tempPath);
        req.put("type", fjlx);
        req.put("fjdl", fjdl);
        req.put("ysmc", ysmc);
        /* 保存 附件信息 */
        saveAttachement(req);
        if ("导入导出模板".equals(fjdl)) {
            try {
                excelImpl.outportExcelModule(fjlx);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /*保存单个附件*/
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveAttachement(JSONObject jsonObject) {
        String glid = jsonObject.getString("glid");
        String tempPath = jsonObject.getString("tempPath");
        String type = jsonObject.getString("type");
        String fjdl = jsonObject.getString("fjdl");
        String ysmc = jsonObject.getString("ysmc");
        QueryWrapper dictWrapper = new QueryWrapper();
        /*查询系统路径配置字典*/
        dictWrapper.eq("dict_type", "systemPathConfiguration");
        dictWrapper.eq("dict_label", type);
        SysDictData sysDictData = sysDictDataMapper.selectOne(dictWrapper);
        //保存路径
        String savePath = sysDictData.getDictValue();
        //文件后缀
        String saveFileStuff = "";
        //文件路径
        String pathName = "";
        //文件流
        //公共附件数据存储
        PublicAttachement attachement = new PublicAttachement();
        attachement.setCreateTime(DateTimeUI.getCurrentDateTime());//创建时间
        attachement.setFjdl(fjdl);
        attachement.setFjlx(type);//附件类型
        attachement.setGlid(glid);//关联id
        //进行进行复制
        attachement.setId(RandomGUID.getDateUUID());//id
        //临时存储路径
        tempPath = FileProperties.getRootPath() + tempPath;
        saveFileStuff = tempPath.substring(tempPath.lastIndexOf("."));
        //保存文件名称
        String saveFileName = RandomGUID.getFileUUID();
        //附件名称
        attachement.setFjmc(saveFileName);
        //原始名称
        attachement.setYsmc(ysmc);
        //附件路径
        attachement.setFjlj(savePath + saveFileName + saveFileStuff);
        //业务保存路径
        pathName = savePath + saveFileName + saveFileStuff;
        String savePathName = FileProperties.getRootPath() + pathName;
        try {
            FileUtil.deleteAndCopyFile(tempPath, savePathName);
        } catch (Exception e) {
            throw new BusinessException(BaseResponseCode.DEFAULT_FILE_ERROR.getCode(), "附件保存异常");
        }
        attachement.setFjhzm(saveFileStuff);//附件后缀
        publicAttachementMapper.insert(attachement);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateAttachement(JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        String tempPath = jsonObject.getString("tempPath");
        String fjdl = jsonObject.getString("fjdl");
        String fjlx = jsonObject.getString("fjlx");
        String ysmc = jsonObject.getString("ysmc");
        if (!StringUtil.isNullorEmpty(id)) {
            PublicAttachement attachement = publicAttachementMapper.selectById(id);
            attachement.setFjdl(fjdl);
            attachement.setFjlx(fjlx);
            attachement.setUpdateTime(DateTimeUI.getCurrentDateTime());
            attachement.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
            publicAttachementMapper.updateById(attachement);
            if (!StringUtil.isNullorEmpty(tempPath)) {
                publicAttachementMapper.deleteById(id);
                FileUtil.deleteFile(FileProperties.getRootPath() + attachement.getFjlj());
                JSONObject req = new JSONObject();
                req.put("tempPath", tempPath);
                req.put("type", fjlx);
                req.put("fjdl", fjdl);
                req.put("ysmc", ysmc);
                saveAttachement(req);
                if ("导入导出模板".equals(fjdl)) {
                    try {
                        excelImpl.outportExcelModule(fjlx);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } else {
            throw new BusinessException(BaseResponseCode.DATA_ERROR.getCode(), "id不能为空");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteAttachement(List<String> ids) {
        for (String id : ids) {
            PublicAttachement publicAttachement = publicAttachementMapper.selectById(id);
            publicAttachementMapper.deleteById(id);
            FileUtil.deleteFile(FileProperties.getRootPath() + publicAttachement.getFjlj());
        }
    }
}
