package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * ip黑名单记录表
 *
 * @author
 * @since 2022-02-15
 */
@ApiModel(value = "IpBlacklistInfo对象", description = "ip黑名单记录表")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class IpBlacklistInfo extends PageReqVO {
    private static final long serialVersionUID = 1L;

    private String id;
    @NotBlank(message = "黑名单IP不能为空")
    @ApiModelProperty(value = "黑名单IP")
    private String ip;
    @NotBlank(message = "地址不能为空")
    @ApiModelProperty(value = "地址 (所有则是*)")
    private String mapping;
    @TableField(fill = FieldFill.INSERT)
    private String createTime;
    @TableField(fill = FieldFill.UPDATE)
    private String updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String syncTime;
    @ApiModelProperty(value = "备注原因")
    private String remarks;
    @NotBlank(message = "有效时间不能为空")
    @ApiModelProperty(value = "有效时间 (单位小时) -1则永久")
    private String effectiveTime;
    @NotBlank(message = "是否启用不能为空")
    @ApiModelProperty(value = "是否启用 1启动")
    private String type;




}
