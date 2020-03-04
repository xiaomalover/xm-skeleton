package com.xm.admin.module.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.common.handler.PermissionEditor;
import com.xm.admin.module.sys.entity.AdminRole;
import com.xm.admin.module.sys.entity.Permission;
import com.xm.admin.module.sys.entity.Role;
import com.xm.admin.module.sys.entity.RolePermission;
import com.xm.admin.module.sys.service.IPermissionService;
import com.xm.admin.module.sys.service.IRolePermissionService;
import com.xm.admin.module.sys.service.IRoleService;
import com.xm.admin.module.sys.service.IUserRoleService;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-07
 */
@SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
@RestController
@RequestMapping("/skeleton/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IUserRoleService userRoleService;

    @Autowired
    private IRolePermissionService rolePermissionService;

    @Autowired
    private IPermissionService iPermissionService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @GetMapping("/getAllList")
    public Result<Object> roleGetAll() {

        List<Role> list = roleService.list();
        return new ResultUtil<>().setData(list);
    }

    @GetMapping("/getAllByPage")
    public Result<IPage<Role>> getRoleByPage(@ModelAttribute ExtraVo extraVo) {

        IPage<Role> page = new CommonPageUtil<Role>().initIPage(extraVo);
        QueryWrapper<Role> roleQueryWrapper = new QueryWrapper<>();
        roleQueryWrapper.orderByDesc("created_at");
        IPage<Role> roles = roleService.page(page, roleQueryWrapper);
        for (Role role : roles.getRecords()) {
            List<Permission> permissions = iPermissionService.findByRoleId(role.getId());
            role.setPermissions(permissions);
        }
        return new ResultUtil<IPage<Role>>().setData(roles);
    }

    @PostMapping("/setDefault")
    public Result<Object> setDefault(@RequestParam String id, @RequestParam Boolean isDefault) {

        Role role = roleService.getById(id);
        if (role == null) {
            return new ResultUtil<>().setErrorMsg("角色不存在");
        }
        role.setDefaultRole(isDefault);
        roleService.updateById(role);
        return new ResultUtil<>().setSuccessMsg("设置成功");
    }

    @PostMapping("/editRolePerm/{roleId}")
    public Result<Object> editRolePerm(@PathVariable String roleId, @RequestParam(required = false) String[] permIds) {

        //删除其关联权限
        rolePermissionService.remove(new QueryWrapper<RolePermission>().eq("role_id", roleId));
        //分配新权限
        for (String permId : permIds) {
            RolePermission rolePermission = new RolePermission();
            rolePermission.setRoleId(roleId);
            rolePermission.setPermissionId(permId);
            rolePermissionService.save(rolePermission);
        }
        //手动批量删除缓存
        Set<String> keysUser = redisTemplate.keys("admin:" + "*");
        if (!ObjectUtils.isEmpty(keysUser)) {
            redisTemplate.delete(keysUser);
        }
        Set<String> keysUserRole = redisTemplate.keys("adminRole:" + "*");
        if (!ObjectUtils.isEmpty(keysUserRole)) {
            redisTemplate.delete(keysUserRole);
        }
        Set<String> keysUserPerm = redisTemplate.keys("adminPermission:" + "*");
        if (!ObjectUtils.isEmpty(keysUserPerm)) {
            redisTemplate.delete(keysUserPerm);
        }
        Set<String> keysUserMenu = redisTemplate.keys("permission::adminMenuList:*");
        if (!ObjectUtils.isEmpty(keysUserMenu)) {
            redisTemplate.delete(keysUserMenu);
        }
        return new ResultUtil<>().setData(null);
    }

    @PostMapping("/save")
    public Result<Role> save(@ModelAttribute Role role) {
        roleService.save(role);
        return new ResultUtil<Role>().setData(role);
    }

    @PostMapping("/edit")
    public Result<Role> edit(@ModelAttribute Role entity) {
        roleService.updateById(entity);
        //手动批量删除缓存
        Set<String> keysUser = redisTemplate.keys("admin:" + "*");
        if (!ObjectUtils.isEmpty(keysUser)) {
            redisTemplate.delete(keysUser);
        }
        Set<String> keysUserRole = redisTemplate.keys("adminRole:" + "*");
        if (!ObjectUtils.isEmpty(keysUserRole)) {
            redisTemplate.delete(keysUserRole);
        }
        return new ResultUtil<Role>().setData(entity);
    }

    @DeleteMapping("/delAllByIds/{ids}")
    public Result<Object> delByIds(@PathVariable String[] ids) {

        for (String id : ids) {
            List<AdminRole> list = userRoleService.list(new QueryWrapper<AdminRole>().eq("role_id", id));
            if (list != null && list.size() > 0) {
                return new ResultUtil<>().setErrorMsg("删除失败，包含正被用户使用关联的角色");
            }
        }
        for (String id : ids) {
            roleService.removeById(id);
            //删除关联权限
            rolePermissionService.remove(new QueryWrapper<RolePermission>().eq("role_id", id));
        }
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }

    /**
     * 初始化绑定<br/>
     *
     * @param request http请求实例
     * @param binder  绑定实例
     * @throws Exception 异常
     */
    @InitBinder
    public void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
        binder.registerCustomEditor(Permission.class, new PermissionEditor());
    }
}
