package com.xm.admin.module.base.mapper;

import com.xm.admin.module.base.entity.Role;
import com.xm.admin.module.base.entity.co.UserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface UserRoleMapper extends BaseMapper<UserRole> {

    /**
     * 通过用户id获取
     * @param userId
     * @return
     */
    List<Role> findByUserId(@Param("userId") String userId);
}
