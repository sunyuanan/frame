package com.example.frame.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.frame.entity.SysUserLoginView;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * VIEW 服务类
 * </p>
 *
 * @author 
 * @since 2021-11-10
 */
public interface ISysUserLoginViewService extends IService<SysUserLoginView> {
    IPage<SysUserLoginView> listPage(SysUserLoginView sysUserLoginView);
}
