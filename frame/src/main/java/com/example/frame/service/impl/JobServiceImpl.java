package com.example.frame.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.example.frame.common.job.TaskException;
import com.example.frame.common.schedule.ScheduleUtils;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.entity.QuartzEntity;
import com.example.frame.mapper.QuartzEntityMapper;
import com.example.frame.service.IJobService;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

@Service("jobService")
public class JobServiceImpl extends ServiceImpl<QuartzEntityMapper, QuartzEntity>
        implements IJobService {

    @Autowired
    private Scheduler scheduler;
    @Resource
    private QuartzEntityMapper quartzEntityMapper;

    /**
     * 项目启动时，初始化定时器
     */
    @PostConstruct
    public void init() throws SchedulerException, TaskException {
        List<QuartzEntity> quartzEntities = list();
        for (QuartzEntity quartzEntity : quartzEntities) {
            CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, quartzEntity.getId());
            // 如果不存在，则创建
            if (cronTrigger == null) {
                ScheduleUtils.createScheduleJob(scheduler, quartzEntity);
            } else {
                ScheduleUtils.updateScheduleJob(scheduler, quartzEntity);
            }
        }
    }

    @Override
    public IPage<QuartzEntity> pageInfo(QuartzEntity vo) {
        Page page = new Page(vo.getPage(), vo.getLimit());


        IPage<QuartzEntity> quartzEntityIPage = quartzEntityMapper.selectAll(page, vo);


    /* List<QuartzEntity> content=quartzEntityIPage.getRecords();
    for(QuartzEntity quartzEntity:content){
        JobKey key = new JobKey(quartzEntity.getJobName(), quartzEntity.getJobGroup());
        JobDetail jobDetail = null;
        try {
            jobDetail = scheduler.getJobDetail(key);
           quartzEntity.setJobMethodName(jobDetail.getJobDataMap().getString("jobMethodName"));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
    quartzEntityIPage.setRecords(content);*/
        return quartzEntityIPage;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveQuartzEntity(QuartzEntity quartz) throws Exception {
        quartz.setCreateTime(DateTimeUI.getCurrentDateTime());
        //quartz.setStatus("0");
        quartz.setId(RandomGUID.getDateUUID());
        int rows = quartzEntityMapper.insertJob(quartz);
        if (rows > 0) {
            ScheduleUtils.createScheduleJob(scheduler, quartz);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateQuartzEntity(QuartzEntity quartz) throws Exception {
        quartz.setUpdateTime(DateTimeUI.getCurrentDateTime());
        int rows = quartzEntityMapper.updateJob(quartz);
        if (rows > 0) {
            ScheduleUtils.updateScheduleJob(scheduler, quartz);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pauseQuartzEntity(String id) throws Exception {
        QuartzEntity quartzEntity = new QuartzEntity();
        quartzEntity.setId(id);
        quartzEntity.setUpdateTime(DateTimeUI.getCurrentDateTime());
        quartzEntity.setStatus("1");
        int rows = quartzEntityMapper.updateJob(quartzEntity);
        if (rows > 0) {
            ScheduleUtils.pauseJob(scheduler, id);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resumeQuartzEntity(String id) throws Exception {
        QuartzEntity quartzEntity = new QuartzEntity();
        quartzEntity.setId(id);
        quartzEntity.setUpdateTime(DateTimeUI.getCurrentDateTime());
        quartzEntity.setStatus("0");
        int rows = quartzEntityMapper.updateJob(quartzEntity);
        if (rows > 0) {
            ScheduleUtils.resumeJob(scheduler, id);
        }
    }

    @Override
    @Transactional(rollbackFor = SchedulerException.class)
    public int deleteJob(String id) throws SchedulerException {
        int rows = quartzEntityMapper.deleteJobById(id);
        if (rows > 0) {
            ScheduleUtils.deleteScheduleJob(scheduler, id);
        }
        return rows;
    }
}
