package com.xm.admin.modules.base.controller.manage;

import com.xm.admin.common.utils.PageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.admin.common.vo.PageVo;
import com.xm.common.vo.Result;
import com.xm.admin.common.vo.SearchVo;
import com.xm.admin.modules.base.entity.Log;
import com.xm.admin.modules.base.service.LogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;


/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@RestController
@Api(description = "日志管理接口")
@RequestMapping("/skeleton/log")
@Transactional
public class LogController{

    @Value("${skeleton.logRecord.es}")
    private Boolean esRecord;

    @Autowired
    private LogService logService;

    @RequestMapping(value = "/getAllByPage",method = RequestMethod.GET)
    @ApiOperation(value = "分页获取全部")
    public Result<Object> getAllByPage(@ModelAttribute PageVo pageVo){

        Page<Log> log = logService.findAll(PageUtil.initPage(pageVo));
        return new ResultUtil<Object>().setData(log);
    }

    @RequestMapping(value = "/search",method = RequestMethod.GET)
    @ApiOperation(value = "分页搜索")
    public Result<Object> search(@RequestParam String key,
                                 @ModelAttribute SearchVo searchVo,
                                 @ModelAttribute PageVo pageVo){

        Page<Log> log = logService.searchLog(key, searchVo, PageUtil.initPage(pageVo));
        return new ResultUtil<Object>().setData(log);
    }

    @RequestMapping(value = "/delByIds/{ids}",method = RequestMethod.DELETE)
    @ApiOperation(value = "批量删除")
    public Result<Object> delByIds(@PathVariable String[] ids){

        for(String id : ids){
            logService.delete(id);
        }
        return new ResultUtil<Object>().setSuccessMsg("删除成功");
    }

    @RequestMapping(value = "/delAll",method = RequestMethod.DELETE)
    @ApiOperation(value = "全部删除")
    public Result<Object> delAll(){

        logService.deleteAll();
        return new ResultUtil<Object>().setSuccessMsg("删除成功");
    }
}
