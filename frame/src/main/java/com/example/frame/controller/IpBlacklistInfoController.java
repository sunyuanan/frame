package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.RedisUtil;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.entity.IpBlacklistInfo;
import com.example.frame.service.IIpBlacklistInfoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * ip黑名单记录表 前端控制器
 *
 * @author
 * @author
 */
@Api(tags = {"ip黑名单记录表"})
@Slf4j
@Controller
@RequestMapping("/ipBlacklistInfo")
public class IpBlacklistInfoController {

    @Resource
    private IIpBlacklistInfoService ipBlacklistInfoService;
    @Resource
    private RedisUtil redisUtil;


    @ApiOperation(value = "新增ip黑名单记录表")
    @PostMapping("/add")
    @LogAnnotation(title = "ip黑名单记录表", action = "新增ip黑名单记录表")
    @ResponseBody
    @SaCheckPermission("ipBlacklistInfo-add")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody IpBlacklistInfo ipBlacklistInfo) {

        /*存入redis*/
        redisUtil.set("backListIp:" + ipBlacklistInfo.getIp(), "*", Long.parseLong(ipBlacklistInfo.getEffectiveTime()), TimeUnit.HOURS);

        ipBlacklistInfo.setId(RandomGUID.getDateUUID());
        ipBlacklistInfo.setMapping("*");
        ipBlacklistInfoService.save(ipBlacklistInfo);

        return DataResult.success();
    }

    @ApiOperation(value = "删除ip黑名单记录表")
    @DeleteMapping("/delete")
    @LogAnnotation(title = "ip黑名单记录表", action = "删除ip黑名单记录表")
    @ResponseBody
    @SaCheckPermission("ipBlacklistInfo-delete")
    @CheckLockAnnotation()
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {

        for (String id : ids) {
            IpBlacklistInfo ipBlacklistInfo = ipBlacklistInfoService.getById(id);
            redisUtil.delete("backListIp:" + ipBlacklistInfo.getIp());
        }

        ipBlacklistInfoService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新ip黑名单记录表")
    @PutMapping("/update")
    @LogAnnotation(title = "ip黑名单记录表", action = "更新ip黑名单记录表")
    @ResponseBody
    @SaCheckPermission("ipBlacklistInfo-update")
    @CheckLockAnnotation()
    public DataResult update(@RequestBody IpBlacklistInfo ipBlacklistInfo) {
        ipBlacklistInfoService.updateById(ipBlacklistInfo);
        return DataResult.success();
    }

    @ApiOperation(value = "查询ip黑名单记录表分页数据")
    @PostMapping("/listByPage")
    @ResponseBody
    @SaCheckPermission("ipBlacklistInfo-listByPage")
    public DataResult findListByPage(@RequestBody IpBlacklistInfo ipBlacklistInfo) {
        Page page = new Page(ipBlacklistInfo.getPage(), ipBlacklistInfo.getLimit());
        QueryWrapper queryWrapper = new QueryWrapper();
        if (!StringUtil.isNullorEmpty(ipBlacklistInfo)) {
            queryWrapper.like("ip", ipBlacklistInfo.getIp());
        }
        IPage<IpBlacklistInfo> iPage = ipBlacklistInfoService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }


    @ApiOperation(value = "根据id查询单条ip黑名单记录表数据")
    @PostMapping("/listById")
    @ResponseBody
    @SaCheckPermission("ipBlacklistInfo-listById")
    public DataResult listById(@RequestParam String id) {
        return DataResult.success(ipBlacklistInfoService.getById(id));
    }


    @ApiOperation(value = "根据条件查询ip黑名单记录表List数据")
    @PostMapping("/listByCondition")
    @ResponseBody
    @SaCheckPermission("ipBlacklistInfo-listByCondition")
    public DataResult listByCondition(@RequestBody IpBlacklistInfo ipBlacklistInfo) {
        QueryWrapper queryWrapper = new QueryWrapper();
        return DataResult.success(ipBlacklistInfoService.list(queryWrapper));
    }
}
