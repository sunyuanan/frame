package com.example.frame.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.frame.common.constant.Constants;
import com.example.frame.common.exception.code.BaseResponseCode;
import com.example.frame.common.exception.BusinessException;
import com.example.frame.common.utils.*;
import com.example.frame.entity.*;
import com.example.frame.mapper.*;
import com.example.frame.service.ISysRolePermissionService;
import com.example.frame.service.ISysUserService;
import com.example.frame.vo.req.LoginReqVO;
import com.example.frame.vo.resp.LoginRespVO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author
 * @since 2021-10-26
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {

    @Resource
    private SysUserLoginMapper sysUserLoginMapper;
    @Resource
    private SysUserLoginViewMapper sysUserLoginViewMapper;
    @Resource
    private SysUserMapper sysUserMapper;
    @Resource
    private SysUserRoleMapper sysUserRoleMapper;
    @Resource
    private SysUserCompanyMapper sysUserCompanyMapper;
    @Resource
    private SysPermissionMapper sysPermissionMapper;
    @Resource
    private ISysRolePermissionService sysRolePermissionService;
    @Resource
    private RedisUtil redisUtil;


    @Override
    public LoginRespVO login(LoginReqVO vo) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("account", vo.getUsername());
        SysUserLogin sysUserLogin = sysUserLoginMapper.selectOne(queryWrapper);

        if (StringUtil.isNullorEmpty(sysUserLogin)) {
            throw new BusinessException(BaseResponseCode.NOT_ACCOUNT);
        }

        if (sysUserLogin.getStatus() == 1) {
            throw new BusinessException(BaseResponseCode.USER_LOCK);
        }

        //  后台管理界面登录  超级管理员才可以登录
        if ("2".equals(vo.getType())) {
            QueryWrapper queryWrapper1 = new QueryWrapper();
            queryWrapper1.eq("user_id", sysUserLogin.getId());
            queryWrapper1.eq("role_id", "11B3B80C-4A0B-4A92-96EA-FDD4F7A4A7E9");
            SysUserRole sysUserRole = sysUserRoleMapper.selectOne(queryWrapper1);
            if (StringUtil.isNullorEmpty(sysUserRole)) {
                //该账号无超级管理员角色
                throw new BusinessException(BaseResponseCode.NO_POWER_ERROR);
            }
        }

        if (StpUtil.isDisable(sysUserLogin.getId())) {
            long disableTime = StpUtil.getDisableTime(sysUserLogin.getId());
            Double tempTime = Double.valueOf(disableTime) / 60.0;
            throw new BusinessException(401104, "该用户已锁定:" + Math.round(tempTime * 100) / 100 + "分钟");
        }

        if (!PasswordUtils.matches(sysUserLogin.getSalt(), vo.getPassword(), sysUserLogin.getEncryptionPassword())) {
            sysUserLogin.setAbnormalNum(sysUserLogin.getAbnormalNum() + 1);
            /*超过3次密码错误则每错一次禁30分钟 5次则锁定*/
            if (sysUserLogin.getAbnormalNum() >= 5) {
                sysUserLogin.setStatus(1);
            }
            if (sysUserLogin.getAbnormalNum() >= 3 && sysUserLogin.getAbnormalNum() < 5) {
                StpUtil.disable(sysUserLogin.getId(), 1800);
                sysUserLogin.setStatus(2);
            }
            sysUserLogin.setStatus(0);
            sysUserLoginMapper.updateById(sysUserLogin);
            throw new BusinessException(BaseResponseCode.PASSWORD_ERROR);
        }


        //登录
        StpUtil.login(sysUserLogin.getId());

        LoginRespVO respVO = new LoginRespVO();
        BeanUtils.copyProperties(sysUserLogin, respVO);
        sysUserLogin.setLastLoginTime(DateTimeUI.getCurrentDateTime());
        sysUserLogin.setAbnormalNum(0);
        sysUserLoginMapper.updateById(sysUserLogin);

        respVO.setUsername(sysUserLogin.getAccount());
        respVO.setAccessToken(StpUtil.getTokenValue());

        //缓存用户信息

        //缓存用户信息
        SysUser sysUser = sysUserMapper.selectById(sysUserLogin.getUserId());
        StpUtil.getSession().set(Constants.CURRENT_ACCOUNT_ID, sysUserLogin.getId());
        StpUtil.getSession().set(Constants.CURRENT_ACCOUNT_USER_NAME, sysUser.getRealName());
        StpUtil.getSession().set(Constants.CURRENT_ACCOUNT, vo.getUsername());


        respVO.setRefreshToken(StpUtil.getTokenValue());


        return respVO;
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(SysUserLoginView vo) {
        if (StringUtil.isNullorEmpty(vo.getZjhm()) && StringUtil.isNullorEmpty(vo.getJh())) {
            throw new BusinessException(BaseResponseCode.ACCOUNT_JH_ERROR);
        }
        SysUser sysUser = new SysUser();
        SysUserLogin sysUserLogin = new SysUserLogin();

        BeanUtils.copyProperties(vo, sysUser);
        BeanUtils.copyProperties(vo, sysUserLogin);

        /*设置账号  */
        if (!StringUtil.isNullorEmpty(vo.getJh())) {
            sysUserLogin.setAccount(vo.getJh());
        }
        //同时存在的情况下 优先级身份证
        if (!StringUtil.isNullorEmpty(vo.getZjhm())) {
            sysUserLogin.setAccount(vo.getZjhm());
        }

        /*设置密码*/
        if (!StringUtil.isNullorEmpty(vo.getPassword())) {
            sysUserLogin.setSalt(PasswordUtils.getSalt());
            String encode = PasswordUtils.encode(vo.getPassword(), sysUserLogin.getSalt());
            sysUserLogin.setPassword(vo.getPassword());
            sysUserLogin.setEncryptionPassword(encode);
        }

        // 校验用户信息
        QueryWrapper<SysUser> sysUserQueryWrapper = new QueryWrapper();
        if (!StringUtil.isNullorEmpty(vo.getJh())) {
            sysUserQueryWrapper.eq("jh", vo.getJh());
        }
        if (!StringUtil.isNullorEmpty(vo.getZjhm())) {
            sysUserQueryWrapper.eq("zjhm", vo.getZjhm());
        }
        SysUser sysUserOld = sysUserMapper.selectOne(sysUserQueryWrapper);
        if (sysUserOld == null) {
            // 用户
            sysUser.setCreateTime(DateTimeUI.getCurrentDateTime());
            sysUser.setId(RandomGUID.getDateUUID());
            sysUserMapper.insert(sysUser);
            sysUserLogin.setUserId(sysUser.getId());
        } else {
            sysUser.setUpdateTime(DateTimeUI.getCurrentDateTime());
            sysUser.setId(sysUserOld.getId());
            sysUserMapper.updateById(sysUser);
            sysUserLogin.setUserId(sysUserOld.getId());
        }
        /*校验账号*/
        QueryWrapper<SysUserLogin> sysUserLoginQueryWrapper = new QueryWrapper();
        sysUserLoginQueryWrapper.eq("account", sysUserLogin.getAccount());
        SysUserLogin sysUserLoginOld = sysUserLoginMapper.selectOne(sysUserLoginQueryWrapper);
        if (StringUtil.isNullorEmpty(sysUserLoginOld)) {
            //不存在当前账号  直接存储账号信息
            this.addUserInfo(sysUserLogin, vo);
        } else {
            //存在账号
            if (!StringUtil.isNullorEmpty(vo.getRoleIdList()) && !vo.getRoleIdList().isEmpty()) {
                /* 多角色添加 */
                //新增的角色里 是否存在
                List<SysUserLoginView> sysUserLoginViewList = sysUserLoginViewMapper.existRoleList(vo.getRoleIdList());
                if (!sysUserLoginViewList.isEmpty()) {
                    String roleNames = "";
                    for (SysUserLoginView sysUserLoginView : sysUserLoginViewList) {
                        roleNames += sysUserLoginView.getRoleName() + ",";
                    }
                    throw new BusinessException(BaseResponseCode.DATA_ERROR.getCode(), "该用户已存在" + roleNames + "角色");
                }
                // 账号角色关系表
                addUserRoleInfo(vo.getRoleIdList(), vo.getSdCode(), sysUserLoginOld.getId());

            } else {
                /* 单角色添加 */
                //新增的角色里 是否存在
                QueryWrapper queryWrapper = new QueryWrapper();
                queryWrapper.eq("role_id", vo.getRoleId());
                SysUserLoginView sysUserLoginView = sysUserLoginViewMapper.selectOne(queryWrapper);

                if (StringUtil.isNullorEmpty(sysUserLoginView)) {
                    throw new BusinessException(BaseResponseCode.DATA_ERROR.getCode(), "该用户已存在" + sysUserLoginView.getRoleName() + "角色");
                }
                // 账号角色关系表
                this.addUserRoleInfo(vo.getRoleId(), vo.getSdCode(), sysUserLoginOld.getId());
            }
        }
        if (!StringUtil.isNullorEmpty(vo.getSdCode())) {
            this.addSysUsercompanyInfo(vo.getSdCode(), vo.getSdCode(), sysUserLogin.getId());

        }
    }

    /**
     * 添加用户单位信息
     *
     * @param sdCode
     * @param pcsdm
     * @param loginId
     */
    @Transactional(rollbackFor = Exception.class)
    public void addSysUsercompanyInfo(String sdCode, String pcsdm, String loginId) {
        SysUserCompany sysUserCompany = new SysUserCompany();
        sysUserCompany.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysUserCompany.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysUserCompany.setId(RandomGUID.getDateUUID());
        sysUserCompany.setSqdm(sdCode);
        sysUserCompany.setPcsdm(pcsdm);
        sysUserCompany.setUserLoginId(loginId);
        sysUserCompanyMapper.insert(sysUserCompany);
    }

    /**
     * @param roleId
     * @param sdCode
     * @param oldId
     */
    @Transactional(rollbackFor = Exception.class)
    public void addUserRoleInfo(String roleId, String sdCode, String oldId) {
        SysUserRole sysUserRole = new SysUserRole();
        sysUserRole.setId(RandomGUID.getDateUUID());
        sysUserRole.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysUserRole.setRoleId(roleId);
        sysUserRole.setSdCode(sdCode);
        sysUserRole.setUserId(oldId);
        sysUserRoleMapper.insert(sysUserRole);

        sysRolePermissionService.saveUserPermissionRedis(oldId, roleId);
    }


    /**
     * 添加角色信息 roleList
     *
     * @param roleList
     * @param sdCode
     * @param oldId
     */
    @Transactional(rollbackFor = Exception.class)
    public void addUserRoleInfo(List<String> roleList, String sdCode, String oldId) {
        for (String roleId : roleList) {
            addUserRoleInfo(roleId, sdCode, oldId);
        }
    }

    /**
     * 添加账号信息
     *
     * @param sysUserLogin
     * @param vo
     */
    @Transactional(rollbackFor = Exception.class)
    public void addUserInfo(SysUserLogin sysUserLogin, SysUserLoginView vo) {
        sysUserLogin.setStatus(0);
        sysUserLogin.setType(0);
        sysUserLogin.setSyncTime(DateTimeUI.getCurrentDateTimeLong());
        sysUserLogin.setCreateTime(DateTimeUI.getCurrentDateTime());
        sysUserLogin.setId(RandomGUID.getDateUUID());
        sysUserLoginMapper.insert(sysUserLogin);

        // 账号角色关系表
        if (!StringUtil.isNullorEmpty(vo.getRoleIdList()) && !vo.getRoleIdList().isEmpty()) {
            for (String roleId : vo.getRoleIdList()) {
                SysUserRole sysUserRole = new SysUserRole();
                sysUserRole.setId(RandomGUID.getDateUUID());
                sysUserRole.setCreateTime(DateTimeUI.getCurrentDateTime());
                sysUserRole.setRoleId(roleId);
                sysUserRole.setSdCode(vo.getSdCode());
                sysUserRole.setUserId(sysUserLogin.getId());
                sysUserRoleMapper.insert(sysUserRole);
            }
            // 账号角色关系表
            addUserRoleInfo(vo.getRoleIdList(), vo.getSdCode(), sysUserLogin.getId());
        } else {
            SysUserRole sysUserRole = new SysUserRole();
            sysUserRole.setId(RandomGUID.getDateUUID());
            sysUserRole.setCreateTime(DateTimeUI.getCurrentDateTime());
            sysUserRole.setRoleId(vo.getRoleId());
            sysUserRole.setSdCode(vo.getSdCode());
            sysUserRole.setUserId(sysUserLogin.getId());
            sysUserRoleMapper.insert(sysUserRole);

            // 账号角色关系表
            addUserRoleInfo(vo.getSdCode(), vo.getSdCode(), sysUserLogin.getId());
        }
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateUserInfo(SysUserLoginView vo) {
        if (!StringUtil.isNullorEmpty(vo.getId())) {
            SysUser sysUser = new SysUser();
            SysUserLogin sysUserLogin = new SysUserLogin();
            BeanUtils.copyProperties(vo, sysUser);
            BeanUtils.copyProperties(vo, sysUserLogin);

            // 设置密码
            if (!StringUtil.isNullorEmpty(vo.getPassword())) {
                sysUserLogin.setSalt(PasswordUtils.getSalt());
                String encode = PasswordUtils.encode(vo.getPassword(), sysUserLogin.getSalt());
                sysUserLogin.setPassword(vo.getPassword());
                sysUserLogin.setEncryptionPassword(encode);
            }


            /*设置账号  */
            if (!StringUtil.isNullorEmpty(vo.getJh())) {
                sysUserLogin.setAccount(vo.getJh());
            }
            //同时存在的情况下 优先级身份证
            if (!StringUtil.isNullorEmpty(vo.getZjhm())) {
                sysUserLogin.setAccount(vo.getZjhm());
            }


            // 校验账号表信息
            SysUserLogin sysUserLoginOld = sysUserLoginMapper.selectById(sysUserLogin.getId());
            if (!StringUtil.isNullorEmpty(sysUserLoginOld)) {
                sysUserLogin.setUpdateTime(DateTimeUI.getCurrentDateTime());
                sysUserLoginMapper.updateById(sysUserLogin);
                sysUser.setId(sysUserLoginOld.getUserId());
                sysUserMapper.updateById(sysUser);
                SysUserRole sysUserRole = sysUserRoleMapper.selectById(vo.getRelateId());
                if (!StringUtil.isNullorEmpty(vo.getRoleId())) {
                    if (!vo.getRoleId().equals(sysUserRole.getRoleId())) {
                        QueryWrapper queryWrapper = new QueryWrapper();
                        queryWrapper.eq("sd_code", sysUserRole.getSdCode());
                        queryWrapper.eq("role_id", vo.getRoleId());
                        queryWrapper.eq("user_id", sysUserRole.getUserId());
                        SysUserRole sysUserRole1 = sysUserRoleMapper.selectOne(queryWrapper);
                        if (StringUtil.isNullorEmpty(sysUserRole1)) {
                            sysUserRole.setRoleId(vo.getRoleId());
                            sysUserRoleMapper.updateById(sysUserRole);

                            sysRolePermissionService.saveUserPermissionRedis(vo.getId(), vo.getRoleId());

                        } else {
                            throw new BusinessException(BaseResponseCode.OPERATION_ERRO.getCode(), "当前用户已存在该角色");
                        }
                    }
                }


            } else {
                throw new BusinessException(BaseResponseCode.OPERATION_ERRO.getCode(), "账号不存在");
            }
        }
    }


    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<String> ids) {
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("relate_id", ids.get(0));
        SysUserLoginView sysUserLoginView = sysUserLoginViewMapper.selectOne(queryWrapper);
        if (!StringUtil.isNullorEmpty(sysUserLoginView)) {
            if ("超级管理员".equals(sysUserLoginView.getRoleName())) {
                throw new BusinessException(BaseResponseCode.OPERATION_ERRO.getCode(), "超级管理员不允许删除");
            }

            /* 查询账号是否还有其他角色 */
            QueryWrapper queryWrapper1 = new QueryWrapper();
            queryWrapper1.eq("user_id", sysUserLoginView.getId());
            queryWrapper1.ne("id", ids.get(0));
            long num = sysUserRoleMapper.selectCount(queryWrapper1);

            if (num == 0) {
                sysUserLoginMapper.deleteById(sysUserLoginView.getId());
                sysUserMapper.deleteById(sysUserLoginView.getUserId());
            }

            sysUserRoleMapper.deleteById(sysUserLoginView.getRelateId());

            /*删除用户单位表*/
            QueryWrapper queryWrapper2 = new QueryWrapper();
            queryWrapper2.eq("user_login_id", sysUserLoginView.getId());
            sysUserCompanyMapper.delete(queryWrapper2);

            redisUtil.delete("sysPermission:" + sysUserLoginView.getId());
        }
    }


    @Override
    public List<SysPermission> getAllMenus(String roleId) {
        List<SysPermission> menus = sysPermissionMapper.getFirstMenus(roleId, "0", 1);
        if (!menus.isEmpty()) {
            for (SysPermission sysPermission : menus) {
                List<SysPermission> secondMenus = sysPermissionMapper.getFirstMenus(roleId, sysPermission.getId(), 2);
                sysPermission.setChildren(secondMenus);
            }

        }
        return menus;
    }


}
