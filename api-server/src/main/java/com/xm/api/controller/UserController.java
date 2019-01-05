package com.xm.api.controller;

import com.xm.common.utils.ResultUtil;
import org.springframework.web.bind.annotation.*;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 用户控制器
 */
@SuppressWarnings("SpringAutowiredFieldsWarningInspection")
@RestController
@RequestMapping(value = "user")
public class UserController{

    @PostMapping("/register")
    public Object register() {
        return new ResultUtil<>().setData(true, "注册成功");
    }

    @PostMapping("/login")
    public Object login() {
        return new ResultUtil<>().setData(true, "登录成功");
    }

    @GetMapping(value = "/info", produces = {"application/json;charset=UTF-8"})
    public Object userInfo() {
        return new ResultUtil<>().setData(true, "获取成功");
    }
}
