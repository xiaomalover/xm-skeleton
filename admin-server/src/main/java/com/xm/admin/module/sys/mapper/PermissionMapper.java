package com.xm.admin.module.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xm.admin.module.sys.entity.Permission;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Repository
public interface PermissionMapper extends BaseMapper<Permission> {

    /**
     * 通过用户id获取
     *
     * @param userId 用户主键
     * @return 权限列表
     */
    List<Permission> findByUserId(@Param("userId") String userId);

    /**
     * 通过roleId获取
     *
     * @param roleId 角色主键
     * @return 权限列表
     */
    List<Permission> findByRoleId(@Param("roleId") String roleId);
}
