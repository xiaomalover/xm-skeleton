package com.xm.api.module.base.feign.fallback;

import com.xm.api.module.base.feign.UserFeignService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.stereotype.Component;

@Component
public class UserFeignFallback implements UserFeignService {

    @Override
    public Result getUserInfo() {
        return new ResultUtil<>().setErrorMsg("从用户服务获取用户信息失败!");
    }
}
