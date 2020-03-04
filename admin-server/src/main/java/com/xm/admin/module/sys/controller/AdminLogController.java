package com.xm.admin.module.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.xm.admin.module.sys.entity.AdminLog;
import com.xm.admin.module.sys.service.IAdminLogService;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-06
 */
@RestController
@RequestMapping("/skeleton/log")
@Transactional
public class AdminLogController {

    @Autowired
    private IAdminLogService adminLogService;

    @GetMapping("/getAllByPage")
    public Result<Object> getAllByPage(@ModelAttribute ExtraVo extraVo) {

        IPage<AdminLog> page = new CommonPageUtil<AdminLog>().initIPage(extraVo);
        QueryWrapper<AdminLog> adminLogQueryWrapper = new QueryWrapper<>();
        adminLogQueryWrapper.orderByDesc("created_at");
        IPage<AdminLog> log = adminLogService.page(page, adminLogQueryWrapper);
        return new ResultUtil<>().setData(log);
    }

    @GetMapping("/search")
    public Result<Object> search(@RequestParam String key, @ModelAttribute ExtraVo extraVo) {

        IPage<AdminLog> page = new CommonPageUtil<AdminLog>().initIPage(extraVo);

        QueryWrapper<AdminLog> adminLogQueryWrapper = new QueryWrapper<>();
        if (!ObjectUtils.isEmpty(key)) {
            adminLogQueryWrapper.like("request_param", key.trim());
        }
        if (ObjectUtils.isNotNull(extraVo.getStartDate()) && extraVo.getStartDate() > 0) {
            adminLogQueryWrapper.gt("created_at", extraVo.getStartDate());
        }
        if (ObjectUtils.isNotNull(extraVo.getEndDate()) && extraVo.getEndDate() > 0) {
            adminLogQueryWrapper.lt("created_at", extraVo.getEndDate());
        }

        boolean isAsc = "asc".equals(extraVo.getOrder());
        if (!StringUtils.isEmpty(extraVo.getSort())) {
            adminLogQueryWrapper.orderBy(true, isAsc, StringUtils.camelToUnderline(extraVo.getSort()));
        } else {
            adminLogQueryWrapper.orderByDesc("created_at");
        }

        IPage<AdminLog> log = adminLogService.page(page, adminLogQueryWrapper);

        return new ResultUtil<>().setData(log);
    }

    @DeleteMapping("/delByIds/{ids}")
    public Result<Object> delByIds(@PathVariable String[] ids) {

        for (String id : ids) {
            adminLogService.removeById(id);
        }
        return new ResultUtil<>().setSuccessMsg("删除成功");
    }

    @DeleteMapping("/delAll")
    public Result<Object> delAll() {
        QueryWrapper<AdminLog> queryWrapper = new QueryWrapper<>();
        queryWrapper.gt("id", 0);
        adminLogService.remove(queryWrapper);
        return new ResultUtil<>().setSuccessMsg("删除成功");
    }
}
