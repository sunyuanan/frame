package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 用户登录账号表
    * </p>
 *
 * @since 2021-10-26
 */
    @ApiModel(value="SysUserLogin对象", description="用户登录账号表")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysUserLogin extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "主键")
    private String id;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "更新时间")
    private String updateTime;
        @ApiModelProperty(value = "时间戳")
    private String syncTime;
        @ApiModelProperty(value = "账户状态(0.正常 1.锁定  2.临时锁定)")
    private Integer status;
        @ApiModelProperty(value = "登录账号")
    private String account;
        @ApiModelProperty(value = "加密盐值")
    private String salt;
        @ApiModelProperty(value = "密码")
    private String password;
        @ApiModelProperty(value = "加密密码")
    private String encryptionPassword;
        @ApiModelProperty(value = "最后登录时间")
    private String lastLoginTime;
        @ApiModelProperty(value = "用户ID")
    private String userId;
        @ApiModelProperty(value = "单位id")
    private String sdId;
        @ApiModelProperty(value = "账号类型")
    private Integer type;
    @ApiModelProperty(value = "超过3次密码错误则每错一次禁30分钟 5次则锁定")
    private Integer abnormalNum;


}
