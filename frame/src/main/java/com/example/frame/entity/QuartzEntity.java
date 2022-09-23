package com.example.frame.entity;


import com.example.frame.vo.resp.PageReqVO;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotBlank;

/**
 * 任务类 创建者 张志朋 创建时间 2018年3月28日
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class QuartzEntity extends PageReqVO {

    /**
     * 任务ID
     */
    private String id;

    /**
     * 任务名称
     */
    @ApiModelProperty(value = "执行类")
    @NotBlank(message = "执行类不能为空")
    private String jobName;

    /**
     * 任务组名
     */
    @ApiModelProperty(value = "任务组名")
    @NotBlank(message = "任务组名不能为空")
    private String jobGroup;

    /**
     * 任务方法
     */
    @ApiModelProperty(value = "任务方法")
    @NotBlank(message = "任务方法不能为空")
    private String methodName;

    /**
     * 方法参数
     */
    private String methodParams;

    /**
     * cron执行表达式
     */
    @ApiModelProperty(value = "执行表达式")
    @NotBlank(message = "执行表达式不能为空")
    private String cronExpression;

    /**
     * cron计划策略
     */
    private String misfirePolicy = "0";

    /**
     * 是否并发执行（0允许 1禁止）
     */
    private String concurrent;

    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 更新时间
     */
    private String updateTime;
    /**
     * 任务状态（0正常 1暂停）
     */
    private String status;
    /**
     * 备注
     */
    private String remark;
}
