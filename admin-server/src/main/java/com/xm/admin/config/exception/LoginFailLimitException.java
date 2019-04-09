package com.xm.admin.config.exception;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.security.authentication.InternalAuthenticationServiceException;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class LoginFailLimitException extends InternalAuthenticationServiceException {

    private String msg;

    public LoginFailLimitException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public LoginFailLimitException(String msg, Throwable t) {
        super(msg, t);
        this.msg = msg;
    }
}
