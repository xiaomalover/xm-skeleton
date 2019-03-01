package com.xm.api.interceptor;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.util.ObjectUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import javax.servlet.http.HttpServletRequest;

/**
 * Feign请求拦截器
 * @author xiaomalover
 **/

public class FeignBasicAuthRequestInterceptor implements RequestInterceptor {

    private static final String TOKEN_KEY = "token";

    @Override
    public void apply(RequestTemplate requestTemplate) {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();

        if (ObjectUtils.isEmpty(requestAttributes)) {
            return;
        }
        HttpServletRequest request = requestAttributes.getRequest();
        if (ObjectUtils.isEmpty(request)) {
            return;
        }
        String token = request.getHeader(TOKEN_KEY);
        if (token == null) {
            return;
        }
        requestTemplate.header(TOKEN_KEY, token);
    }
}
