package com.xm.api.module.base.controller;

import com.xm.api.authorization.annotation.CurrentUser;
import com.xm.api.authorization.manager.TokenManager;
import com.xm.api.dto.UserLoginRequest;
import com.xm.api.dto.UserRegisterRequest;
import com.xm.api.module.base.entity.User;
import com.xm.api.module.base.service.UserService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 用户控制器
 */
@SuppressWarnings("SpringAutowiredFieldsWarningInspection")
@RestController
@RequestMapping(value = "user")
public class UserController extends BaseController{

    @SuppressWarnings("SpringJavaAutowiringInspection")
    @Autowired
    private UserService userService;

    @Autowired
    private TokenManager tokenManager;

    @PostMapping("/register")
    public Object register(@Valid UserRegisterRequest userRegisterRequest, BindingResult result) {

        //验证数据合法性，虽然生产者服务里有验证，但这里也加一个，可以把不合法数据挡在消费者处，减轻生产者服务的压力
        String errMsg = super.getValidateErrorMsg(result);
        if (errMsg.length() > 0) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), errMsg);
        }

        return userService.register(userRegisterRequest);
    }

    @PostMapping("/login")
    public Object login(@Valid UserLoginRequest userLoginRequest, BindingResult result) {

        //验证数据合法性，虽然生产者服务里有验证，但这里也加一个，可以把不合法数据挡在消费者处，减轻生产者服务的压力
        String errMsg = super.getValidateErrorMsg(result);
        if (errMsg.length() > 0) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), errMsg);
        }

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
    public Object userInfo(@CurrentUser Integer userId) {
        User userModel = userService.getUser(userId);
        return new ResultUtil<>().setData(userModel);
    }
}
