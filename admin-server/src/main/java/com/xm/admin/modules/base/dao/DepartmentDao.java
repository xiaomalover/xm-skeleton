package com.xm.admin.modules.base.dao;

import com.xm.admin.base.BaseDao;
import com.xm.admin.modules.base.entity.Department;

import java.util.List;

/**
 * 部门数据处理层
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface DepartmentDao extends BaseDao<Department,String> {

    /**
     * 通过父id获取 升序
     * @param parentId
     * @return
     */
    List<Department> findByParentIdOrderBySortOrder(String parentId);

    /**
     * 通过父id和状态获取 升序
     * @param parentId
     * @param status
     * @return
     */
    List<Department> findByParentIdAndStatusOrderBySortOrder(String parentId, Integer status);
}
