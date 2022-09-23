package com.example.frame.common.job;

import com.example.frame.common.utils.JobInvokeUtil;
import com.example.frame.entity.QuartzEntity;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.JobExecutionContext;

/**
 * @date：Created in 2019/7/21 11:03
 * @description： 定时任务处理（禁止并发执行）
 */
@DisallowConcurrentExecution
public class QuartzDisallowConcurrentExecution extends AbstractQuartzJob {
    @Override
    protected void doExecute(JobExecutionContext context, QuartzEntity job) throws Exception {
        JobInvokeUtil.invokeMethod(job);
    }
}
