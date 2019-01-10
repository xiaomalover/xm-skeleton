package com.xm.api.exception;

import com.xm.common.utils.ResultUtil;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 错误捕获
 */
@RestController
public class RestErrorFilter implements ErrorController {

    private static final String ERROR_PATH = "/error";

    @RequestMapping(value = ERROR_PATH)
    public Object handleError(HttpServletResponse response) {
        int code = response.getStatus();
        if (code == HttpStatus.NOT_FOUND.value()) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.NOT_FOUND);
        } else if (code == HttpStatus.METHOD_NOT_ALLOWED.value()) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.METHOD_NOT_ALLOWED);
        } else {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }

}
