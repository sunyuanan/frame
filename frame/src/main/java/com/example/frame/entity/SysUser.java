package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 系统用户
    * </p>
 *
 * @since 2021-10-26
 */
    @ApiModel(value="SysUser对象", description="系统用户")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysUser extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "用户ID")
    private String id;
        @ApiModelProperty(value = "手机号码")
    private String phone;
        @ApiModelProperty(value = "真实名称")
    private String realName;
        @ApiModelProperty(value = "性别(1.男 2.女)")
    private Integer sex;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "更新时间")
    private String updateTime;
        @ApiModelProperty(value = "时间戳")
    private String syncTime;
        @ApiModelProperty(value = "警号")
    private String jh;
        @ApiModelProperty(value = "证件号码")
    private String zjhm;

}
