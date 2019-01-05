package com.xm.api;

import com.xm.api.service.FeignService;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
//这里面的属性有可能会更新的，git中的配置中心变化的话就要刷新，没有这个注解内，配置就不能及时更新
@RefreshScope
public class ServerController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    ServerService serverService;
    @Autowired
    FeignService feignService;
    @Autowired
    private RestTemplate restTemplate;

    @Value("${testStr}")
    private String testStr;
    //本地接口
    @GetMapping("/HelloServer1")
    public String HelloServer1(){

        return serverService.HelloServer1(testStr);
    }

    //调用了pay-server的  HelloServer2接口
    @GetMapping("/HelloServer2")
    public String HelloServer2(){
        logger.info("===<call trace-1>===");
        return feignService.HelloServer2("hi");
    }

    //调用了pay-server的  HelloServer2接口
    @GetMapping("/HelloServer3")
    @HystrixCommand(fallbackMethod = "Error")
    public String HelloServer3(){
        logger.info("===<call trace-1>===");
        return restTemplate.getForObject("http://localhost:2002/HelloServer2?name=hi", String.class);
    }

    public String Error() {
        return "hi,系统错误";
    }
}
