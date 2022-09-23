package com.example.frame.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.frame.entity.SysRolePermission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 系统角色权限 Mapper 接口
 * </p>
 *
 * @author
 * @since 2021-11-02
 */
public interface SysRolePermissionMapper extends BaseMapper<SysRolePermission> {


    List<String> showRolePermissionByLoginId(@Param(value = "loginId") String loginId);



    List<String> selectPermission(@Param(value = "roleId") String roleId, @Param(value = "type") String type);

    void removePower(@Param(value = "roleId") String roleId);
}
