package com.xm.admin.modules.base.serviceimpl.mybatis;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.modules.base.dao.mapper.PermissionMapper;
import com.xm.admin.modules.base.entity.Permission;
import com.xm.admin.modules.base.service.mybatis.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Service
public class IPermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements IPermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Override
    public List<Permission> findByUserId(String userId) {

        return permissionMapper.findByUserId(userId);
    }

    @Override
    public List<Permission> findByRoleId(String roleId) {

        return permissionMapper.findByRoleId(roleId);
    }
}
