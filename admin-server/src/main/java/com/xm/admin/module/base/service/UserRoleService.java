package com.xm.admin.module.base.service;


import com.xm.admin.base.BaseService;
import com.xm.admin.module.base.entity.co.UserRole;

import java.util.List;

/**
 * 用户角色接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface UserRoleService extends BaseService<UserRole,String> {

    /**
     * 通过roleId查找
     * @param roleId
     * @return
     */
    List<UserRole> findByRoleId(String roleId);

    /**
     * 删除用户角色
     * @param userId
     */
    void deleteByUserId(String userId);
}
