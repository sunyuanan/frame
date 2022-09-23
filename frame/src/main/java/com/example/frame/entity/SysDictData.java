package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 字典数据表
    * </p>
 *
 * @since 2021-11-04
 */
    @ApiModel(value="SysDictData对象", description="字典数据表")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysDictData extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "字典编码")
    private String id;
        @ApiModelProperty(value = "字典排序")
    private Integer dictSort;
        @ApiModelProperty(value = "字典标签")
    private String dictLabel;
        @ApiModelProperty(value = "字典键值")
    private String dictValue;
        @ApiModelProperty(value = "字典类型")
    private String dictType;
        @ApiModelProperty(value = "状态（0正常 1停用）")
    private String status;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "更新时间")
    private String updateTime;
        @ApiModelProperty(value = "时间戳")
    private String syncTime;
        @ApiModelProperty(value = "备注")
    private String remark;
        @ApiModelProperty(value = "类型ID")
    private String typeId;

}
