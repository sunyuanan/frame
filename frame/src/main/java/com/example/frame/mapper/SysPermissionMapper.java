package com.example.frame.mapper;

import com.example.frame.entity.SysPermission;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统权限 Mapper 接口
 * </p>
 *
 * @author
 * @since 2021-11-02
 */
public interface SysPermissionMapper extends BaseMapper<SysPermission> {

    List<SysPermission> getFirstMenus(@Param(value = "roleId") String roleId, @Param(value = "pId") String pId, @Param(value = "type") Integer type);
}
