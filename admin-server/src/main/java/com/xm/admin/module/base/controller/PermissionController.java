package com.xm.admin.module.base.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.admin.module.base.entity.RolePermission;
import com.xm.admin.module.base.service.IRolePermissionService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import com.xm.admin.config.security.permission.MySecurityMetadataSource;
import com.xm.admin.module.base.entity.Permission;
import com.xm.admin.module.base.service.IPermissionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@RestController
@Api(description = "菜单/权限管理接口")
@RequestMapping("/skeleton/permission")
@CacheConfig(cacheNames = "permission")
@Transactional
public class PermissionController {

    @Autowired
    private IRolePermissionService rolePermissionService;

    @Autowired
    private IPermissionService permissionService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private MySecurityMetadataSource mySecurityMetadataSource;

    @RequestMapping(value = "/getMenuList/{userId}",method = RequestMethod.GET)
    @ApiOperation(value = "获取用户页面菜单数据")
    @Cacheable(key = "'adminMenuList:'+#userId")
    public Result<List<Permission>> getAllMenuList(@PathVariable String userId){

        //用户所有权限 已排序去重
        List<Permission> list = permissionService.findByUserId(userId);

        List<Permission> menuList = new ArrayList<>();
        //筛选一级页面
        for(Permission p : list){
            if(CommonConstant.PERMISSION_PAGE.equals(p.getType())&&CommonConstant.LEVEL_ONE.equals(p.getLevel())){
                menuList.add(p);
            }
        }
        //筛选二级页面
        List<Permission> secondMenuList = new ArrayList<>();
        for(Permission p : list){
            if(CommonConstant.PERMISSION_PAGE.equals(p.getType())&&CommonConstant.LEVEL_TWO.equals(p.getLevel())){
                secondMenuList.add(p);
            }
        }
        //筛选二级页面拥有的按钮权限
        List<Permission> buttonPermissions = new ArrayList<>();
        for(Permission p : list){
            if(CommonConstant.PERMISSION_OPERATION.equals(p.getType())&&CommonConstant.LEVEL_THREE.equals(p.getLevel())){
                buttonPermissions.add(p);
            }
        }

        //匹配二级页面拥有权限
        for(Permission p : secondMenuList){
            List<String> permTypes = new ArrayList<>();
            for(Permission pe : buttonPermissions){
                if(p.getId().equals(pe.getParentId())){
                    permTypes.add(pe.getButtonType());
                }
            }
            p.setPermTypes(permTypes);
        }
        //匹配一级页面拥有二级页面
        for(Permission p : menuList){
            List<Permission> secondMenu = new ArrayList<>();
            for(Permission pe : secondMenuList){
                if(p.getId().equals(pe.getParentId())){
                    secondMenu.add(pe);
                }
            }
            p.setChildren(secondMenu);
        }

        return new ResultUtil<List<Permission>>().setData(menuList);
    }

    @RequestMapping(value = "/getAllList",method = RequestMethod.GET)
    @ApiOperation(value = "获取权限菜单树")
    @Cacheable(key = "'allList'")
    public Result<List<Permission>> getAllList(){

        //一级
        List<Permission> list = permissionService.list(new QueryWrapper<Permission>().eq("level", CommonConstant.LEVEL_ONE).orderByAsc("sort_order"));
        //二级
        for(Permission p1 : list){
            List<Permission> children1 = permissionService.list(new QueryWrapper<Permission>().eq("parent_id", p1.getId()).orderByAsc("sort_order"));
            p1.setChildren(children1);
            //三级
            for(Permission p2 : children1){
                List<Permission> children2 = permissionService.list(new QueryWrapper<Permission>().eq("parent_id", p2.getId()).orderByAsc("sort_order"));
                p2.setChildren(children2);
            }
        }
        return new ResultUtil<List<Permission>>().setData(list);
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ApiOperation(value = "添加")
    @CacheEvict(key = "'menuList'")
    public Result<Permission> add(@ModelAttribute Permission permission){

        // 判断拦截请求的操作权限按钮名是否已存在
        if(CommonConstant.PERMISSION_OPERATION.equals(permission.getType())){
            List<Permission> list = permissionService.list(new QueryWrapper<Permission>().eq("title", permission.getTitle()));
            if(list!=null&&list.size()>0){
                return new ResultUtil<Permission>().setErrorMsg("名称已存在");
            }
        }
        permissionService.save(permission);
        //重新加载权限
        mySecurityMetadataSource.loadResourceDefine();
        //手动删除缓存
        redisTemplate.delete("permission::allList");
        return new ResultUtil<Permission>().setData(permission);
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ApiOperation(value = "编辑")
    public Result<Permission> edit(@ModelAttribute Permission permission){

        // 判断拦截请求的操作权限按钮名是否已存在
        if(CommonConstant.PERMISSION_OPERATION.equals(permission.getType())){
            // 若名称修改
            Permission p = permissionService.getById(permission.getId());
            if(!p.getTitle().equals(permission.getTitle())){
                List<Permission> list = permissionService.list(new QueryWrapper<Permission>().eq("title", permission.getTitle()));
                if(list!=null&&list.size()>0){
                    return new ResultUtil<Permission>().setErrorMsg("名称已存在");
                }
            }
        }
        permissionService.updateById(permission);
        //重新加载权限
        mySecurityMetadataSource.loadResourceDefine();
        //手动批量删除缓存
        Set<String> keys = redisTemplate.keys("adminPermission:" + "*");
        redisTemplate.delete(keys);
        Set<String> keysUser = redisTemplate.keys("user:" + "*");
        redisTemplate.delete(keysUser);
        Set<String> keysUserMenu = redisTemplate.keys("permission::adminMenuList:*");
        redisTemplate.delete(keysUserMenu);
        redisTemplate.delete("permission::allList");
        return new ResultUtil<Permission>().setData(permission);
    }

    @RequestMapping(value = "/delByIds/{ids}",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量通过id删除")
    @CacheEvict(key = "'menuList'")
    public Result<Object> delByIds(@PathVariable String[] ids){

        for(String id:ids){
            List<RolePermission> list = rolePermissionService.list(new QueryWrapper<RolePermission>().eq("permission_id", id));
            if(list!=null&&list.size()>0){
                return new ResultUtil<>().setErrorMsg("删除失败，包含正被角色使用关联的菜单或权限");
            }
        }
        for(String id:ids){
            permissionService.removeById(id);
        }
        //重新加载权限
        mySecurityMetadataSource.loadResourceDefine();
        //手动删除缓存
        redisTemplate.delete("permission::allList");
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }
}
