package com.example.frame.entity;


import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;


import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
 * <p>
 * VIEW
 * </p>
 *
 * @since 2021-11-10
 */
@ApiModel(value = "SysUserLoginView对象", description = "VIEW")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysUserLoginView extends PageReqVO {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "账户状态(0.正常 1.锁定  2.临时锁定)")
    private Integer status;
    @ApiModelProperty(value = "登录账号")
    private String account;
    @ApiModelProperty(value = "加密盐值")
    private String salt;

    @ApiModelProperty(value = "密码")
    @NotEmpty(message = "登录密码不能为空")
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
    @ApiModelProperty(value = "主键")
    private String id;
    @ApiModelProperty(value = "真实名称")
    private String realName;
    @ApiModelProperty(value = "手机号码")
    private String phone;
    @ApiModelProperty(value = "性别(1.男 2.女)")
    private Integer sex;
    @ApiModelProperty(value = "警号")
    private String jh;
    @ApiModelProperty(value = "证件号码")
    private String zjhm;
    @ApiModelProperty(value = "单位编码")
    private String sdCode;
    @ApiModelProperty(value = "角色ID")
    private String roleId;
    @ApiModelProperty(value = "名称")
    private String sdName;
    @ApiModelProperty(value = "路径")
    private String path;
    @ApiModelProperty(value = "编码路径")
    private String sdPath;
    @ApiModelProperty(value = "创建时间")
    private String createTime;
    @ApiModelProperty(value = "用户ID")
    private String relateId;
    @ApiModelProperty(value = "角色名")
    private String roleName;
    @ApiModelProperty(value = "超过3次密码错误则每错一次禁30分钟 5次则锁定")
    private Integer abnormalNum;

    @TableField(exist = false)
    private String search;

    @TableField(exist = false)
    @NotEmpty(message = "角色不能为空")
    private List<String> roleIdList;

    @TableField(exist = false)
    private String time;
}
