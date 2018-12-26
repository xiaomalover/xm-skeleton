package com.xm.pay;


import org.springframework.stereotype.Service;

@Service
public class ServerService {


    public  String  HelloServer2(String str){

        return "这是Server2的本地服务接口,"+str;
    }
}
