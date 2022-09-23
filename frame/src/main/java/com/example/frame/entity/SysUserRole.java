package com.example.frame.entity;


import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
/**
 * <p>
    * 系统用户角色
    * </p>
 *
 * @since 2021-11-02
 */
    @ApiModel(value="SysUserRole对象", description="系统用户角色")
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class SysUserRole extends PageReqVO{
    private static final long serialVersionUID = 1L;

        @ApiModelProperty(value = "用户ID")
    private String id;
    private String userId;
        @ApiModelProperty(value = "角色ID")
    private String roleId;
        @ApiModelProperty(value = "创建时间")
    private String createTime;
        @ApiModelProperty(value = "单位编码")
    private String sdCode;

}
