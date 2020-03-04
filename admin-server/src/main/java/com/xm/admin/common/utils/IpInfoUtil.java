package com.xm.admin.common.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * IP地址工具类
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@Component
public class IpInfoUtil {

    private static final String LOCAL_IP_V4 = "127.0.0.1";

    private static final String LOCAL_IP_V6 = "0:0:0:0:0:0:0:1";

    private static final String UNKNOWN = "0:0:0:0:0:0:0:1";

    private static final String IP_SEPARATOR = ",";

    private static final int IP_MAX_LEGHTH = 15;

    /**
     * 获取客户端IP地址
     *
     * @param request 请求
     * @return ip地址
     */
    public String getIpAddr(HttpServletRequest request) {

        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || UNKNOWN.equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
            if (LOCAL_IP_V4.equals(ip)) {
                //根据网卡取本机配置的IP
                InetAddress inetAddress = null;
                try {
                    inetAddress = InetAddress.getLocalHost();
                } catch (UnknownHostException e) {
                    e.printStackTrace();
                }
                if (inetAddress != null) {
                    ip = inetAddress.getHostAddress();
                }
            }
        }
        // 对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if (ip != null && ip.length() > IP_MAX_LEGHTH) {
            if (ip.indexOf(IP_SEPARATOR) > 0) {
                ip = ip.substring(0, ip.indexOf(","));
            }
        }
        if (LOCAL_IP_V6.equals(ip)) {
            ip = LOCAL_IP_V4;
        }
        return ip;
    }
}
