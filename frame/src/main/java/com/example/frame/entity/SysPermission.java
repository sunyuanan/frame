package com.example.frame.entity;


import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.List;

/**
 * <p>
    * 系统权限
    * </p>
 *
 * @since 2021-11-02
 */
    @ApiModel(value="SysPermission对象", description="系统权限")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysPermission extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "主键")
    private String id;
        @ApiModelProperty(value = "菜单权限编码")
    private String code;
        @ApiModelProperty(value = "菜单权限名称")
    private String name;
        @ApiModelProperty(value = "授权(多个用逗号分隔，如：SYS:USER:ADD,SYS:USER:EDIT)")
    private String perms;
        @ApiModelProperty(value = "访问地址URL")
    private String url;
        @ApiModelProperty(value = "资源请求类型")
    private String method;
        @ApiModelProperty(value = "父级菜单权限名称")
    private String pid;
        @ApiModelProperty(value = "排序")
    private String orderNum;
        @ApiModelProperty(value = "菜单权限类型(1:目录;2:菜单;3:按钮)")
    private String type;
        @ApiModelProperty(value = "状态1:正常 0：禁用")
    private String status;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "更新时间")
    private String updateTime;
        @ApiModelProperty(value = "是否删除(1未删除；0已删除)")
    private Integer deleted;
    @ApiModelProperty(value = "前端url")
    private String urlWeb;


    @TableField(exist = false)
    private List<SysPermission> children;
    @TableField(exist = false)
    private String pidName;
}
