package com.xm.admin.module.base.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.admin.common.utils.ObjectUtil;
import com.xm.admin.module.base.entity.Admin;
import com.xm.admin.module.base.entity.Department;
import com.xm.admin.module.base.service.IAdminService;
import com.xm.admin.module.base.service.IDepartmentService;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Set;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-06
 */
@RestController
@Api(description = "部门管理接口")
@RequestMapping("/skeleton/department")
@CacheConfig(cacheNames = "department")
@Transactional
public class DepartmentController {

    @Autowired
    IDepartmentService departmentService;

    @Autowired
    private IAdminService adminService;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/getByParentId/{parentId}",method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    @Cacheable(key = "#parentId")
    public Result<List<Department>> getByParentId(@PathVariable String parentId){

        QueryWrapper<Department> departmentQueryWrapper = new QueryWrapper<>();
        departmentQueryWrapper.eq("parent_id", parentId).orderByAsc("sort_order");
        List<Department> list = departmentService.list(departmentQueryWrapper);
        // lambda表达式
        list.forEach(item -> {
            if(!CommonConstant.PARENT_ID.equals(item.getParentId())){
                Department parent = departmentService.getById(item.getParentId());
                item.setParentTitle(parent.getTitle());
            }else{
                item.setParentTitle("一级部门");
            }
        });
        return new ResultUtil<List<Department>>().setData(list);
    }

    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ApiOperation(value = "添加")
    @CacheEvict(key = "#department.parentId")
    public Result<Department> add(@ModelAttribute Department department){

        departmentService.save(department);

        // 如果不是添加的一级 判断设置上级为父节点标识
        if(!CommonConstant.PARENT_ID.equals(department.getParentId())){
            Department parent = departmentService.getById(department.getParentId());
            if(parent.getIsParent()==null||!parent.getIsParent()){
                parent.setIsParent(true);
                departmentService.updateById(parent);
                // 更新上级节点的缓存
                redisTemplate.delete("department::" + parent.getParentId());
            }
        }
        return new ResultUtil<Department>().setData(department);
    }

    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ApiOperation(value = "编辑")
    public Result<Department> edit(@ModelAttribute Department department){

        departmentService.updateById(department);
        // 手动删除所有部门缓存
        Set<String> keys = redisTemplate.keys("department:" + "*");
        redisTemplate.delete(keys);
        // 删除所有用户缓存
        Set<String> keysUser = redisTemplate.keys("user:" + "*");
        redisTemplate.delete(keysUser);
        return new ResultUtil<Department>().setData(department);
    }

    @RequestMapping(value = "/delByIds/{ids}",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delByIds(@PathVariable String[] ids){

        for(String id:ids){
            Admin admin = adminService.getOne(new QueryWrapper<Admin>().eq("department_id", id));
            if(!ObjectUtils.isEmpty(admin)){
                return new ResultUtil<>().setErrorMsg("删除失败，包含正被用户使用关联的部门");
            }
        }
        for(String id:ids){
            departmentService.removeById(id);
        }
        // 手动删除所有部门缓存
        Set<String> keys = redisTemplate.keys("department:" + "*");
        redisTemplate.delete(keys);
        return new ResultUtil<>().setSuccessMsg("批量通过id删除数据成功");
    }
}
