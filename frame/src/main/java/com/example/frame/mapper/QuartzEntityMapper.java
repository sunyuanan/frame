package com.example.frame.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.frame.entity.QuartzEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 定时任务调度表 Mapper 接口
 * </p>
 *
 * @author
 * @since 2021-10-30
 */
public interface QuartzEntityMapper extends BaseMapper<QuartzEntity> {
    /**
     *
     * @param page
     * @param vo
     * @return
     */
    IPage<QuartzEntity> selectAll(Page page, @Param(value = "vo") QuartzEntity vo);


    /**
     * 通过调度ID删除调度任务信息
     *
     * @param id 调度ID
     * @return 结果
     */
    public int deleteJobById(String id);

    /**
     * 批量删除调度任务信息
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteJobByIds(String[] ids);

    /**
     * 修改调度任务信息
     *
     * @param quartzEntity 调度任务信息
     * @return 结果
     */
    public int updateJob(QuartzEntity quartzEntity);

    /**
     * 新增调度任务信息
     *
     * @param quartzEntity 调度任务信息
     * @return 结果
     */
    public int insertJob(QuartzEntity quartzEntity);
}
