package com.xm.pay;

import org.springframework.stereotype.Service;

@Service
public class ServerService {

    public String HelloServer1(String str) {
        return "这是Order Server的本地服务接口," + str;
    }
}
