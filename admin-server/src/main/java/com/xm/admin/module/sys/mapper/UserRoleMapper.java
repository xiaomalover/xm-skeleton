package com.xm.admin.module.sys.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xm.admin.module.sys.entity.AdminRole;
import com.xm.admin.module.sys.entity.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Repository
public interface UserRoleMapper extends BaseMapper<AdminRole> {

    /**
     * 通过用户id获取
     *
     * @param userId 用户ID
     * @return 角色列表
     */
    List<Role> findByUserId(@Param("userId") String userId);
}
