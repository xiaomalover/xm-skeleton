package com.xm.admin.module.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xm.admin.module.sys.entity.Admin;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-06
 */
@CacheConfig(cacheNames = "admin")
public interface IAdminService extends IService<Admin> {

    /**
     * 获取用户详情令牌
     * <p>
     * 包括 用户令牌， 权限，部门
     *
     * @param username 用户名
     * @return 用户详细信息
     */
    @Cacheable(key = "#username")
    Admin findUserDetailInfo(String username);
}
