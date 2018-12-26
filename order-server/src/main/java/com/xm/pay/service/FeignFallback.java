package com.xm.pay.service;

import org.springframework.stereotype.Component;

@Component
public class FeignFallback implements FeignService{

    @Override
    public String HelloServer2(String name) {
        return "server-2 接口服务问题!";
    }
}
