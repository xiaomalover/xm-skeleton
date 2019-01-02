package com.xm.admin.modules.base.service;


import com.xm.admin.base.BaseService;
import com.xm.admin.modules.base.entity.UserRole;

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
