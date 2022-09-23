package com.example.frame.controller;


import cn.dev33.satoken.annotation.SaCheckPermission;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.schedule.ScheduleUtils;
import com.example.frame.common.utils.CronUtils;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.entity.QuartzEntity;
import com.example.frame.service.IJobService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import org.slf4j.Logger;

import javax.validation.Valid;
import java.util.List;

@Api(tags = "任务调度")
@Controller
@RequestMapping("/job")
public class JobController {

    private static final Logger LOGGER = LoggerFactory.getLogger(JobController.class);

    @Autowired
    private Scheduler scheduler;
    @Autowired
    private IJobService jobService;


    @ApiOperation(value = "新增任务")
    @PostMapping("/add")
    @ResponseBody
    @SaCheckPermission("job-add")
    @CheckLockAnnotation()
    @LogAnnotation(title = "新增任务", action = "新增任务")
    public DataResult add(@RequestBody @Valid QuartzEntity quartzEntity) {
        try {
            Boolean result = CronUtils.isValid(quartzEntity.getCronExpression());
            if (result) {
                jobService.saveQuartzEntity(quartzEntity);
            } else {
                return DataResult.getResult(1, "执行表达式校验不通过");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return DataResult.success();
    }

    @ApiOperation(value = "更新测试表")
    @PutMapping("/edit")
    @ResponseBody
    @SaCheckPermission("job-edit")
    @CheckLockAnnotation()
    @LogAnnotation(title = "更新测试表", action = "更新测试表")
    public DataResult edit(@RequestBody @Valid QuartzEntity quartzEntity) {
        quartzEntity.setUpdateTime(DateTimeUI.getCurrentDateTime());
        try {
            Boolean result = CronUtils.isValid(quartzEntity.getCronExpression());
            if (result) {
                jobService.updateQuartzEntity(quartzEntity);
            } else {
                return DataResult.getResult(1, "执行表达式校验不通过");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return DataResult.success();
    }

    @PostMapping("/listByPage")
    @ApiOperation(value = "分页获取信息接口")
    @ResponseBody
    @SaCheckPermission("job-listByPage")
    public DataResult pageInfo(@RequestBody QuartzEntity vo) {
        return DataResult.success(jobService.pageInfo(vo));
    }


    @PostMapping("/trigger")
    @ApiOperation(value = "触发任务接口")
    @ResponseBody
    @SaCheckPermission("job-trigger")
    @CheckLockAnnotation()
    @LogAnnotation(title = "触发任务接口", action = "触发任务接口")
    public DataResult trigger(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        LOGGER.info("触发任务");
        for (String id : ids) {
            try {
                ScheduleUtils.run(scheduler, jobService.getById(id));
            } catch (SchedulerException e) {
                e.printStackTrace();
            }
        }
        return DataResult.success();
    }

    @PostMapping("/pause")
    @ApiOperation(value = "停止任务接口")
    @ResponseBody
    @SaCheckPermission("job-pause")
    @CheckLockAnnotation()
    @LogAnnotation(title = "停止任务接口", action = "停止任务接口")
    public DataResult pause(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        LOGGER.info("停止任务");
        for (String id : ids) {
            try {
                jobService.pauseQuartzEntity(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return DataResult.success();
    }

    @PostMapping("/resume")
    @ResponseBody
    @ApiOperation(value = "恢复任务接口")
    @SaCheckPermission("job-resume")
    @CheckLockAnnotation()
    @LogAnnotation(title = "恢复任务接口", action = "恢复任务接口")
    public DataResult resume(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        LOGGER.info("恢复任务");
        for (String id : ids) {
            try {
                jobService.resumeQuartzEntity(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return DataResult.success();
    }

    @DeleteMapping("/deleted")
    @ResponseBody
    @ApiOperation(value = "删除任务接口")
    @SaCheckPermission("job-deleted")
    @CheckLockAnnotation()
    @LogAnnotation(title = "删除任务接口", action = "删除任务接口")
    public DataResult remove(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        for (String id : ids) {
            try {
                jobService.deleteJob(id);
            } catch (SchedulerException e) {
                e.printStackTrace();
            }
        }
        return DataResult.success();
    }
}
