package com.xm.admin.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xm.admin.module.sys.entity.AdminRole;
import com.xm.admin.module.sys.entity.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@CacheConfig(cacheNames = "adminRole")
public interface IUserRoleService extends IService<AdminRole> {

    /**
     * 通过用户id获取
     *
     * @param userId
     * @return
     */
    @Cacheable(key = "#userId")
    List<Role> findByUserId(@Param("userId") String userId);
}
