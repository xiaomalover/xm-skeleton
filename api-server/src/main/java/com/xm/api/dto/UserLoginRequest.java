package com.xm.api.dto;

import javax.validation.constraints.NotEmpty;
import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class UserLoginRequest implements Serializable {

    @NotEmpty(message = "帐号不能为空")
    private String account;

    @NotEmpty(message = "密码不能为空")
    private String password;

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
