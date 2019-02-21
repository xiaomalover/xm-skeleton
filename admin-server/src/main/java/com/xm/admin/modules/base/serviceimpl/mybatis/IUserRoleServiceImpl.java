package com.xm.admin.modules.base.serviceimpl.mybatis;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.modules.base.dao.mapper.UserRoleMapper;
import com.xm.admin.modules.base.entity.Role;
import com.xm.admin.modules.base.entity.UserRole;
import com.xm.admin.modules.base.service.mybatis.IUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Service
public class IUserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements IUserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public List<Role> findByUserId(String userId) {

        return userRoleMapper.findByUserId(userId);
    }
}
