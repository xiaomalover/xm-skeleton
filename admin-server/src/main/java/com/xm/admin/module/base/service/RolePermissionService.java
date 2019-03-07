package com.xm.admin.module.base.service;

import com.xm.admin.base.BaseService;
import com.xm.admin.module.base.entity.co.RolePermission;

import java.util.List;

/**
 * 角色权限接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface RolePermissionService extends BaseService<RolePermission,String> {

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
