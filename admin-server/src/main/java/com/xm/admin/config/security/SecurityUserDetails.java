package com.xm.admin.config.security;

import cn.hutool.core.util.StrUtil;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.admin.module.sys.entity.Admin;
import com.xm.admin.module.sys.entity.Permission;
import com.xm.admin.module.sys.entity.Role;
import com.xm.common.enums.CommonStatus;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * 安全用户详情类
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
public class SecurityUserDetails extends Admin implements UserDetails {

    private static final long serialVersionUID = 1L;

    SecurityUserDetails(Admin user) {

        if (user != null) {
            this.setUsername(user.getUsername());
            this.setPassword(user.getPassword());
            this.setStatus(user.getStatus());
            this.setRoles(user.getRoles());
            this.setPermissions(user.getPermissions());
        }
    }

    /**
     * 添加用户拥有的权限和角色
     *
     * @return Collection
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

        List<GrantedAuthority> authorityList = new ArrayList<>();
        List<Permission> permissions = this.getPermissions();
        // 添加请求权限
        if (permissions != null && permissions.size() > 0) {
            for (Permission permission : permissions) {
                if (CommonConstant.PERMISSION_OPERATION.equals(permission.getType())
                        && StrUtil.isNotBlank(permission.getTitle())
                        && StrUtil.isNotBlank(permission.getPath())) {

                    authorityList.add(new SimpleGrantedAuthority(permission.getTitle()));
                }
            }
        }
        // 添加角色
        List<Role> roles = this.getRoles();
        if (roles != null && roles.size() > 0) {
            // lambda表达式
            roles.forEach(item -> {
                if (StrUtil.isNotBlank(item.getName())) {
                    authorityList.add(new SimpleGrantedAuthority(item.getName()));
                }
            });
        }
        return authorityList;
    }

    /**
     * 账户是否过期
     *
     * @return boolean
     */
    @Override
    public boolean isAccountNonExpired() {

        return true;
    }

    /**
     * 是否禁用
     *
     * @return boolean
     */
    @Override
    public boolean isAccountNonLocked() {

        return CommonStatus.STATUS_ENABLED.getStatus() == this.getStatus();
    }

    /**
     * 密码是否过期
     *
     * @return boolean
     */
    @Override
    public boolean isCredentialsNonExpired() {

        return true;
    }

    /**
     * 是否启用
     *
     * @return boolean
     */
    @Override
    public boolean isEnabled() {
        return CommonStatus.STATUS_ENABLED.getStatus() == this.getStatus();
    }
}
