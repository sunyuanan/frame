package com.example.frame.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.entity.PublicAttachement;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 附件信息表 Mapper 接口
 * </p>
 *
 * @author
 * @since 2021-12-18
 */
public interface PublicAttachementMapper extends BaseMapper<PublicAttachement> {

    IPage listByPage(Page page, @Param(value = "publicAttachement") PublicAttachement publicAttachement);
}
