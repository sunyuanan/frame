package com.example.frame.entity;

import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;

/**
 * @author：Dragon Wen
 * @email：18475536452@163.com
 * @date：Created in 2019/7/21 09:59
 * @description： 定时任务调度日志表 sys_job_log
 * @modified By：
 * @version: 1.0.0
 */
@Data
public class JobLog extends PageReqVO {
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private String jobLogId;

    /**
     * 任务名称
     */
    private String jobName;

    /**
     * 任务组名
     */
    private String jobGroup;

    /**
     * 任务方法
     */
    private String methodName;

    /**
     * 方法参数
     */
    private String methodParams;

    /**
     * 日志信息
     */
    private String jobMessage;

    /**
     * 执行状态（0正常 1失败）
     */
    private String status;

    /**
     * 异常信息
     */
    private String exceptionInfo;

    /**
     * 开始时间
     */
    private String createTime;
}
