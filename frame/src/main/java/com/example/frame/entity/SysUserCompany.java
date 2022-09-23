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
    * 用户单位中间表
    * </p>
 *
 * @since 2021-12-18
 */
    @ApiModel(value="SysUserCompany对象", description="用户单位中间表")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysUserCompany extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "主键id")
    private String id;
        @ApiModelProperty(value = "用户登录id")
    private String userLoginId;
        @ApiModelProperty(value = "社区代码")
    private String sqdm;
        @ApiModelProperty(value = "创建时间")
        @TableField(fill = FieldFill.INSERT)
    private String createTime;
        @ApiModelProperty(value = "更新时间")
        @TableField(fill = FieldFill.UPDATE)
    private String updateTime;
        @ApiModelProperty(value = "时间戳")
        @TableField(fill = FieldFill.INSERT_UPDATE)
    private String syncTime;
        @ApiModelProperty(value = "派出所代码")
    private String pcsdm;

}
