package com.xm.api.module.base.serviceimpl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.crypto.SecureUtil;
import com.xm.api.dto.UserLoginRequest;
import com.xm.api.dto.UserRegisterRequest;
import com.xm.api.module.base.entity.User;
import com.xm.api.module.base.mapper.UserMapper;
import com.xm.api.module.base.service.UserService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import javax.validation.Validation;
import javax.validation.Validator;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Service(value = "userService")
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;

    /**
     * 验证器
     */
    private static Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    @SuppressWarnings("SpringJavaInjectionPointsAutowiringInspection")
    @Autowired
    public UserServiceImpl(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    /**
     * 用户注册
     *
     * @param userRegisterRequest 用户实体
     * @return Object
     */
    @Override
    public Result<Object> register(UserRegisterRequest userRegisterRequest) {

        //根据业务，验证数据合法性
        User exist;
        exist = userMapper.selectByUsername(userRegisterRequest.getUsername());
        if (ObjectUtil.isNotNull(exist)) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), "用户名已被注册");
        }
        exist = userMapper.selectByMobile(userRegisterRequest.getMobile());
        if (ObjectUtil.isNotNull(exist)) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), "手机号已被注册");
        }


        User user = new User();
        user.setMobile(userRegisterRequest.getMobile());
        user.setEmail(userRegisterRequest.getEmail());
        user.setUsername(userRegisterRequest.getUsername());
        //密码加密
        user.setPassword(this.encodePassword(userRegisterRequest.getPassword()));
        //写入创建时间 TODO 自动处理
        String timestamp = String.valueOf(System.currentTimeMillis());
        int length = timestamp.length();
        int now = Integer.valueOf(timestamp.substring(0,length-3));
        user.setCreatedAt(now);


        if (userMapper.insert(user) > 0) {
            return new ResultUtil<>().setData(null);
        } else {
            return new ResultUtil<>().setErrorMsg("注册失败");
        }
    }

    @Override
    public Result<Object> login(UserLoginRequest userLoginRequest) {

        //查询用户存不存在
        User user = userMapper.selectByUsernameOrMobile(userLoginRequest.getAccount());
        if (ObjectUtil.isNull(user)) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), "用户名不正确");
        }

        //校验密码
        if (!this.encodePassword(userLoginRequest.getPassword()).equals(user.getPassword())) {
            return new ResultUtil<>().setErrorMsg(HttpStatus.INTERNAL_SERVER_ERROR.value(), "密码错误");
        }

        //转domain到dto
        User userModel = new User();
        userModel.setId(user.getId());
        userModel.setMobile(user.getMobile());
        userModel.setEmail(user.getEmail());
        userModel.setUsername(user.getUsername());
        userModel.setCreatedAt(user.getCreatedAt());
        userModel.setUpdatedAt(user.getUpdatedAt());
        userModel.setStatus(user.getStatus());

        return new ResultUtil<>().setData(userModel);
    }

    /**
     * 获取用户信息
     * @param userId 用户id
     * @return 用户数据
     */
    @Override
    public User getUser(int userId) {
        User user = userMapper.selectByPrimaryKey(userId);
        User userModel = new User();
        userModel.setId(user.getId());
        userModel.setMobile(user.getMobile());
        userModel.setEmail(user.getEmail());
        userModel.setUsername(user.getUsername());
        userModel.setStatus(user.getStatus());
        userModel.setCreatedAt(user.getCreatedAt());
        userModel.setUpdatedAt(user.getUpdatedAt());
        return userModel;
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
