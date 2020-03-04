package com.xm.article.module.base.service.impl;

import com.xm.article.module.base.service.IUserLocalService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.stereotype.Service;

/**
 * 用户相关api本地服务实现的示例服务
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Service
public class UserLocalServiceImpl implements IUserLocalService {

    /**
     * 获取用户信息
     * @param name 名字
     * @return 结果
     */
    @Override
    public Result sayHello(String name) {
        return new ResultUtil<>().setSuccessMsg("Hello:" + name);
    }
}
