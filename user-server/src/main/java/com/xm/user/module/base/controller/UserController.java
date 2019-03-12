package com.xm.user.module.base.controller;

import com.xm.user.authorization.annotation.CurrentUser;
import com.xm.user.authorization.manager.TokenManager;
import com.xm.user.dto.UserLoginRequest;
import com.xm.user.dto.UserRegisterRequest;
import com.xm.user.module.base.entity.User;
import com.xm.user.module.base.service.IUserService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 用户控制器
 */
@SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
@RestController
@RequestMapping(value = "user")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private TokenManager tokenManager;

    @PostMapping("/register")
    public Object register(@Valid UserRegisterRequest userRegisterRequest) {
        return userService.register(userRegisterRequest);
    }

    @PostMapping("/login")
    public Object login(@Valid UserLoginRequest userLoginRequest) {
        //走服务端登录服务
        Result loginResult = userService.login(userLoginRequest);
        if (loginResult.isSuccess()) {
            //服务端返回成功存入TOKEN
            User userModel = (User) loginResult.getResult();
            return new ResultUtil<>().setData(tokenManager.createToken(userModel.getId()));
        }
        return loginResult;
    }

    @GetMapping(value = "/info", produces = {"application/json;charset=UTF-8"})
    public Object userInfo(@CurrentUser String userId) {
        User userModel = userService.getUser(userId);
        return new ResultUtil<>().setData(userModel);
    }
}
