package com.xm.user.module.base.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 用户数据库模型
 */
@Data
@TableName("user_info")
public class User extends BaseEntity {

    private static final long serialVersionUID = 1859492908833095035L;

    private String username;

    private String password;

    private String mobile;

    private String email;

    private Integer status;

}
