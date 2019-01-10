package com.xm.api.dto;

import lombok.Data;
import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class UserRegisterRequest implements Serializable {

    private static final long serialVersionUID = -1962701668965744844L;

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
}
