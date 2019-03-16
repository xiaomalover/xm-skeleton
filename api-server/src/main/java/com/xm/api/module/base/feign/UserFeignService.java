package com.xm.api.module.base.feign;

import com.xm.api.module.base.feign.fallback.UserFeignFallback;
import com.xm.common.vo.Result;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(value = "user-server",fallback = UserFeignFallback.class)
public interface UserFeignService {

    //调用 user-server 服务中的 获取用户信息
    @GetMapping("/user/info")
    Result getUserInfo();
}
