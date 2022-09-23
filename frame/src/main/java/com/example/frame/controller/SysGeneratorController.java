package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.common.aop.annotation.CheckLockAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.entity.SysGenerator;
import com.example.frame.service.ISysGeneratorService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;


@Api(tags = {"代码生成表"})
@Slf4j
@Controller
@RequestMapping("/sysGenerator")
@RestController
public class SysGeneratorController {

    @Resource
    private ISysGeneratorService sysGeneratorService;

    @ApiOperation(value = "生成")
    @PostMapping("/add")
    @SaCheckPermission("sysGenerator-listByPage")
    @CheckLockAnnotation()
    public DataResult add(@RequestBody SysGenerator sysGenerator) {
        sysGeneratorService.gen(sysGenerator);
        return DataResult.success();
    }


    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @SaCheckPermission("sysGenerator-listByPage")
    public DataResult findListByPage(@RequestBody SysGenerator vo) {
        Page page = new Page(vo.getPage(), vo.getLimit());
        IPage<SysGenerator> iPage = sysGeneratorService.selectAllTables(page, vo);
        return DataResult.success(iPage);
    }

}
