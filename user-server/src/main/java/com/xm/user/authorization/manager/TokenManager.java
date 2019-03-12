package com.xm.user.authorization.manager;

import com.xm.common.vo.Token;

/**
 * 对Token进行操作的接口
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface TokenManager {

    /**
     * 创建一个token关联上指定用户
     * @param userId 指定用户的id
     * @return 生成的token
     */
    Token createToken(String userId);

    /**
     * 刷新token
     * @param token token
     */
    void refreshToken(String token);

    /**
     * 通过token拿userId
     * @param token token
     * @return 用户id
     */
    String getUserIdByToken(String token);
}
