package com.example.frame.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.frame.entity.SysGenerator;

/**
 * 服务类
 *
 * @since 2020-03-20
 */
public interface ISysGeneratorService extends IService<SysGenerator> {

    IPage<SysGenerator> selectAllTables(Page page, SysGenerator vo);

    void gen(SysGenerator sysGenerator);
}
