package com.xm.admin.module.base.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.module.base.entity.AdminRole;
import com.xm.admin.module.base.entity.Role;
import com.xm.admin.module.base.mapper.UserRoleMapper;
import com.xm.admin.module.base.service.IUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Service
public class IUserRoleServiceImpl extends ServiceImpl<UserRoleMapper, AdminRole> implements IUserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public List<Role> findByUserId(String userId) {

        return userRoleMapper.findByUserId(userId);
    }
}
