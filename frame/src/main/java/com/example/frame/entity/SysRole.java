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
    * 系统角色
    * </p>
 *
 * @since 2021-11-04
 */
    @ApiModel(value="SysRole对象", description="系统角色")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysRole extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "主键")
    private String id;
        @ApiModelProperty(value = "角色名称")
    private String name;
    private String description;
        @ApiModelProperty(value = "状态(1:正常0:弃用)")
    private String status;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "更新时间")
    private String updateTime;
        @ApiModelProperty(value = "是否删除(1未删除；0已删除)")
    private Integer deleted;
        @ApiModelProperty(value = "角色类型")
    private Integer type;

    @TableField(exist = false)
    private List<String> permissionList;
}
