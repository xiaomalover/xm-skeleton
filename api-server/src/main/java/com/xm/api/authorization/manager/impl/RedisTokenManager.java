package com.xm.api.authorization.manager.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.crypto.SecureUtil;
import com.alibaba.fastjson.JSONObject;
import com.xm.api.authorization.manager.TokenManager;
import com.xm.common.constant.TokenConstant;
import com.xm.common.vo.Token;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * 通过Redis存储和验证token的实现类
 * @see com.xm.api.authorization.manager.TokenManager
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
@Component
public class RedisTokenManager implements TokenManager {

    @Autowired
    RedisTemplate<String, String> redisTemplate;

    /**
     * 创建TOKEN
     * @param userId 指定用户的id
     * @return TokenModel
     */
    @Override
    public Token createToken(String userId) {

        //存TOKEN
        String token = SecureUtil.md5(UUID.randomUUID().toString());
        Token tokenModel = new Token(userId, token, TokenConstant.TOKEN_EXPIRED);
        String tokenKey = this.getTokenKey(token);
        redisTemplate.opsForValue().set(tokenKey, JSONObject.toJSONString(tokenModel));
        redisTemplate.expire(tokenKey,  TokenConstant.TOKEN_EXPIRED, TimeUnit.SECONDS);

        //存TOKEN记录
        this.handHash(userId, token);

        return tokenModel;
    }

    /**
     * 刷新TOKEN
     * @param token token
     */
    @Override
    public void refreshToken(String token) {
        String tokenKey = this.getTokenKey(token);
        String redisToken = redisTemplate.opsForValue().get(tokenKey);
        if (!ObjectUtils.isEmpty(redisToken)) {
            Token tokenModel = JSONObject.parseObject(redisToken, Token.class);
            tokenModel.setTtl(TokenConstant.TOKEN_EXPIRED);
            redisTemplate.opsForValue().set(tokenKey, JSONObject.toJSONString(tokenModel));
            redisTemplate.expire(tokenKey,  TokenConstant.TOKEN_EXPIRED, TimeUnit.SECONDS);
        }
    }

    /**
     * 通过token拿userId
     * @param token token
     * @return 用户id
     */
    @Override
    public String getUserIdByToken(String token) {
        String tokenKey = this.getTokenKey(token);
        String redisToken = redisTemplate.opsForValue().get(tokenKey);
        if (!ObjectUtils.isEmpty(redisToken)) {
            Token tokenModel = JSONObject.parseObject(redisToken, Token.class);
            return tokenModel.getUserId();
        }
        return null;
    }

    /**
     * 获取Token的存储键
     * @param token Token
     * @return String
     */
    private String getTokenKey(String token) {
        return TokenConstant.TOKEN_KEY_PREFIX + token;
    }

    /**
     * 处理TOKEN与用户ID的映射，以便在二次登录时清楚除旧的token
     * @param userId 用户id
     * @param token Token
     */
    private void handHash(String userId, String token) {
        String userIdString = userId.toString();
        String hashKey = TokenConstant.TOKEN_HASH_KEY_PREFIX + SecureUtil.md5(userIdString).substring(0, 2);

        Object exist = redisTemplate.opsForHash().get(hashKey, userIdString);

        if (ObjectUtil.isNotNull(exist)) {
            redisTemplate.delete(getTokenKey(exist.toString()));
        }

        redisTemplate.opsForHash().put(hashKey, userIdString, token);
    }

}
