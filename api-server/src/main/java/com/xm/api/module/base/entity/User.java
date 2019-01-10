package com.xm.api.module.base.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 用户数据库模型
 */
@Data
public class User implements Serializable{

    private static final long serialVersionUID = 1859492908833095035L;

    private Integer id;

    private String username;

    private String password;

    private String mobile;

    private String email;

    private Integer status;

    private Integer createdAt;

    private Integer updatedAt;
}
