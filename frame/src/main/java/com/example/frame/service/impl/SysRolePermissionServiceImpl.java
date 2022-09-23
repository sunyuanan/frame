package com.example.frame.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.RedisUtil;
import com.example.frame.entity.SysRolePermission;
import com.example.frame.entity.SysUserRole;
import com.example.frame.mapper.SysRolePermissionMapper;
import com.example.frame.mapper.SysUserRoleMapper;
import com.example.frame.service.ISysRolePermissionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 系统角色权限 服务实现类
 * </p>
 *
 * @author
 * @since 2021-11-02
 */
@Service
public class SysRolePermissionServiceImpl extends ServiceImpl<SysRolePermissionMapper, SysRolePermission> implements ISysRolePermissionService {
    @Resource
    private SysRolePermissionMapper sysRolePermissionMapper;
    @Resource
    private SysUserRoleMapper sysUserRoleMapper;
    @Resource
    private RedisUtil redisUtil;


    /**
     * 选择权限
     *
     * @param roleId 角色id
     * @param type   类型
     * @return
     */
    @Override
    public List<String> selectPermission(String roleId, String type) {
        return sysRolePermissionMapper.selectPermission(roleId, type);
    }

    /**
     * 保存角色权限
     *
     * @param permissionList 权限列表
     * @param roleId         角色id
     * @return
     */
    @Override
    public void saveRolePermission(List<String> permissionList, String roleId) {

        if (!permissionList.isEmpty()) {
            for (String id : permissionList) {
                SysRolePermission sysRolePermission = new SysRolePermission();
                sysRolePermission.setCreateTime(DateTimeUI.getCurrentDateTime());
                sysRolePermission.setId(RandomGUID.getDateUUID());
                sysRolePermission.setPermissionId(id);
                sysRolePermission.setRoleId(roleId);
                sysRolePermissionMapper.insert(sysRolePermission);
            }
        }
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("role_id", roleId);
        List<SysUserRole> sysUserRoles = sysUserRoleMapper.selectList(queryWrapper);
        for (SysUserRole sysUserRole : sysUserRoles) {
            redisUtil.delete("sysPermission:" + sysUserRole.getUserId());
            List<String> list = sysRolePermissionMapper.showRolePermissionByLoginId(sysUserRole.getUserId());
            for (String permission : list) {
                redisUtil.lpush("sysPermission:" + sysUserRole.getUserId(), permission);
            }
        }

    }


    @Override
    public void saveUserPermissionRedis(String loginId, String roleId) {

        redisUtil.delete("sysPermission:" + loginId);

        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("role_id", roleId);
        queryWrapper.select("perms");
        List<String> list = sysRolePermissionMapper.showRolePermissionByLoginId(loginId);
        for (String perms : list) {
            redisUtil.lpush("sysPermission:" + loginId, perms);
        }
    }
}
