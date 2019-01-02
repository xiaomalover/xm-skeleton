package com.xm.admin.modules.base.service;

import com.xm.admin.base.BaseService;
import com.xm.admin.modules.base.entity.Department;

import java.util.List;

/**
 * 部门接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface DepartmentService extends BaseService<Department,String> {

    /**
     * 通过父id获取 升序
     * @param parentId
     * @return
     */
    List<Department> findByParentIdOrderBySortOrder(String parentId);

    /**
     * 通过父id和状态获取
     * @param parentId
     * @param status
     * @return
     */
    List<Department> findByParentIdAndStatusOrderBySortOrder(String parentId, Integer status);
}
