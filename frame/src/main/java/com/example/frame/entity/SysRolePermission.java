package com.example.frame.entity;


import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
    * 系统角色权限
    * </p>
 *
 * @since 2021-11-02
 */
    @ApiModel(value="SysRolePermission对象", description="系统角色权限")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysRolePermission extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "主键")
    private String id;
        @ApiModelProperty(value = "角色ID")
    private String roleId;
        @ApiModelProperty(value = "菜单权限ID")
    private String permissionId;
        @ApiModelProperty(value = "创建时间")
    private String createTime;

    @TableField(exist = false)
    private String type;



}
