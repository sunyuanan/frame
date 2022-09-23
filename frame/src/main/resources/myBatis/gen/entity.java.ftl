package ${package.Entity};


<#if swagger2>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
import com.example.frame.vo.resp.PageReqVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
/**
 *
    * ${table.comment}
    *@author
    *
 *
 * @since ${date}
 */
<#if table.convert>
@TableName("${table.name}")
</#if>
<#if swagger2>
    @ApiModel(value="${entity}对象", description="${table.comment!}")
</#if>
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class ${entity} extends PageReqVO  implements Serializable {
    private static final long serialVersionUID = 1L;

<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>
    <#if field.comment!?length gt 0>
        <#if swagger2>
        @ApiModelProperty(value = "${field.comment}")
        <#else>
    /**
     * ${field.comment}
     */
        </#if>
    </#if>
    <#if field.propertyName == "createTime">
        @TableField(fill = FieldFill.INSERT)
    </#if>
    <#if field.propertyName == "syncTime">
        @TableField(fill = FieldFill.INSERT_UPDATE)
    </#if>
    <#if field.propertyName == "updateTime">
        @TableField(fill = FieldFill.UPDATE)
    </#if>
    <#if field.propertyName == "tbzt">
        @TableField(fill = FieldFill.INSERT_UPDATE)
    </#if>
    private ${field.propertyType} ${field.propertyName};
</#list>
<#-- ----------  END 字段循环遍历  ---------->

}
