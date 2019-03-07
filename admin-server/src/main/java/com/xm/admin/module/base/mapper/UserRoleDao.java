package com.xm.admin.module.base.mapper;

import com.xm.admin.base.BaseDao;
import com.xm.admin.module.base.entity.co.UserRole;

import java.util.List;

/**
 * 用户角色数据处理层
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface UserRoleDao extends BaseDao<UserRole,String> {

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
