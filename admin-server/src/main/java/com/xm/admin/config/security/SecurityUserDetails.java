package com.xm.admin.config.security;

import com.xm.admin.common.constant.CommonConstant;
import com.xm.admin.module.base.entity.Admin;
import com.xm.admin.module.base.entity.Role;
import com.xm.admin.module.base.entity.co.Permission;
import cn.hutool.core.util.StrUtil;
import com.xm.admin.module.base.service.IRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
public class SecurityUserDetails extends Admin implements UserDetails {

    private static final long serialVersionUID = 1L;

    @Autowired
    IRoleService roleService;

    public SecurityUserDetails(Admin user) {

        if(user!=null) {
            this.setUsername(user.getUsername());
            this.setPassword(user.getPassword());
            this.setStatus(user.getStatus());
            this.setRoles(user.getRoles());
            this.setPermissions(user.getPermissions());
            this.setDepartmentTitle(user.getDepartmentTitle());
        }
    }

    /**
     * 添加用户拥有的权限和角色
     * @return
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

        List<GrantedAuthority> authorityList = new ArrayList<>();
        List<Permission> permissions = this.getPermissions();
        // 添加请求权限
        if(permissions!=null&&permissions.size()>0){
            for (Permission permission : permissions) {
                if(CommonConstant.PERMISSION_OPERATION.equals(permission.getType())
                        &&StrUtil.isNotBlank(permission.getTitle())
                        &&StrUtil.isNotBlank(permission.getPath())) {

                    authorityList.add(new SimpleGrantedAuthority(permission.getTitle()));
                }
            }
        }
        // 添加角色
        List<String> roles = this.getRoles();
        if(roles!=null&&roles.size()>0){
           Collection<Role> rolesList = roleService.listByIds(roles);
            // lambda表达式
            rolesList.forEach(item -> {
                if(StrUtil.isNotBlank(item.getName())){
                    authorityList.add(new SimpleGrantedAuthority(item.getName()));
                }
            });
        }
        return authorityList;
    }

    /**
     * 账户是否过期
     * @return
     */
    @Override
    public boolean isAccountNonExpired() {

        return true;
    }

    /**
     * 是否禁用
     * @return
     */
    @Override
    public boolean isAccountNonLocked() {

        return CommonConstant.USER_STATUS_LOCK.equals(this.getStatus()) ? false : true;
    }

    /**
     * 密码是否过期
     * @return
     */
    @Override
    public boolean isCredentialsNonExpired() {

        return true;
    }

    /**
     * 是否启用
     * @return
     */
    @Override
    public boolean isEnabled() {

        return CommonConstant.USER_STATUS_NORMAL.equals(this.getStatus()) ? true : false;
    }
}
