package com.example.frame.service;

import com.example.frame.entity.SysPermission;
import com.example.frame.entity.SysUser;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.frame.entity.SysUserLoginView;
import com.example.frame.vo.req.LoginReqVO;
import com.example.frame.vo.resp.LoginRespVO;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统用户 服务类
 * </p>
 *
 * @author
 * @since 2021-10-26
 */
public interface ISysUserService extends IService<SysUser> {
    /**
     * 用户登录接口
     *
     * @param vo
     * @return
     */
    LoginRespVO login(LoginReqVO vo);

    /**
     * 新增系统用户接口
     *
     * @param sysUserLoginView
     */
    void add(SysUserLoginView sysUserLoginView);

    /**
     * 修改系统用户接口
     *
     * @param vo
     */
    void updateUserInfo(SysUserLoginView vo);

    /**
     * 删除用户接口
     *
     * @param ids
     */
    void delete(List<String> ids);

    /**
     * 获取所有菜单权限接口
     *
     * @param roleId
     * @return
     */
    List<SysPermission> getAllMenus(String roleId);
}
