package com.xm.article.module.base.service;

import com.xm.common.vo.Result;

/**
 * 用户相关api本地服务接口的示例服务
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface IUserLocalService {
    /**
     * 获取用户信息
     * @param name 名字
     * @return 结果
     */
    Result sayHello(String name);
}
