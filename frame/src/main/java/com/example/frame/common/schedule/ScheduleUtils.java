package com.example.frame.common.schedule;

import com.example.frame.common.job.QuartzDisallowConcurrentExecution;
import com.example.frame.common.job.QuartzJobExecution;
import com.example.frame.common.job.TaskException;
import com.example.frame.common.constant.ScheduleConstants;
import com.example.frame.entity.QuartzEntity;
import org.quartz.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author：Dragon Wen
 * @email：18475536452@163.com
 * @date：Created in 2019/7/21 10:21
 * @description： 定时任务工具类
 * @modified By：
 * @version: 1.0.0
 */
public class ScheduleUtils {

    private static final Logger log = LoggerFactory.getLogger(ScheduleUtils.class);

    /**
     * 得到quartz任务类
     *
     * @param job 执行计划
     * @return 具体执行任务类
     */
    private static Class<? extends Job> getQuartzJobClass(QuartzEntity job) {
        boolean isConcurrent = "0".equals(job.getConcurrent());
        return isConcurrent ? QuartzJobExecution.class : QuartzDisallowConcurrentExecution.class;
    }

    /**
     * 获取触发器key
     */
    public static TriggerKey getTriggerKey(String id) {
        return TriggerKey.triggerKey(ScheduleConstants.TASK_CLASS_NAME + id);
    }

    /**
     * 获取jobKey
     */
    public static JobKey getJobKey(String jobId) {
        return JobKey.jobKey(ScheduleConstants.TASK_CLASS_NAME + jobId);
    }

    /**
     * 获取表达式触发器
     */
    public static CronTrigger getCronTrigger(Scheduler scheduler, String id) {
        try {
            return (CronTrigger) scheduler.getTrigger(getTriggerKey(id));
        } catch (SchedulerException e) {
            log.error("getCronTrigger 异常：", e);
        }
        return null;
    }

    /**
     * 创建定时任务
     */
    public static void createScheduleJob(Scheduler scheduler, QuartzEntity job)
            throws SchedulerException, TaskException {
        Class<? extends Job> jobClass = getQuartzJobClass(job);
        // 构建job信息
        JobDetail jobDetail = JobBuilder.newJob(jobClass).withIdentity(getJobKey(job.getId())).build();

        // 表达式调度构建器
        CronScheduleBuilder cronScheduleBuilder =
                CronScheduleBuilder.cronSchedule(job.getCronExpression());
        cronScheduleBuilder = handleCronScheduleMisfirePolicy(job, cronScheduleBuilder);

        // 按新的cronExpression表达式构建一个新的trigger
        CronTrigger trigger =
                TriggerBuilder.newTrigger()
                        .withIdentity(getTriggerKey(job.getId()))
                        .withSchedule(cronScheduleBuilder)
                        .build();

        // 放入参数，运行时的方法可以获取
        jobDetail.getJobDataMap().put(ScheduleConstants.TASK_PROPERTIES, job);

        scheduler.scheduleJob(jobDetail, trigger);

        // 暂停任务
        if (ScheduleConstants.Status.PAUSE.getValue().equals(job.getStatus())) {
            pauseJob(scheduler, job.getId());
        }
    }

    /**
     * 更新定时任务
     */
    public static void updateScheduleJob(Scheduler scheduler, QuartzEntity job)
            throws SchedulerException, TaskException {
        JobKey jobKey = getJobKey(job.getId());

        // 判断是否存在
        if (scheduler.checkExists(jobKey)) {
            // 先移除，然后做更新操作
            scheduler.deleteJob(jobKey);
        }

        createScheduleJob(scheduler, job);

        // 暂停任务
        pauseJob(scheduler, job.getId());
    /*  if (job.getStatus().equals(ScheduleConstants.Status.PAUSE.getValue())) {
        pauseJob(scheduler, job.getId());
    }*/
    }

    /**
     * 立即执行任务
     */
    public static void run(Scheduler scheduler, QuartzEntity job) throws SchedulerException {
        // 参数
        JobDataMap dataMap = new JobDataMap();
        dataMap.put(ScheduleConstants.TASK_PROPERTIES, job);

        scheduler.triggerJob(getJobKey(job.getId()), dataMap);
    }

    /**
     * 暂停任务
     */
    public static void pauseJob(Scheduler scheduler, String jobId) throws SchedulerException {
        scheduler.pauseJob(getJobKey(jobId));
    }

    /**
     * 恢复任务
     */
    public static void resumeJob(Scheduler scheduler, String jobId) throws SchedulerException {
        scheduler.resumeJob(getJobKey(jobId));
    }

    /**
     * 删除定时任务
     */
    public static void deleteScheduleJob(Scheduler scheduler, String jobId)
            throws SchedulerException {
        scheduler.deleteJob(getJobKey(jobId));
    }

    public static CronScheduleBuilder handleCronScheduleMisfirePolicy(
            QuartzEntity job, CronScheduleBuilder cb) throws TaskException {
        switch (job.getMisfirePolicy()) {
            case ScheduleConstants.MISFIRE_DEFAULT:
                return cb;
            case ScheduleConstants.MISFIRE_IGNORE_MISFIRES:
                return cb.withMisfireHandlingInstructionIgnoreMisfires();
            case ScheduleConstants.MISFIRE_FIRE_AND_PROCEED:
                return cb.withMisfireHandlingInstructionFireAndProceed();
            case ScheduleConstants.MISFIRE_DO_NOTHING:
                return cb.withMisfireHandlingInstructionDoNothing();
            default:
                throw new TaskException(
                        "The task misfire policy '"
                                + job.getMisfirePolicy()
                                + "' cannot be used in cron schedule tasks",
                        TaskException.Code.CONFIG_ERROR);
        }
    }
}
