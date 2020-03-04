package com.xm.admin.module.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.admin.module.sys.entity.Admin;
import com.xm.admin.module.sys.entity.Department;
import com.xm.admin.module.sys.entity.Permission;
import com.xm.admin.module.sys.entity.Role;
import com.xm.admin.module.sys.mapper.AdminMapper;
import com.xm.admin.module.sys.mapper.PermissionMapper;
import com.xm.admin.module.sys.mapper.UserRoleMapper;
import com.xm.admin.module.sys.service.IAdminService;
import com.xm.admin.module.sys.service.IDepartmentService;
import com.xm.common.enums.CommonStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-06
 */
@SuppressWarnings({"SpringJavaAutowiredFieldsWarningInspection"})
@Service
@CacheConfig(cacheNames = "admin")
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements IAdminService {

    @Autowired
    IDepartmentService departmentService;

    @Autowired
    UserRoleMapper userRoleMapper;

    @Autowired
    PermissionMapper permissionMapper;

    /**
     * 获取用户详情令牌
     * <p>
     * 包括 用户令牌， 权限，部门
     *
     * @param username 用户名
     * @return 用户详细信息
     */
    @Override
    @Cacheable(key = "#username")
    public Admin findUserDetailInfo(String username) {

        QueryWrapper<Admin> adminQueryWrapper = new QueryWrapper<>();
        adminQueryWrapper.eq("username", username);
        adminQueryWrapper.eq("status", CommonStatus.STATUS_ENABLED.getStatus());
        Admin admin = getOne(adminQueryWrapper);

        if (!ObjectUtils.isEmpty(admin)) {
            // 关联部门
            if (StrUtil.isNotBlank(admin.getDepartmentId())) {
                Department department = departmentService.getById(admin.getDepartmentId());
                admin.setDepartmentTitle(department.getTitle());
            }
            // 关联角色
            List<Role> roleList = userRoleMapper.findByUserId(admin.getId());
            if (!ObjectUtils.isEmpty(roleList)) {
                admin.setRoles(roleList);
            }
            // 关联权限菜单
            List<Permission> permissionList = permissionMapper.findByUserId(admin.getId());
            admin.setPermissions(permissionList);
            return admin;
        }
        return null;
    }
}
