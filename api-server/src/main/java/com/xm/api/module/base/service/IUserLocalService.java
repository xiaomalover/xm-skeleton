package com.xm.api.module.base.service;

import com.xm.common.vo.Result;

public interface IUserLocalService {
    /**
     * 获取用户信息
     * @return 结果
     */
    Result sayHello(String name);
}
