package com.example.frame.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.frame.entity.SysLog;
import com.example.frame.mapper.SysLogMapper;
import com.example.frame.service.ISysLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统日志 服务实现类
 * </p>
 *
 * @author
 * @since 2021-10-28
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements ISysLogService {

    @Resource
    private SysLogMapper sysLogMapper;

    @Override
    public List<Map<String, Object>> sqlInjection(String sql) {
        List<Map<String, Object>> linkedList = sysLogMapper.selectPublicItemList(sql);
        return linkedList;
    }

    @Override
    public List<Map<String, Object>> selectAllTable() {
        List<Map<String, Object>> linkedList = sysLogMapper.selectAllTable();
        return linkedList;
    }

}
