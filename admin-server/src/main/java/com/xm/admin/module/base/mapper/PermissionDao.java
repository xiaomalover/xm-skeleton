package com.xm.admin.module.base.mapper;

import com.xm.admin.base.BaseDao;
import com.xm.admin.module.base.entity.co.Permission;

import java.util.List;

/**
 * 权限数据处理层
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface PermissionDao extends BaseDao<Permission,String> {

    /**
     * 通过层级查找
     * 默认升序
     * @param level
     * @return
     */
    List<Permission> findByLevelOrderBySortOrder(Integer level);

    /**
     * 通过parendId查找
     * @param parentId
     * @return
     */
    List<Permission> findByParentIdOrderBySortOrder(String parentId);

    /**
     * 通过类型和状态获取
     * @param type
     * @param status
     * @return
     */
    List<Permission> findByTypeAndStatusOrderBySortOrder(Integer type, Integer status);

    /**
     * 通过名称获取
     * @param title
     * @return
     */
    List<Permission> findByTitle(String title);
}
