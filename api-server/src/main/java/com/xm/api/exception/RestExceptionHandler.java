package com.xm.api.exception;

import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import java.util.List;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 异常捕获处理
 */
@RestControllerAdvice
public class RestExceptionHandler {

    /**
     * 参数异常处理
     *
     * @param e 参数校验异常
     * @return 结果
     */
    @ExceptionHandler(BindException.class)
    @ResponseStatus(HttpStatus.OK)
    public Result error(BindException e) {
        List<ObjectError> allErrors = e.getAllErrors(); // 拿到异常信息
        String errMessage = getErrMessage(allErrors);   // 拼接, 返回前端
        return new ResultUtil<>().setErrorMsg(errMessage);
    }

    /**
     * 自定义异常
     */
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Object requestNotReadable(Exception e) {
        return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
    }

    /**
     * 获取异常信息, 拼成String
     *
     * @param errors 错误消息集合
     * @return  错误消息字符串
     */
    private String getErrMessage(List<ObjectError> errors) {
        StringBuilder errorMsg = new StringBuilder();
        errors.forEach((err) -> {
            if (errorMsg.length() > 0) {
                errorMsg.append(";");
            }
            errorMsg.append(err.getDefaultMessage());
        });
        return errorMsg.toString();
    }
}
