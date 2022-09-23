package com.example.frame.service;

import com.example.frame.entity.SysRolePermission;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 系统角色权限 服务类
 * </p>
 *
 * @author
 * @since 2021-11-02
 */
public interface ISysRolePermissionService extends IService<SysRolePermission> {

    List<String> selectPermission(String roleId, String type);

    void saveRolePermission(List<String> permissionList, String roleId);

    void saveUserPermissionRedis(String loginId, String roleId);



}
