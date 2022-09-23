package com.example.frame.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.frame.entity.SysLog;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统日志 服务类
 * </p>
 *
 * @author
 * @since 2021-10-28
 */
public interface ISysLogService extends IService<SysLog> {

    List<Map<String, Object>> sqlInjection(String sql);

    List<Map<String, Object>> selectAllTable();
}
