package com.xm.admin.modules.base.service;


import com.xm.admin.base.BaseService;
import com.xm.admin.modules.base.entity.Role;

import java.util.List;

/**
 * 角色接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface RoleService extends BaseService<Role,String> {

    /**
     * 获取默认角色
     * @param defaultRole
     * @return
     */
    List<Role> findByDefaultRole(Boolean defaultRole);
}
