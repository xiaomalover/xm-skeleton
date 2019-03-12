package com.xm.zuul.filters;

import com.alibaba.fastjson.JSONObject;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;
import com.xm.common.utils.ResultUtil;
import com.xm.common.constant.TokenConstant;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
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
        "/user-server/user/login",
        "/user-server/user/register",
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
        //IGNORE_URIS中的接口不拦截，其他接口都要拦截校验 token
        return !ArrayUtils.contains(ignoreUrls, request.getRequestURI());
    }

    @Override
    public Object run() {
        RequestContext requestContext = RequestContext.getCurrentContext();
        HttpServletRequest request = requestContext.getRequest();

        //从头部获取token校验
        String token = request.getHeader(TokenConstant.TOKEN_PARAM_NAME);
        if (StringUtils.isEmpty(token)) {
            setUnauthorizedResponse(requestContext);
        } else {
            verifyToken(requestContext, token);
        }

        return null;
    }


    /**
     * 从Redis中校验token
     *
     * @param requestContext 请求上下文
     * @param token 用户token
     */
    private void verifyToken(RequestContext requestContext, String token) {
        String redisToken = redisTemplate.opsForValue().get(TokenConstant.TOKEN_KEY_PREFIX + token);
        if (StringUtils.isEmpty(redisToken)) {
            setUnauthorizedResponse(requestContext);
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
        requestContext.getResponse().setContentType("application/json;charset=UTF-8");
    }
}
