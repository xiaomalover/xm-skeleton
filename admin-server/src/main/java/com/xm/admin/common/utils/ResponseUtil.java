package com.xm.admin.common.utils;

import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletResponse;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * 后段响应工具类
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
public class ResponseUtil {

    /**
     * 使用response输出JSON
     *
     * @param response  响应
     * @param resultMap 结果
     */
    public static void out(ServletResponse response, Map<String, Object> resultMap) {

        PrintWriter out = null;
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json");
            out = response.getWriter();
            out.println(new Gson().toJson(resultMap));
        } catch (Exception e) {
            log.error(e + "输出JSON出错");
        } finally {
            if (out != null) {
                out.flush();
                out.close();
            }
        }
    }

    public static Map<String, Object> resultMap(boolean flag, Integer code, String msg) {
        return getBasicResultMap(flag, code, msg);
    }

    public static Map<String, Object> resultMap(boolean flag, Integer code, String msg, Object data) {
        Map<String, Object> resultMap = getBasicResultMap(flag, code, msg);
        resultMap.put("result", data);
        return resultMap;
    }

    private static Map<String, Object> getBasicResultMap(boolean flag, Integer code, String msg) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("success", flag);
        resultMap.put("message", msg);
        resultMap.put("code", code);
        resultMap.put("timestamp", System.currentTimeMillis());
        return resultMap;
    }
}
