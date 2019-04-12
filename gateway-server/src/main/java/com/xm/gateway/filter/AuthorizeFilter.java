package com.xm.gateway.filter;

import com.alibaba.fastjson.JSONObject;
import com.xm.common.constant.TokenConstant;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.util.StringUtils;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import java.nio.charset.StandardCharsets;

/**
 * token校验全局过滤器
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Component
@Slf4j
public class AuthorizeFilter implements GlobalFilter, Ordered {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    private static AntPathMatcher antPathMatcher = new AntPathMatcher();

    //排除过滤的 uri 地址
    private static final String[] ignoreUrls = {
        "/user/login",
        "/user/register",
    };

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        ServerHttpRequest request = exchange.getRequest();

        boolean isMatch = false;
        for (String item : ignoreUrls) {
            if (antPathMatcher.match(item, request.getPath().toString())) {
                isMatch = true;
                //log.info("[{}]匹配[{}]成功", request.getURI().toString(), item);
                break;
            }
        }

        if (!isMatch) {

            HttpHeaders headers = request.getHeaders();
            String token = headers.getFirst(TokenConstant.TOKEN_PARAM_NAME);
            if (token == null) {
                token = request.getQueryParams().getFirst(TokenConstant.TOKEN_PARAM_NAME);
            }

            if (StringUtils.isEmpty(token)) {
                return getResponseMono(exchange);
            }

            String redisToken = stringRedisTemplate.opsForValue().get(TokenConstant.TOKEN_KEY_PREFIX + token);
            if (StringUtils.isEmpty(redisToken)) {
                return getResponseMono(exchange);
            }
        }

        return chain.filter(exchange);
    }

    private Mono<Void> getResponseMono(ServerWebExchange exchange)
    {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(HttpStatus.UNAUTHORIZED);
        response.getHeaders().add("Content-Type", "application/json");
        Result result = new ResultUtil<>().setErrorMsg(HttpStatus.UNAUTHORIZED.value(), HttpStatus.UNAUTHORIZED.getReasonPhrase());
        String resultJson = JSONObject.toJSONString(result);
        byte[] bytes = resultJson.getBytes(StandardCharsets.UTF_8);
        DataBuffer buffer = response.bufferFactory().wrap(bytes);
        return response.writeWith(Flux.just(buffer));
    }

    @Override
    public int getOrder() {
        return 0;
    }
}
