package com.xm.admin.module.user.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.common.annotation.SystemLog;
import com.xm.admin.module.user.entity.UserInfo;
import com.xm.admin.module.user.mapper.UserInfoMapper;
import com.xm.admin.module.user.service.IUserInfoService;
import com.xm.common.enums.CommonStatus;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2020-03-02
 */
@RestController
@RequestMapping("/skeleton/userInfo")
public class UserInfoController {

    @Autowired
    private IUserInfoService userInfoService;

    @Autowired
    private UserInfoMapper userInfoMapper;

    @GetMapping("/getByCondition")
    public Result getByCondition(
            @ModelAttribute UserInfo userInfo,
            @ModelAttribute ExtraVo extraVo
    ) {
        IPage<UserInfo> page = new CommonPageUtil<UserInfo>().initIPage(extraVo);
        IPage<UserInfo> userInfoList = userInfoService.getUserList(page, userInfo, extraVo);
        return new ResultUtil<IPage<UserInfo>>().setData(userInfoList);
    }

    @PostMapping("/disable/{id}")
    public Result<Object> disable(@PathVariable String id) {
        UserInfo userInfo = userInfoService.getById(id);
        userInfo.setStatus(CommonStatus.STATUS_DISABLED.getStatus());
        if (userInfoService.updateById(userInfo)) {
            return new ResultUtil<>().setSuccessMsg("禁用用户成功");
        } else {
            return new ResultUtil<>().setErrorMsg("禁用用户失败");
        }
    }

    @PostMapping("/enable/{id}")
    public Result<Object> enable(@PathVariable String id) {
        UserInfo userInfo = userInfoService.getById(id);
        userInfo.setStatus(CommonStatus.STATUS_ENABLED.getStatus());
        if (userInfoService.updateById(userInfo)) {
            return new ResultUtil<>().setSuccessMsg("启用用户成功");
        } else {
            return new ResultUtil<>().setErrorMsg("启用用户失败");
        }
    }

    @DeleteMapping("/delByIds/{ids}")
    public Result<Object> delAllByIds(@PathVariable String[] ids) {
        for (String id : ids) {
            UserInfo userInfo = userInfoService.getById(id);
            userInfo.setStatus(CommonStatus.STATUS_DELETED.getStatus());
            userInfoService.updateById(userInfo);
        }
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }

    @PostMapping("/add")
    public Result add(@ModelAttribute UserInfo userInfo) {
        return userInfoService.addUser(userInfo);
    }

    @PostMapping("/edit")
    public Result edit(@ModelAttribute UserInfo userInfo) {

        QueryWrapper<UserInfo> userInfoQueryWrapper = new QueryWrapper<>();
        userInfoQueryWrapper.ne("id", userInfo.getId());
        userInfoQueryWrapper.and(wrapper -> wrapper.eq("username", userInfo.getUsername()).or().eq("mobile", userInfo.getMobile()));
        Integer exist = userInfoMapper.selectCount(userInfoQueryWrapper);

        if (exist > 0) {
            return new ResultUtil<>().setErrorMsg("用户名或手机号已存在");
        }

        if (userInfoService.updateById(userInfo)) {
            return new ResultUtil<>().setSuccessMsg("编辑用户成功");
        } else {
            return new ResultUtil<>().setErrorMsg("编辑用户失败");
        }
    }

    @PostMapping("/updatePassword")
    @SystemLog(description = "修改用户密码")
    public Result<Object> updatePassword(@RequestParam String id, @RequestParam String password) {
        return userInfoService.updatePassword(id, password);
    }
}
