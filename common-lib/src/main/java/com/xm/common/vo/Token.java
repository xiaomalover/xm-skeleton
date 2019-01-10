package com.xm.common.vo;

import lombok.Data;

/**
 * Token的Model类，可以增加字段提高安全性，例如时间戳、url签名
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class Token {

    /**
     * 用户id
     */
    private int userId;

    /**
     * 随机生成的uuid
     */
    private String token;

    /**
     * 过期时间
     */
    private int ttl;

    public Token(int userId, String token, int ttl) {
        this.userId = userId;
        this.token = token;
        this.ttl = ttl;
    }
}
