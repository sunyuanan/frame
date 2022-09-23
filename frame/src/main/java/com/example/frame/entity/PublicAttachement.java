package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;

/**
 * <p>
 * 附件信息表
 * </p>
 *
 * @since 2021-12-18
 */
@ApiModel(value = "PublicAttachement对象", description = "附件信息表")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class PublicAttachement extends PageReqVO {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    private String id;
    @ApiModelProperty(value = "附件名称")
    private String fjmc;
    @ApiModelProperty(value = "附件路径")
    private String fjlj;
    @ApiModelProperty(value = "创建时间")
    @TableField(fill = FieldFill.INSERT)
    private String createTime;
    @ApiModelProperty(value = "更新时间")
    @TableField(fill = FieldFill.UPDATE)
    private String updateTime;
    @ApiModelProperty(value = "时间戳")
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String syncTime;
    @ApiModelProperty(value = "关联id")
    private String glid;
    @ApiModelProperty(value = "附件类型")
    private String fjlx;
    @ApiModelProperty(value = "附件后缀")
    private String fjhzm;
    @ApiModelProperty(value = "原始名称")
    private String ysmc;
    @ApiModelProperty(value = "附件大类")
    private String fjdl;

    @TableField(exist = false)
    private String search;
}
