package com.xm.pay.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(value = "server-2",fallback = FeignFallback.class)
public interface FeignService {

    //调用 server-2 服务中的 hello这个接口服务
    @GetMapping("/HelloServer2")
    String HelloServer2(@RequestParam(value = "name") String name);
}
