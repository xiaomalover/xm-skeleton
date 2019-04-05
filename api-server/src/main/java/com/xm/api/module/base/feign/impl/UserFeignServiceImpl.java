package com.xm.api.module.base.feign.impl;

import com.xm.api.module.base.feign.UserFeignService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.stereotype.Component;

/**
 * 这是关于用户服务的远程调用的错误回滚服务
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Component
public class UserFeignServiceImpl implements UserFeignService {

    @Override
    public Result getUserInfo() {
        return new ResultUtil<>().setErrorMsg("从用户服务获取用户信息失败!");
    }
}
