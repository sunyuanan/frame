package com.example.frame.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.entity.SysUserLoginView;
import com.example.frame.mapper.SysUserLoginViewMapper;
import com.example.frame.service.ISysUserLoginViewService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 * VIEW 服务实现类
 * </p>
 *
 * @author
 * @since 2021-11-10
 */
@Service
public class SysUserLoginViewServiceImpl extends ServiceImpl<SysUserLoginViewMapper, SysUserLoginView> implements ISysUserLoginViewService {

    @Resource
    private SysUserLoginViewMapper sysUserLoginViewMapper;

    @Override
    public IPage<SysUserLoginView> listPage(SysUserLoginView sysUserLoginView) {
        Page page = new Page(sysUserLoginView.getPage(), sysUserLoginView.getLimit());
        return sysUserLoginViewMapper.listPage(page, sysUserLoginView);
    }
}
