package com.xm.article.module.base.feign;

import com.xm.article.module.base.feign.impl.UserFeignServiceImpl;
import com.xm.common.vo.Result;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 用户服务的远程调用服务
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@FeignClient(value = "user-server",fallback = UserFeignServiceImpl.class)
public interface UserFeignService {

    /**
     * 调用 user-server 服务中的 获取用户信息
     * @return 结果对象
     */
    @GetMapping("/user/info")
    Result getUserInfo();
}
