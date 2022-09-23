package com.example.frame.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import com.example.frame.entity.JobLog;
import com.example.frame.mapper.JobLogMapper;
import com.example.frame.service.IJobLogService;
import org.springframework.stereotype.Service;

/**
 * 测试表 服务实现类
 *
 * @author
 * @since 2020-04-27
 */
@Service
public class JobLogServiceImpl extends ServiceImpl<JobLogMapper, JobLog>
        implements IJobLogService {
}
