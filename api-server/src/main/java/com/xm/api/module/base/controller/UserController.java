package com.xm.api.module.base.controller;

import com.xm.api.module.base.service.IUserLocalService;
import com.xm.api.module.base.feign.UserFeignService;
import com.xm.common.constant.TokenConstant;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
@RestController
//@RefreshScope //从git仓库热更新配置
@Slf4j
public class UserController {

    @Autowired
    IUserLocalService userLocalService;

    @Autowired
    UserFeignService userFeignService;

    /**
     *  本地接口
     */
    @GetMapping("/hello/{name}")
    public Result hello(@PathVariable String name){
        log.info("调用了Api本地的服务, 参数：{}", name);
        return userLocalService.sayHello(name);
    }

    /**
     * 调用了user-server 的获取用户信息的接口
     */
    @GetMapping("/getUserInfo")
    public Result getUserInfo(HttpServletRequest request){
        log.info("调用了用户微服务，获取用户信息, token: {}", request.getHeader(TokenConstant.TOKEN_PARAM_NAME));
        return userFeignService.getUserInfo();
    }
}
