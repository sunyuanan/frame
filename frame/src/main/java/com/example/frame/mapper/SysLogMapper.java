package com.example.frame.mapper;

import com.example.frame.entity.SysLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.*;

/**
 * <p>
 * 系统日志 Mapper 接口
 * </p>
 *
 * @author
 * @since 2021-10-28
 */
public interface SysLogMapper extends BaseMapper<SysLog> {

     List<Map<String, Object>> selectPublicItemList(@Param(value="sqlStr") String sqlStr);

      List<Map<String, Object>> selectAllTable();
}
