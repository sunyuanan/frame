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
 * 系统访问地区白名单
 *
 * @author
 * @since 2022-03-01
 */
@ApiModel(value = "WhiteRegionInfo对象", description = "系统访问地区白名单")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class WhiteRegionInfo extends PageReqVO {
    private static final long serialVersionUID = 1L;

    private String id;
    @ApiModelProperty(value = "城市")
    private String city;
    @TableField(fill = FieldFill.INSERT)
    private String createTime;
    @TableField(fill = FieldFill.UPDATE)
    private String updateTime;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String syncTime;
    @ApiModelProperty(value = "省")
    private String region;

}
