package com.xm.api.config;

import com.xm.api.interceptor.FeignBasicAuthRequestInterceptor;
import feign.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FeignConfiguration {
    /**
     * 日志级别
     * @return 日志等级
     */
    @Bean
    Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }

    /**
     * 创建Feign请求拦截器，在发送请求前设置认证的token,各个微服务将token设置到环境变量中来达到通用
     * @return FeignBasicAuthRequestInterceptor
     */
    @Bean
    public FeignBasicAuthRequestInterceptor BasicAuthRequestInterceptor() {
        return new FeignBasicAuthRequestInterceptor();
    }

}
