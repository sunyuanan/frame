package com.example.frame.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.entity.SysUserLoginView;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * VIEW Mapper 接口
 * </p>
 *
 * @author
 * @since 2021-11-10
 */
public interface SysUserLoginViewMapper extends BaseMapper<SysUserLoginView> {

    IPage<SysUserLoginView> listPage(Page page, @Param(value = "sysUserLoginView") SysUserLoginView sysUserLoginView);

    List<SysUserLoginView> existRoleList(@Param(value = "roleList") List roleList);
}
