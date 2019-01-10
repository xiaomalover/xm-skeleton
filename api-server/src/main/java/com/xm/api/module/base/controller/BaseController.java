package com.xm.api.module.base.controller;

import org.springframework.validation.BindingResult;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 控制器基类
 */
public class BaseController {

    @SuppressWarnings("WeakerAccess")
    public String getValidateErrorMsg(BindingResult result) {
        StringBuffer errorMsg = new StringBuffer();
        result.getAllErrors().forEach((err) -> {
            if (errorMsg.length() > 0) {
                errorMsg.append(";");
            }
            errorMsg.append(err.getDefaultMessage());
        });
        return errorMsg.toString();
    }
}
