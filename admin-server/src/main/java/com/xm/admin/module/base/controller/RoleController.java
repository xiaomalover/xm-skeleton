package com.xm.admin.module.base.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.xm.admin.common.vo.PageVo;
import com.xm.admin.module.base.entity.Role;
import com.xm.admin.module.base.entity.co.Permission;
import com.xm.admin.module.base.entity.co.RolePermission;
import com.xm.admin.module.base.entity.co.UserRole;
import com.xm.admin.module.base.service.IPermissionService;
import com.xm.admin.module.base.service.IRoleService;
import com.xm.admin.module.base.service.RolePermissionService;
import com.xm.admin.module.base.service.UserRoleService;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Set;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-07
 */
@RestController
@RequestMapping("/skeleton/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private RolePermissionService rolePermissionService;

    @Autowired
    private IPermissionService iPermissionService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/getAllList",method = RequestMethod.GET)
    @ApiOperation(value = "获取全部角色")
    public Result<Object> roleGetAll(){

        List<Role> list = roleService.list();
        return new ResultUtil<>().setData(list);
    }

    @RequestMapping(value = "/getAllByPage",method = RequestMethod.GET)
    @ApiOperation(value = "分页获取角色")
    public Result<IPage<Role>> getRoleByPage(@ModelAttribute PageVo pageVo){

        IPage<Role> page = new CommonPageUtil<Role>().initIPage(pageVo.getPageNumber(), pageVo.getPageSize());
        QueryWrapper<Role> roleQueryWrapper = new QueryWrapper<>();
        roleQueryWrapper.orderByDesc( "created_at");
        IPage<Role> roles = roleService.page(page, roleQueryWrapper);
        for(Role role : roles.getRecords()){
            List<Permission> permissions = iPermissionService.findByRoleId(role.getId());
            role.setPermissions(permissions);
        }
        return new ResultUtil<IPage<Role>>().setData(roles);
    }

    @RequestMapping(value = "/setDefault",method = RequestMethod.POST)
    @ApiOperation(value = "设置或取消默认角色")
    public Result<Object> setDefault(@RequestParam String id,
                                     @RequestParam Boolean isDefault){

        Role role = roleService.getById(id);
        if(role==null){
            return new ResultUtil<>().setErrorMsg("角色不存在");
        }
        role.setDefaultRole(isDefault);
        roleService.updateById(role);
        return new ResultUtil<>().setSuccessMsg("设置成功");
    }

    @RequestMapping(value = "/editRolePerm/{roleId}",method = RequestMethod.POST)
    @ApiOperation(value = "编辑角色分配权限")
    public Result<Object> editRolePerm(@PathVariable String roleId,
                                       @RequestParam(required = false) String[] permIds){

        //删除其关联权限
        rolePermissionService.deleteByRoleId(roleId);
        //分配新权限
        for(String permId : permIds){
            RolePermission rolePermission = new RolePermission();
            rolePermission.setRoleId(roleId);
            rolePermission.setPermissionId(permId);
            rolePermissionService.save(rolePermission);
        }
        //手动批量删除缓存
        Set<String> keysUser = redisTemplate.keys("user:" + "*");
        redisTemplate.delete(keysUser);
        Set<String> keysUserRole = redisTemplate.keys("adminRole:" + "*");
        redisTemplate.delete(keysUserRole);
        Set<String> keysUserPerm = redisTemplate.keys("adminPermission:" + "*");
        redisTemplate.delete(keysUserPerm);
        Set<String> keysUserMenu = redisTemplate.keys("permission::adminMenuList:*");
        redisTemplate.delete(keysUserMenu);
        return new ResultUtil<Object>().setData(null);
    }

    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ApiOperation(value = "保存数据")
    public Result<Role> save(@ModelAttribute Role role){
        roleService.save(role);
        return new ResultUtil<Role>().setData(role);
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ApiOperation(value = "更新数据")
    public Result<Role> edit(@ModelAttribute Role entity){
        roleService.updateById(entity);
        //手动批量删除缓存
        Set<String> keysUser = redisTemplate.keys("user:" + "*");
        redisTemplate.delete(keysUser);
        Set<String> keysUserRole = redisTemplate.keys("adminRole:" + "*");
        redisTemplate.delete(keysUserRole);
        return new ResultUtil<Role>().setData(entity);
    }

    @RequestMapping(value = "/delAllByIds/{ids}",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量通过ids删除")
    public Result<Object> delByIds(@PathVariable String[] ids){

        for(String id:ids){
            List<UserRole> list = userRoleService.findByRoleId(id);
            if(list!=null&&list.size()>0){
                return new ResultUtil<>().setErrorMsg("删除失败，包含正被用户使用关联的角色");
            }
        }
        for(String id:ids){
            roleService.removeById(id);
            //删除关联权限
            rolePermissionService.deleteByRoleId(id);
        }
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }
}
