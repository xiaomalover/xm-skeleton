package com.xm.admin.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xm.admin.module.sys.entity.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface IPermissionService extends IService<Permission> {

    /**
     * 通过用户id获取
     *
     * @param userId 用户主键
     * @return 权限列表
     */
    List<Permission> findByUserId(String userId);

    /**
     * 通过roleId获取
     *
     * @param roleId 角色主键
     * @return 权限列表
     */
    List<Permission> findByRoleId(@Param("roleId") String roleId);
}
