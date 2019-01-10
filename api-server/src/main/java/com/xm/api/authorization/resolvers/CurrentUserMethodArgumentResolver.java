package com.xm.api.authorization.resolvers;

import com.xm.api.authorization.annotation.CurrentUser;
import com.xm.api.authorization.manager.TokenManager;
import com.xm.common.constant.TokenConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.multipart.support.MissingServletRequestPartException;

/**
 * 增加方法注入，将含有CurrentUser注解的方法参数注入当前登录用户
 * @see com.xm.api.authorization.annotation.CurrentUser
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
        return parameter.getParameterType().isAssignableFrom(Integer.class) &&
                parameter.hasParameterAnnotation(CurrentUser.class);
    }

    @Override
    public Object resolveArgument(
        MethodParameter parameter,
        ModelAndViewContainer mavContainer,
        NativeWebRequest webRequest,
        WebDataBinderFactory binderFactory
    ) throws Exception {
        String token = webRequest.getHeader(TokenConstant.TOKEN_PARAM_NAME);
        if (!ObjectUtils.isEmpty(token)) {
            //续期token
            tokenManager.refreshToken(token);
            Integer userId = tokenManager.getUserIdByToken(token);
            if (userId != null) {
                return userId;
            }
        }

        throw new MissingServletRequestPartException(TokenConstant.TOKEN_PARAM_NAME);
    }
}
