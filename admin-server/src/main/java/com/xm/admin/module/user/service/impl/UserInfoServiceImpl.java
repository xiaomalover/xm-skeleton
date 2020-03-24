package com.xm.admin.module.user.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.module.user.entity.UserInfo;
import com.xm.admin.module.user.mapper.UserInfoMapper;
import com.xm.admin.module.user.service.IUserInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2020-03-02
 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements IUserInfoService {

    @Autowired
    UserInfoMapper userInfoMapper;

    @Override
    public IPage<UserInfo> getUserList(IPage page, UserInfo userInfo, ExtraVo extraVo) {
        return userInfoMapper.selectUserList(page, userInfo, extraVo);
    }

    @Override
    public Result<Object> addUser(UserInfo userInfo) {

        //根据业务，验证数据合法性
        UserInfo exist;
        exist = userInfoMapper.selectByUsername(userInfo.getUsername());
        if (ObjectUtil.isNotNull(exist)) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), "用户名已被注册");
        }
        exist = userInfoMapper.selectByMobile(userInfo.getMobile());
        if (ObjectUtil.isNotNull(exist)) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), "手机号已被注册");
        }


        UserInfo user = new UserInfo();
        user.setMobile(userInfo.getMobile());
        user.setEmail(userInfo.getEmail());
        user.setUsername(userInfo.getUsername());
        //密码加密
        user.setPassword(this.encodePassword(userInfo.getPassword()));
        if (save(user)) {
            return new ResultUtil<>().setData(null);
        } else {
            return new ResultUtil<>().setErrorMsg("添加失败");
        }
    }

    @Override
    public Result<Object> updatePassword(String id, String password) {
        UserInfo old = getById(id);

        String newEncryptPass = encodePassword(password);
        old.setPassword(newEncryptPass);
        boolean sec = updateById(old);
        if (!sec) {
            return new ResultUtil<>().setErrorMsg("修改失败");
        }

        return new ResultUtil<>().setData(old);
    }


    /**
     * 加密登录密码
     * @param password 登录密码名文
     * @return String
     */
    private String encodePassword(String password) {
        return SecureUtil.md5(SecureUtil.md5(password));
    }
}
