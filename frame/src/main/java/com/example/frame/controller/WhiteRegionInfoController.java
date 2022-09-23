package com.example.frame.controller;

import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.*;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.entity.IpBlacklistInfo;
import io.swagger.annotations.*;
import org.springframework.web.bind.annotation.*;
import com.example.frame.service.IWhiteRegionInfoService;
import com.example.frame.entity.WhiteRegionInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import com.baomidou.mybatisplus.core.metadata.IPage;

import java.util.List;

import cn.dev33.satoken.annotation.SaCheckPermission;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

/**
 * 系统访问地区白名单 前端控制器
 *
 * @author
 * @author
 */
@Api(tags = {"系统访问地区白名单"})
@Slf4j
@Controller
@RequestMapping("/whiteRegionInfo")
public class WhiteRegionInfoController {

    @Resource
    private IWhiteRegionInfoService whiteRegionInfoService;
    @Resource
    private RedisUtil redisUtil;

    @ApiOperation(value = "新增系统访问地区白名单")
    @PostMapping("/add")
    @LogAnnotation(title = "系统访问地区白名单", action = "新增系统访问地区白名单")
    @ResponseBody
    @SaCheckPermission("whiteRegionInfo-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody WhiteRegionInfo whiteRegionInfo) {

        redisUtil.set("whiteRegion:" + whiteRegionInfo.getRegion() + ":" + whiteRegionInfo.getCity(), "白名单");
        whiteRegionInfo.setId(RandomGUID.getDateUUID());
        whiteRegionInfoService.save(whiteRegionInfo);
        return DataResult.success();
    }

    @ApiOperation(value = "删除系统访问地区白名单")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "系统访问地区白名单", action = "删除系统访问地区白名单")
    @ResponseBody
    @SaCheckPermission("whiteRegionInfo-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {

        for (String id : ids) {
            WhiteRegionInfo whiteRegionInfo = whiteRegionInfoService.getById(id);
            redisUtil.delete("whiteRegion:" + whiteRegionInfo.getRegion() + ":" + whiteRegionInfo.getCity());
        }
        whiteRegionInfoService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新系统访问地区白名单")
    @PutMapping("/update")
    @LogAnnotation(title = "系统访问地区白名单", action = "更新系统访问地区白名单")
    @ResponseBody
    @SaCheckPermission("whiteRegionInfo-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody WhiteRegionInfo whiteRegionInfo) {
        whiteRegionInfoService.updateById(whiteRegionInfo);
        return DataResult.success();
    }

    @ApiOperation(value = "查询系统访问地区白名单分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("whiteRegionInfo-listByPage")
    public DataResult findListByPage(@RequestBody WhiteRegionInfo whiteRegionInfo) {
        Page page = new Page(whiteRegionInfo.getPage(), whiteRegionInfo.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        if (!StringUtil.isNullorEmpty(whiteRegionInfo.getCity())) {
            queryWrapper.like("city", whiteRegionInfo.getCity());
        }

        IPage<WhiteRegionInfo> iPage = whiteRegionInfoService.page(page,
                queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条系统访问地区白名单数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("whiteRegionInfo-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(whiteRegionInfoService.getById(id));
    }


    @ApiOperation(value = "根据条件查询系统访问地区白名单List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("whiteRegionInfo-listByCondition")
    public DataResult listByCondition(@RequestBody WhiteRegionInfo whiteRegionInfo) {
        QueryWrapper queryWrapper = new QueryWrapper();
        return DataResult.success(whiteRegionInfoService.list(queryWrapper));
    }
}
