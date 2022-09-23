package ${package.Controller};

import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.RandomGUID;
import com.alibaba.fastjson.JSONObject;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import ${package.Service}.${table.serviceName};
import ${package.Entity}.${entity};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import cn.dev33.satoken.annotation.SaCheckPermission;
import javax.annotation.Resource;
<#if restControllerStyle>
import org.springframework.stereotype.Controller;
<#else>
import org.springframework.stereotype.Controller;
</#if>
<#if superControllerClassPackage??>
import ${superControllerClassPackage};
</#if>

/**
 *
    * ${table.comment!} 前端控制器
    * @author
 *
 * @author
 */
<#if restControllerStyle>
@Api(tags = {"${table.comment!}"})
@Slf4j
@Controller
<#else>
@Controller
</#if>
@RequestMapping("/${entity?uncap_first}")
<#if kotlin>
class ${table.controllerName}<#if superControllerClass??>:${superControllerClass}()</#if>
<#else>
    <#if superControllerClass??>public class ${table.controllerName} extends ${superControllerClass}{
    <#else>public class ${table.controllerName} {
    </#if>

    @Resource
    private ${table.serviceName} ${(table.serviceName?substring(1))?uncap_first};



    @ApiOperation(value = "新增${table.comment!}")
    @PostMapping("/add")
    @LogAnnotation(title = "${table.comment}", action = "新增${table.comment}")
    @ResponseBody
    @SaCheckPermission("${entity?uncap_first}-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody ${entity} ${entity?uncap_first}){
    ${entity?uncap_first}.setId(RandomGUID.getDateUUID());
    ${(table.serviceName?substring(1))?uncap_first}.save(${entity?uncap_first});
        return DataResult.success();
    }

    @ApiOperation(value = "删除${table.comment!}")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "${table.comment}", action = "删除${table.comment}")
    @ResponseBody
    @SaCheckPermission("${entity?uncap_first}-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
    ${(table.serviceName?substring(1))?uncap_first}.removeByIds(ids);
    return DataResult.success();
    }

    @ApiOperation(value = "更新${table.comment!}")
    @PutMapping("/update")
    @LogAnnotation(title = "${table.comment}", action = "更新${table.comment}")
    @ResponseBody
    @SaCheckPermission("${entity?uncap_first}-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody ${entity} ${entity?uncap_first}){
        ${(table.serviceName?substring(1))?uncap_first}.updateById(${entity?uncap_first});
        return DataResult.success();
    }

    @ApiOperation(value = "查询${table.comment!}分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("${entity?uncap_first}-listByPage")
    public DataResult findListByPage(@RequestBody ${entity} ${entity?uncap_first}){
    Page page = new Page(${entity?uncap_first}.getPage(), ${entity?uncap_first}.getLimit());
    QueryWrapper queryWrapper = new QueryWrapper();
    //查询条件示例
    //queryWrapper.eq("id", ${entity?uncap_first}.getId());
    IPage<${entity}> iPage = ${(table.serviceName?substring(1))?uncap_first}.page(page,
    queryWrapper);
    return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条${table.comment!}数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("${entity?uncap_first}-listById")
    public DataResult listById(@RequestParam String id){
    return DataResult.success(${(table.serviceName?substring(1))?uncap_first}.getById(id));
    }



    @ApiOperation(value = "根据条件查询${table.comment!}List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("${entity?uncap_first}-listByCondition")
    public DataResult listByCondition(@RequestBody ${entity} ${entity?uncap_first}) {
    QueryWrapper queryWrapper = new QueryWrapper();
    return DataResult.success(${(table.serviceName?substring(1))?uncap_first}.list(queryWrapper));
    }
    }
</#if>
