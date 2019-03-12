package com.xm.user.dto;

import lombok.Data;
import javax.validation.constraints.NotEmpty;
import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class UserLoginRequest implements Serializable {

    private static final long serialVersionUID = -7162915777919572929L;

    @NotEmpty(message = "帐号不能为空")
    private String account;

    @NotEmpty(message = "密码不能为空")
    private String password;
}
