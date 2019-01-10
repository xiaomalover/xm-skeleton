package com.xm.api.module.base.mapper;

import com.xm.api.module.base.entity.User;
import java.util.List;

/**
 * 用户Mapper
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public interface UserMapper {

    /**
     * 插入用户
     * @param record 用户
     * @return 条数
     */
    int insert(User record);

    /**
     * 通过用户ID查找
     * @param id 用户id
     * @return 用户实体
     */
    User selectByPrimaryKey(Integer id);

    /**
     * 查询所有用户
     * @return 用户实体列表
     */
    List<User> queryAll();

    /**
     * 通过用户ID查找
     * @param username 用户名
     * @return 用户实体
     */
    User selectByUsername(String username);

    /**
     * 通过用户ID查找
     * @param mobile 用户手机号
     * @return 用户实体
     */
    User selectByMobile(String mobile);

    /**
     * 通过用户ID查找
     * @param account 用户手机号或用户名
     * @return 用户实体
     */
    User selectByUsernameOrMobile(String account);
}