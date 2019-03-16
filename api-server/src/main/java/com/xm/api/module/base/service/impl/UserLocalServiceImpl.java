package com.xm.api.module.base.service.impl;

import com.xm.api.module.base.service.IUserLocalService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.stereotype.Service;

@Service
public class UserLocalServiceImpl implements IUserLocalService {

    /**
     * 获取用户信息
     * @return 结果
     */
    @Override
    public Result sayHello(String name) {
        return new ResultUtil<>().setSuccessMsg("Hello:" + name);
    }
}
