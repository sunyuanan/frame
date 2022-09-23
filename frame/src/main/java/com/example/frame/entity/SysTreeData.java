package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 树形数据
    * </p>
 *
 * @since 2021-11-05
 */
    @ApiModel(value="SysTreeData对象", description="树形数据")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysTreeData extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "主键")
    private String id;
        @ApiModelProperty(value = "编码")
    private String sdCode;
        @ApiModelProperty(value = "名称")
    private String sdName;
        @ApiModelProperty(value = "父节点id")
    private String sdPid;
        @ApiModelProperty(value = "级别")
    private Integer sdLevel;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "更新时间")
    private String updateTime;
        @ApiModelProperty(value = "时间戳")
    private String syncTime;
        @ApiModelProperty(value = "路径")
    private String path;
        @ApiModelProperty(value = "名称路径")
    private String pathName;
        @ApiModelProperty(value = "类型")
    private String type;
        @ApiModelProperty(value = "备注")
    private String bz;
        @ApiModelProperty(value = "编码路径")
    private String sdPath;

}
