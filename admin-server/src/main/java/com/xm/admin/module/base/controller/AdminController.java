package com.xm.admin.module.base.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.admin.common.handler.PermissionEditor;
import com.xm.admin.common.handler.RolesEditor;
import com.xm.admin.common.vo.PageVo;
import com.xm.admin.common.vo.SearchVo;
import com.xm.admin.module.base.entity.*;
import com.xm.admin.module.base.service.*;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-06
 */
@Slf4j
@RestController
@RequestMapping("/skeleton/user")
@CacheConfig(cacheNames = "admin")
@Transactional
public class AdminController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IDepartmentService departmentService;

    @Autowired
    private IUserRoleService iUserRoleService;

    @Autowired
    private IUserRoleService userRoleService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/regist", method = RequestMethod.POST)
    public Result<Object> regist(@ModelAttribute Admin u,
                                 @RequestParam String verify,
                                 @RequestParam String captchaId) {

        if (StrUtil.isBlank(verify) || StrUtil.isBlank(u.getUsername())
                || StrUtil.isBlank(u.getPassword())) {
            return new ResultUtil<>().setErrorMsg("缺少必需表单字段");
        }

        //验证码
        String code = redisTemplate.opsForValue().get(captchaId);
        if (StrUtil.isBlank(code)) {
            return new ResultUtil<>().setErrorMsg("验证码已过期，请重新获取");
        }

        if (!verify.toLowerCase().equals(code.toLowerCase())) {
            log.error("注册失败，验证码错误：code:" + verify + ",redisCode:" + code.toLowerCase());
            return new ResultUtil<>().setErrorMsg("验证码输入错误");
        }

        if (!ObjectUtils.isEmpty(adminService.findUserDetailInfo(u.getUsername()))) {
            return new ResultUtil<>().setErrorMsg("该用户名已被注册");
        }
        //删除缓存
        redisTemplate.delete("admin::" + u.getUsername());

        String encryptPass = new BCryptPasswordEncoder().encode(u.getPassword());
        u.setPassword(encryptPass);
        u.setType(CommonConstant.USER_TYPE_NORMAL);
        Boolean suc = adminService.save(u);
        if (!suc) {
            return new ResultUtil<>().setErrorMsg("注册失败");
        }
        // 默认角色
        List<Role> roleList = roleService.list(new QueryWrapper<Role>().eq("default_role", true));
        if (!ObjectUtils.isEmpty(roleList)) {
            for (Role role : roleList) {
                AdminRole ur = new AdminRole();
                ur.setUserId(u.getId());
                ur.setRoleId(role.getId());
                iUserRoleService.save(ur);
            }
        }

        return new ResultUtil<>().setData(u);
    }

    @RequestMapping(value = "/info", method = RequestMethod.GET)
    public Result<Admin> getUserInfo() {

        UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Admin u = adminService.findUserDetailInfo(user.getUsername());
        // 清除持久上下文环境 避免后面语句导致持久化
        u.setPassword(null);
        return new ResultUtil<Admin>().setData(u);
    }

    @RequestMapping(value = "/unlock", method = RequestMethod.POST)
    public Result<Object> unLock(@RequestParam String password) {

        UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Admin u = adminService.findUserDetailInfo(user.getUsername());
        if (!new BCryptPasswordEncoder().matches(password, u.getPassword())) {
            return new ResultUtil<>().setErrorMsg("密码不正确");
        }
        return new ResultUtil<>().setData(null);
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @CacheEvict(key = "#u.username")
    public Result<Object> editOwn(@ModelAttribute Admin u) {

        Admin old = adminService.getById(u.getId());
        u.setUsername(old.getUsername());
        u.setPassword(old.getPassword());
        boolean suc = adminService.updateById(u);
        if (!suc) {
            return new ResultUtil<>().setErrorMsg("修改失败");
        }
        return new ResultUtil<>().setSuccessMsg("修改成功");
    }

    /**
     * @param u
     * @param roles
     * @return
     */
    @RequestMapping(value = "/admin/edit", method = RequestMethod.POST)
    @CacheEvict(key = "#u.username")
    public Result<Object> edit(@ModelAttribute Admin u,
                               @RequestParam(required = false) String[] roles) {

        Admin old = adminService.getById(u.getId());
        //所修改了用户名
        if (!old.getUsername().equals(u.getUsername())) {
            //若修改用户名删除原用户名缓存
            redisTemplate.delete("admin::" + old.getUsername());
            //判断新用户名是否存在
            if (!ObjectUtils.isEmpty(adminService.findUserDetailInfo(u.getUsername()))) {
                return new ResultUtil<>().setErrorMsg("该用户名已被存在");
            }
            //删除缓存
            redisTemplate.delete("admin::" + u.getUsername());
        }

        u.setPassword(old.getPassword());
        boolean sec = adminService.updateById(u);
        if (!sec) {
            return new ResultUtil<>().setErrorMsg("修改失败");
        }
        //删除该用户角色

        userRoleService.remove(new QueryWrapper<AdminRole>().eq("user_id", u.getId()));
        if (roles != null && roles.length > 0) {
            //新角色
            for (String roleId : roles) {
                AdminRole ur = new AdminRole();
                ur.setRoleId(roleId);
                ur.setUserId(u.getId());
                userRoleService.save(ur);
            }
        }
        //手动删除缓存
        redisTemplate.delete("adminRole::" + u.getId());
        return new ResultUtil<>().setSuccessMsg("修改成功");
    }

    /**
     * 线上demo仅允许ADMIN权限改密码
     *
     * @param id
     * @param password
     * @param newPass
     * @return
     */
    @RequestMapping(value = "/modifyPass", method = RequestMethod.POST)
    public Result<Object> modifyPass(@RequestParam String id, @RequestParam String password, @RequestParam String newPass) {

        Admin old = adminService.getById(id);

        if (!new BCryptPasswordEncoder().matches(password, old.getPassword())) {
            return new ResultUtil<>().setErrorMsg("旧密码不正确");
        }

        String newEncryptPass = new BCryptPasswordEncoder().encode(newPass);
        old.setPassword(newEncryptPass);
        boolean sec = adminService.updateById(old);
        if (!sec) {
            return new ResultUtil<>().setErrorMsg("修改失败");
        }

        //手动更新缓存
        redisTemplate.delete("admin::" + old.getUsername());

        return new ResultUtil<>().setData(old);
    }

    @RequestMapping(value = "/getByCondition", method = RequestMethod.GET)
    public Result<IPage<Admin>> getByCondition(@ModelAttribute Admin user,
                                               @ModelAttribute SearchVo searchVo,
                                               @ModelAttribute PageVo pageVo) {

        IPage<Admin> page = new CommonPageUtil<Admin>().initIPage(pageVo.getPageNumber(), pageVo.getPageSize());

        QueryWrapper<Admin> adminQueryWrapper = new QueryWrapper<>();

        //模糊搜素
        if (StrUtil.isNotBlank(user.getUsername())) {
            adminQueryWrapper.like("username", user.getUsername());
        }
        if (StrUtil.isNotBlank(user.getMobile())) {
            adminQueryWrapper.like("mobile", user.getMobile());
        }
        if (StrUtil.isNotBlank(user.getEmail())) {
            adminQueryWrapper.like("email", user.getEmail());
        }

        //部门
        if (StrUtil.isNotBlank(user.getDepartmentId())) {
            adminQueryWrapper.eq("department_id", user.getDepartmentId());
        }

        //性别
        if (user.getSex() != null) {
            adminQueryWrapper.eq("sex", user.getSex());
        }
        //类型
        if (user.getType() != null) {
            adminQueryWrapper.eq("type", user.getType());
        }
        //状态
        if (user.getStatus() != null) {
            adminQueryWrapper.eq("status", user.getStatus());
        }

        if (!StringUtils.isEmpty(searchVo.getStartDate())) {
            adminQueryWrapper.gt("created_at", searchVo.getStartDate());
        }
        if (!StringUtils.isEmpty(searchVo.getEndDate())) {
            adminQueryWrapper.lt("created_at", searchVo.getEndDate());
        }

        boolean isAsc = "asc".equals(pageVo.getOrder());
        if (!StringUtils.isEmpty(pageVo.getSort())) {
            adminQueryWrapper.orderBy(true, isAsc, StringUtils.camelToUnderline(pageVo.getSort()));
        } else {
            adminQueryWrapper.orderByDesc("created_at");
        }

        IPage<Admin> admins = adminService.page(page, adminQueryWrapper);

        List<Admin> newAdmins = new ArrayList<>();
        for (Admin u : admins.getRecords()) {
            // 关联部门
            if (StrUtil.isNotBlank(u.getDepartmentId())) {
                Department department = departmentService.getById(u.getDepartmentId());
                u.setDepartmentTitle(department.getTitle());
            }
            // 关联角色
            List<Role> list = iUserRoleService.findByUserId(u.getId());
            u.setRoles(list);
            // 清除持久上下文环境 避免后面语句导致持久化
            u.setPassword(null);
            newAdmins.add(u);
        }
        page.setRecords(newAdmins);
        return new ResultUtil<IPage<Admin>>().setData(page);
    }

    @RequestMapping(value = "/admin/add", method = RequestMethod.POST)
    public Result<Object> add(@ModelAttribute Admin u,
                                 @RequestParam(required = false) String[] roles) {

        if (StrUtil.isBlank(u.getUsername()) || StrUtil.isBlank(u.getPassword())) {
            return new ResultUtil<>().setErrorMsg("缺少必需表单字段");
        }

        if (!ObjectUtils.isEmpty(adminService.findUserDetailInfo(u.getUsername()))) {
            return new ResultUtil<>().setErrorMsg("该用户名已被注册");
        }
        //删除缓存
        redisTemplate.delete("admin::" + u.getUsername());

        String encryptPass = new BCryptPasswordEncoder().encode(u.getPassword());
        u.setPassword(encryptPass);
        boolean sec = adminService.save(u);
        if (!sec) {
            return new ResultUtil<>().setErrorMsg("添加失败");
        }
        if (!ObjectUtils.isEmpty(roles)) {
            //添加角色
            for (String roleId : roles) {
                AdminRole ur = new AdminRole();
                ur.setUserId(u.getId());
                ur.setRoleId(roleId);
                userRoleService.save(ur);
            }
        }

        return new ResultUtil<>().setData(u);
    }

    @RequestMapping(value = "/admin/disable/{userId}", method = RequestMethod.POST)
    public Result<Object> disable(@PathVariable String userId) {

        Admin user = adminService.getById(userId);
        if (user == null) {
            return new ResultUtil<>().setErrorMsg("通过userId获取用户失败");
        }
        user.setStatus(CommonConstant.USER_STATUS_LOCK);
        adminService.updateById(user);
        //手动更新缓存
        redisTemplate.delete("admin::" + user.getUsername());
        return new ResultUtil<>().setData(null);
    }

    @RequestMapping(value = "/admin/enable/{userId}", method = RequestMethod.POST)
    public Result<Object> enable(@PathVariable String userId) {

        Admin user = adminService.getById(userId);
        if (user == null) {
            return new ResultUtil<>().setErrorMsg("通过userId获取用户失败");
        }
        user.setStatus(CommonConstant.USER_STATUS_NORMAL);
        adminService.updateById(user);
        //手动更新缓存
        redisTemplate.delete("admin::" + user.getUsername());
        return new ResultUtil<>().setData(null);
    }

    @RequestMapping(value = "/delByIds/{ids}", method = RequestMethod.DELETE)
    public Result<Object> delAllByIds(@PathVariable String[] ids) {

        for (String id : ids) {
            adminService.removeById(id);
            //删除关联角色
            userRoleService.remove((new QueryWrapper<AdminRole>().eq("user_id", id)));
        }
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }

    /**
     * 初始化绑定<br/>
     * @param request http请求实例
     * @param binder 绑定实例
     * @throws Exception
     * */
    @InitBinder
    public void initBinder(HttpServletRequest request,ServletRequestDataBinder binder) throws Exception {
        binder.registerCustomEditor(Permission.class, new PermissionEditor());
        binder.registerCustomEditor(Role.class, new RolesEditor());
    }
}
