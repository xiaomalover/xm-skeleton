package com.xm.admin.module.base.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.xm.admin.common.vo.PageVo;
import com.xm.admin.common.vo.SearchVo;
import com.xm.admin.module.base.entity.AdminLog;
import com.xm.admin.module.base.service.IAdminLogService;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-06
 */
@RestController
@Api(description = "日志管理接口")
@RequestMapping("/skeleton/log")
@Transactional
public class AdminLogController {

    @Autowired
    private IAdminLogService adminLogService;

    @RequestMapping(value = "/getAllByPage",method = RequestMethod.GET)
    @ApiOperation(value = "分页获取全部")
    public Result<Object> getAllByPage(@ModelAttribute PageVo pageVo){

        IPage<AdminLog> page = new CommonPageUtil<AdminLog>().initIPage(pageVo.getPageNumber(), pageVo.getPageSize());
        QueryWrapper<AdminLog> adminLogQueryWrapper = new QueryWrapper<>();
        adminLogQueryWrapper.orderByDesc( "created_at");
        IPage<AdminLog> log = adminLogService.page(page, adminLogQueryWrapper);
        return new ResultUtil<>().setData(log);
    }

    @RequestMapping(value = "/search",method = RequestMethod.GET)
    @ApiOperation(value = "分页搜索")
    public Result<Object> search(@RequestParam String key,
             @ModelAttribute SearchVo searchVo,
             @ModelAttribute PageVo pageVo){

        IPage<AdminLog> page = new CommonPageUtil<AdminLog>().initIPage(pageVo.getPageNumber(), pageVo.getPageSize());

        QueryWrapper<AdminLog> adminLogQueryWrapper = new QueryWrapper<>();
        if (!ObjectUtils.isEmpty(key)) {
            adminLogQueryWrapper.like("request_param", key.trim());
        }
        if (!StringUtils.isEmpty(searchVo.getStartDate())) {
            adminLogQueryWrapper.gt("created_at", searchVo.getStartDate());
        }
        if (!StringUtils.isEmpty(searchVo.getEndDate())) {
            adminLogQueryWrapper.lt("created_at", searchVo.getEndDate());
        }

        boolean isAsc = "asc".equals(pageVo.getOrder());
        if (!StringUtils.isEmpty(pageVo.getSort())) {
            adminLogQueryWrapper.orderBy(true, isAsc, StringUtils.camelToUnderline(pageVo.getSort()));
        } else {
            adminLogQueryWrapper.orderByDesc( "created_at");
        }

        IPage<AdminLog> log = adminLogService.page(page, adminLogQueryWrapper);

        return new ResultUtil<>().setData(log);
    }

    @RequestMapping(value = "/delByIds/{ids}",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量删除")
    public Result<Object> delByIds(@PathVariable String[] ids){

        for(String id : ids){
            adminLogService.removeById(id);
        }
        return new ResultUtil<>().setSuccessMsg("删除成功");
    }

    @RequestMapping(value = "/delAll",method = RequestMethod.DELETE)
    @ApiOperation(value = "全部删除")
    public Result<Object> delAll(){
        QueryWrapper<AdminLog> queryWrapper = new QueryWrapper<>();
        queryWrapper.gt("id", 0);
        adminLogService.remove(queryWrapper);
        return new ResultUtil<>().setSuccessMsg("删除成功");
    }
}
