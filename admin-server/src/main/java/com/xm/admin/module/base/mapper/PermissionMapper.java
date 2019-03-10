package com.xm.admin.module.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xm.admin.module.base.entity.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface PermissionMapper extends BaseMapper<Permission> {

    /**
     * 通过用户id获取
     *
     * @param userId
     * @return
     */
    List<Permission> findByUserId(@Param("userId") String userId);

    /**
     * 通过roleId获取
     *
     * @param roleId
     * @return
     */
    List<Permission> findByRoleId(@Param("roleId") String roleId);
}
