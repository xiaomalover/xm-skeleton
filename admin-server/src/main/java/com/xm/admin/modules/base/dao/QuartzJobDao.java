package com.xm.admin.modules.base.dao;

import com.xm.admin.base.BaseDao;
import com.xm.admin.modules.base.entity.QuartzJob;
import java.util.List;

/**
 * 定时任务数据处理层
 * @author Exrick
 */
public interface QuartzJobDao extends BaseDao<QuartzJob,String> {

    /**
     * 通过类名获取
     * @param jobClassName
     * @return
     */
    List<QuartzJob> findByJobClassName(String jobClassName);
}
