package com.xm.admin.module.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.module.sys.entity.Permission;
import com.xm.admin.module.sys.mapper.PermissionMapper;
import com.xm.admin.module.sys.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@SuppressWarnings({"SpringJavaInjectionPointsAutowiringInspection", "SpringJavaAutowiredFieldsWarningInspection"})
@Service("permissionService")
@CacheConfig(cacheNames = "adminPermission")
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements IPermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    @Cacheable(key = "#userId")
    public List<Permission> findByUserId(String userId) {
        return permissionMapper.findByUserId(userId);
    }

    @Override
    public List<Permission> findByRoleId(String roleId) {
        return permissionMapper.findByRoleId(roleId);
    }
}
