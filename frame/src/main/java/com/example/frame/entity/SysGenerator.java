package com.example.frame.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.example.frame.vo.resp.PageReqVO;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * 自动生成
 *
 * @since 2020-03-20
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class SysGenerator extends PageReqVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @ApiModelProperty(value = "主键id")
    @TableId
    private String id;

    /**
     * 表名
     */
    private String tableName;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 上级菜单
     */
    private String pid;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date genTime;

    @TableField(exist = false)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @TableField(exist = false)
    private String tableComment;

    @TableField(exist = false)
    private String search;
}
