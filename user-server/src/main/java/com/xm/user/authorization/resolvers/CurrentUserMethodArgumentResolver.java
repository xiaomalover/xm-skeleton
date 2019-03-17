package com.xm.user.authorization.resolvers;

import com.xm.user.authorization.annotation.CurrentUser;
import com.xm.user.authorization.manager.TokenManager;
import com.xm.common.constant.TokenConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletResponse;
import java.util.Objects;

/**
 * 增加方法注入，将含有CurrentUser注解的方法参数注入当前登录用户
 * @see com.xm.user.authorization.annotation.CurrentUser
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@SuppressWarnings("NullableProblems")
@Component
public class CurrentUserMethodArgumentResolver implements HandlerMethodArgumentResolver {

    @SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
    @Autowired
    TokenManager tokenManager;

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        //如果参数类型是User并且有CurrentUser注解则支持
        return parameter.getParameterType().isAssignableFrom(String.class) &&
                parameter.hasParameterAnnotation(CurrentUser.class);
    }

    @Override
    public Object resolveArgument(
        MethodParameter parameter,
        ModelAndViewContainer mavContainer,
        NativeWebRequest webRequest,
        WebDataBinderFactory binderFactory
    ) throws HttpServerErrorException {
        String token = webRequest.getHeader(TokenConstant.TOKEN_PARAM_NAME);
        if (!ObjectUtils.isEmpty(token)) {
            //续期token
            tokenManager.refreshToken(token);
            String userId = tokenManager.getUserIdByToken(token);
            if (userId != null) {
                return userId;
            }
        }
        throw new HttpServerErrorException(HttpStatus.UNAUTHORIZED);
    }
}
