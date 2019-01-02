package com.xm.admin.modules.base.service;

import com.xm.admin.base.BaseService;
import com.xm.admin.modules.base.entity.Permission;

import java.util.List;

/**
 * 权限接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface PermissionService extends BaseService<Permission,String> {

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
