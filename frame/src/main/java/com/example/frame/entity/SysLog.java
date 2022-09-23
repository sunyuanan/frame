package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 系统日志
    * </p>
 *
 * @since 2021-10-28
 */
    @ApiModel(value="SysLog对象", description="系统日志")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysLog extends PageReqVO{
    private static final long serialVersionUID = 1L;

    private String id;
        @ApiModelProperty(value = "用户id")
    private String userId;
        @ApiModelProperty(value = "用户名")
    private String username;
        @ApiModelProperty(value = "用户操作")
    private String operation;
        @ApiModelProperty(value = "响应时间")
    private Integer time;
        @ApiModelProperty(value = "请求方法")
    private String method;
        @ApiModelProperty(value = "请求参数")
    private String params;
        @ApiModelProperty(value = "IP地址")
    private String ip;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "类型0普通型1操作日志")
    private Integer type;

}
