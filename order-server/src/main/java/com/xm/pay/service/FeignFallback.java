package com.xm.pay.service;

import org.springframework.stereotype.Component;

@Component
public class FeignFallback implements FeignService{

    @Override
    public String HelloServer2(String name) {
        return "pay-server 接口服务问题!";
    }
}
