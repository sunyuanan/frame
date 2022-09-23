package com.example.frame.service;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.entity.PublicAttachement;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 附件信息表 服务类
 * </p>
 *
 * @author
 * @since 2021-12-18
 */
public interface IPublicAttachementService extends IService<PublicAttachement> {

    void addEnclosure(JSONObject jsonObject);

    void saveAttachement(JSONObject jsonObject);

    IPage listByPage(Page page, PublicAttachement publicAttachement);

    void updateAttachement(JSONObject jsonObject);

    void deleteAttachement(List<String> ids);
}
