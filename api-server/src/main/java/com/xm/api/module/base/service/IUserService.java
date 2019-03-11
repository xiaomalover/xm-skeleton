package com.xm.api.module.base.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xm.api.dto.UserLoginRequest;
import com.xm.api.module.base.entity.User;
import com.xm.api.dto.UserRegisterRequest;
import com.xm.common.vo.Result;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 用户接口类
 */
public interface IUserService extends IService<User> {

    /**
     * 用户注册
     * @param userRegisterRequest 注册实体
     * @return User
     */
    Result register(UserRegisterRequest userRegisterRequest);

    /**
     * 用户登录
     * @param userLoginRequest 登录实体
     * @return Object
     */
    Result login(UserLoginRequest userLoginRequest);

    /**
     * 查询一个用户
     * @param userId 用户ID
     * @return User
     */
    User getUser(String userId);
}
