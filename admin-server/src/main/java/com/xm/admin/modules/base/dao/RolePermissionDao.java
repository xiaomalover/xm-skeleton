package com.xm.admin.modules.base.dao;

import com.xm.admin.base.BaseDao;
import com.xm.admin.modules.base.entity.RolePermission;

import java.util.List;

/**
 * 角色权限数据处理层
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface RolePermissionDao extends BaseDao<RolePermission,String> {

    /**
     * 通过permissionId获取
     * @param permissionId
     * @return
     */
    List<RolePermission> findByPermissionId(String permissionId);

    /**
     * 通过roleId删除
     * @param roleId
     */
    void deleteByRoleId(String roleId);
}
