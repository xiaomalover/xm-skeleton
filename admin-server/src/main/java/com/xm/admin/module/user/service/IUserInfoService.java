package com.xm.admin.module.user.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.module.user.entity.UserInfo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2020-03-02
 */
public interface IUserInfoService extends IService<UserInfo> {

    /**
     * 获取用户列表
     *
     * @param page        分页
     * @param userInfo 搜索参数
     * @param extraVo     额外参数
     * @return 用户列表
     */
    IPage<UserInfo> getUserList(IPage page, UserInfo userInfo, ExtraVo extraVo);

    /**
     * 添加用户
     * @param userInfo 用户信息
     * @return Result
     */
    Result<Object> addUser(UserInfo userInfo);
}
