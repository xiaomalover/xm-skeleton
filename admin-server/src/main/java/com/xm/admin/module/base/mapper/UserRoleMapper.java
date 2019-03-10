package com.xm.admin.module.base.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xm.admin.module.base.entity.AdminRole;
import com.xm.admin.module.base.entity.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface UserRoleMapper extends BaseMapper<AdminRole> {

    /**
     * 通过用户id获取
     *
     * @param userId
     * @return
     */
    List<Role> findByUserId(@Param("userId") String userId);
}
