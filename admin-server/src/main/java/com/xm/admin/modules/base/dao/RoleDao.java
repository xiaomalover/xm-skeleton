package com.xm.admin.modules.base.dao;

import com.xm.admin.base.BaseDao;
import com.xm.admin.modules.base.entity.Role;

import java.util.List;

/**
 * 角色数据处理层
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface RoleDao extends BaseDao<Role,String> {

    /**
     * 获取默认角色
     * @param defaultRole
     * @return
     */
    List<Role> findByDefaultRole(Boolean defaultRole);
}
