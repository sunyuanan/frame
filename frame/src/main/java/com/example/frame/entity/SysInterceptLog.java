package com.example.frame.entity;


import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 拦截异常日志表
    * </p>
 *
 * @since 2021-10-29
 */
    @ApiModel(value="SysInterceptLog对象", description="拦截异常日志表")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysInterceptLog extends PageReqVO{
    private static final long serialVersionUID = 1L;

    private String id;
        @ApiModelProperty(value = "拦截的IP")
    private String ip;
        @ApiModelProperty(value = "接口地址")
    private String requestUrl;
        @ApiModelProperty(value = "请求方式")
    private String method;
        @ApiModelProperty(value = "参数")
    private String params;

    @ApiModelProperty(value = "创建时间")
    @TableField(fill = FieldFill.INSERT)
    private String createTime;
    @ApiModelProperty(value = "时间戳")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String syncTime;


    private String errorInfo;

}
