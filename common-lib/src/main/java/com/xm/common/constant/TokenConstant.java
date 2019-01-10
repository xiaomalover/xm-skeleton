package com.xm.common.constant;

/**
 * Token相关常量
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class TokenConstant {
    /**
     * 过期时间常量
     */
    public final static int TOKKEN_EXPIRED = 15 * 3600;

    /**
     * Token前缀常量
     */
    public final static String TOKEN_KEY_PREFIX = "token_";

    /**
     * 用户id与token映射缓存常量
     */
    public final static String TOKEN_HASH_KEY_PREFIX = "token_hash_";

    /**
     * 校验参数名常量
     */
    public final static String TOKEN_PARAM_NAME = "token";
}
