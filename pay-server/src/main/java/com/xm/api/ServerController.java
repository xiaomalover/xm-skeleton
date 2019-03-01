package com.xm.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class ServerController {

    @Autowired
    ServerService serverService;
    private final Logger logger = LoggerFactory.getLogger(getClass());

    @GetMapping("/HelloServer2")
    public String HelloServer2(@RequestParam(value = "name") String name, HttpServletRequest request){
        logger.info("=HelloServer2==<call trace-2, TraceId={}, SpanId={}, token={}>===",
                request.getHeader("X-B3-TraceId"), request.getHeader("X-B3-SpanId"), request.getHeader("token"));
        return serverService.HelloServer2(name);
    }
}
