package com.xm.zuul;

import com.alibaba.fastjson.JSONObject;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.xm.common.enums.RedisKeyType;
import com.xm.common.utils.ResultUtil;
import com.xm.zuul.utils.CookieUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_DECORATION_FILTER_ORDER;
import static org.springframework.cloud.netflix.zuul.filters.support.FilterConstants.PRE_TYPE;

@Component
@Slf4j
public class AuthFilter extends ZuulFilter {

    @SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
    @Autowired
    RedisTemplate<String, String> redisTemplate;

    //排除过滤的 uri 地址
    private static final String[] ignoreUrls = {
        "/api-server/user/login",
        "/api-server/user/register",
    };

    @Override
    public String filterType() {
        return PRE_TYPE;
    }

    @Override
    public int filterOrder() {
        return PRE_DECORATION_FILTER_ORDER - 1;
    }

    @Override
    public boolean shouldFilter() {
        RequestContext requestContext = RequestContext.getCurrentContext();
        HttpServletRequest request = requestContext.getRequest();
        log.info("uri:{}", request.getRequestURI());

        //IGNORE_URIS中的接口不拦截，其他接口都要拦截校验 token
        return !ArrayUtils.contains(ignoreUrls, request.getRequestURI());
    }

    @Override
    public Object run() {
        RequestContext requestContext = RequestContext.getCurrentContext();
        HttpServletRequest request = requestContext.getRequest();

        //先从 cookie 中取 token，cookie 中取失败再从 header 中取，两重校验
        //通过工具类从 Cookie 中取出 token
        Cookie tokenCookie = CookieUtils.getCookieByName(request, "token");
        if (tokenCookie == null || StringUtils.isEmpty(tokenCookie.getValue())) {
            readTokenFromHeader(requestContext, request);
        } else {
            verifyToken(requestContext, request, tokenCookie.getValue());
        }

        return null;
    }

    /**
     * 从 header 中读取 token 并校验
     *
     * @param requestContext 请求上下文
     * @param request 请求
     *
     */
    private void readTokenFromHeader(RequestContext requestContext, HttpServletRequest request) {
        //从 header 中读取
        String headerToken = request.getHeader("token");
        if (StringUtils.isEmpty(headerToken)) {
            setUnauthorizedResponse(requestContext);
        } else {
            verifyToken(requestContext, request, headerToken);
        }
    }

    /**
     * 从Redis中校验token
     *
     * @param requestContext 请求上下文
     * @param request 请求
     * @param token 用户token
     */
    private void verifyToken(RequestContext requestContext, HttpServletRequest request, String token) {
        //需要从cookie或header 中取出 userId 来校验 token 的有效性，因为每个用户对应一个token，在Redis中是以 TOKEN_userId 为键的
        Cookie userIdCookie = CookieUtils.getCookieByName(request, "userId");
        if (userIdCookie == null || StringUtils.isEmpty(userIdCookie.getValue())) {
            //从header中取userId
            String userId = request.getHeader("userId");
            if (StringUtils.isEmpty(userId)) {
                setUnauthorizedResponse(requestContext);
            } else {
                String redisToken = redisTemplate.opsForValue().get(String.format(RedisKeyType.TOKEN_PREFIX.getKey(), userId));
                if (StringUtils.isEmpty(redisToken) || !redisToken.equals(token)) {
                    setUnauthorizedResponse(requestContext);
                }
            }
        } else {
            String redisToken = redisTemplate.opsForValue().get(String.format(RedisKeyType.TOKEN_PREFIX.getKey(), userIdCookie.getValue()));
            if (StringUtils.isEmpty(redisToken) || !redisToken.equals(token)) {
                setUnauthorizedResponse(requestContext);
            }
        }
    }

    /**
     * 设置 401 无权限状态
     *
     * @param requestContext 请求上下文
     */
    private void setUnauthorizedResponse(RequestContext requestContext) {
        requestContext.setSendZuulResponse(false);
        requestContext.setResponseStatusCode(HttpStatus.UNAUTHORIZED.value());
        String result = JSONObject.
                toJSONString(new ResultUtil<>().setErrorMsg(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.getReasonPhrase()));
        requestContext.setResponseBody(result);
    }
}