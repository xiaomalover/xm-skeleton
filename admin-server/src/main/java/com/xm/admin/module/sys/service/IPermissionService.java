package com.xm.admin.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xm.admin.module.sys.entity.Permission;
import org.apache.ibatis.annotations.Param;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@CacheConfig(cacheNames = "adminPermission")
public interface IPermissionService extends IService<Permission> {

    /**
     * 通过用户id获取
     *
     * @param userId
     * @return
     */
    @Cacheable(key = "#userId")
    List<Permission> findByUserId(String userId);

    /**
     * 通过roleId获取
     *
     * @param roleId
     * @return
     */
    List<Permission> findByRoleId(@Param("roleId") String roleId);
}
