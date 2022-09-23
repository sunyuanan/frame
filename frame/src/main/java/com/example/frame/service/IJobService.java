package com.example.frame.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;

import com.example.frame.entity.QuartzEntity;
import org.quartz.SchedulerException;
import org.springframework.transaction.annotation.Transactional;

public interface IJobService extends IService<QuartzEntity> {

    IPage<QuartzEntity> pageInfo(QuartzEntity vo);

    @Transactional
    void saveQuartzEntity(QuartzEntity quartz) throws Exception;

    @Transactional(rollbackFor = Exception.class)
    void updateQuartzEntity(QuartzEntity quartz) throws Exception;

    @Transactional(rollbackFor = Exception.class)
    void pauseQuartzEntity(String id) throws Exception;

    @Transactional(rollbackFor = Exception.class)
    void resumeQuartzEntity(String id) throws Exception;

    @Transactional(rollbackFor = SchedulerException.class)
    int deleteJob(String id) throws SchedulerException;
}
