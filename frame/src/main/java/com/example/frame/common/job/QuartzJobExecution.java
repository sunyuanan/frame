package com.example.frame.common.job;


import com.example.frame.common.utils.JobInvokeUtil;
import com.example.frame.entity.QuartzEntity;
import org.quartz.JobExecutionContext;

/**
 * @date：Created in 2019/7/21 10:59
 * @description： 定时任务处理（允许并发执行）
 */
public class QuartzJobExecution extends AbstractQuartzJob {
    @Override
    protected void doExecute(JobExecutionContext context, QuartzEntity job) throws Exception {
        JobInvokeUtil.invokeMethod(job);
    }
}
