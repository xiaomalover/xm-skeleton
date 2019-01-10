package com.xm.api.dto;

import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class UserRegisterRequest implements Serializable {

    @NotEmpty(message = "用户名不能为空")
    @Length(min = 4, message = "用户名长度不能少于4位")
    private String username;

    @NotEmpty(message = "密码不能为空")
    @Length(min = 4, max = 20, message = "密码长度必须为4到20位")
    private String password;

    @NotEmpty(message = "手机号不能为空")
    @Pattern(regexp="^1[3456789]\\d{9}$",message="手机号格式不正确")
    private String mobile;

    private String email;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
