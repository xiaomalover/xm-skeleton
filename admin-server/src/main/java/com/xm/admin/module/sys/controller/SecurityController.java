package com.xm.admin.module.sys.controller;

import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@RestController
@RequestMapping("/skeleton/common")
public class SecurityController {

    @GetMapping("/needLogin")
    public Result<Object> needLogin() {
        return new ResultUtil<>().setErrorMsg(401, "您还未登录");
    }
}
