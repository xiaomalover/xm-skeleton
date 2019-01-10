package com.xm.api.exception;

import com.xm.common.utils.ResultUtil;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 异常捕获处理
 */
@ControllerAdvice
public class RestExceptionHandler {

    /**
     * 自定义异常
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Object requestNotReadable(Exception e) {
        return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
    }
}