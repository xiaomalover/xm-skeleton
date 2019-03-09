package com.xm.admin.module.base.controller;

import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@RestController
@RequestMapping("/skeleton/common")
@Transactional
public class SecurityController {

    @RequestMapping(value = "/needLogin",method = RequestMethod.GET)
    public Result<Object> needLogin(){
        return new ResultUtil<>().setErrorMsg(401, "您还未登录");
    }
}
