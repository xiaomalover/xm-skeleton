package com.xm.admin.module.sys.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.xm.admin.common.annotation.SystemLog;
import com.xm.admin.config.exception.SkeletonException;
import com.xm.admin.module.sys.entity.QuartzJob;
import com.xm.admin.module.sys.service.IQuartzJobService;
import com.xm.common.enums.CommonStatus;
import com.xm.common.utils.CommonPageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.ExtraVo;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@RestController
@RequestMapping("/skeleton/quartzJob")
public class QuartzJobController {

    @Autowired
    private IQuartzJobService quartzJobService;

    @Autowired
    private Scheduler scheduler;

    @GetMapping("/getAllByPage")
    public Result<IPage<QuartzJob>> getAll(@ModelAttribute ExtraVo extraVo) {

        IPage<QuartzJob> page = new CommonPageUtil<QuartzJob>().initIPage(extraVo);
        IPage<QuartzJob> data = quartzJobService.page(page);
        return new ResultUtil<IPage<QuartzJob>>().setData(data);
    }

    @PostMapping("/add")
    @SystemLog(description = "添加定时任务")
    public Result<Object> addJob(@ModelAttribute QuartzJob job) {

        QuartzJob quartzJob = quartzJobService.getOne(new QueryWrapper<QuartzJob>().eq("job_class_name", job.getJobClassName()));
        if (!ObjectUtils.isEmpty(quartzJob)) {
            return new ResultUtil<>().setErrorMsg("该定时任务类名已存在");
        }
        add(job.getJobClassName(), job.getCronExpression(), job.getParameter());
        quartzJobService.save(job);
        return new ResultUtil<>().setSuccessMsg("创建定时任务成功");
    }

    @PostMapping("/edit")
    public Result<Object> editJob(@ModelAttribute QuartzJob job) {

        delete(job.getJobClassName());
        add(job.getJobClassName(), job.getCronExpression(), job.getParameter());
        job.setStatus(CommonStatus.STATUS_ENABLED.getStatus());
        quartzJobService.updateById(job);
        return new ResultUtil<>().setSuccessMsg("更新定时任务成功");
    }

    @PostMapping("/pause")
    @SystemLog(description = "暂停定时任务")
    public Result<Object> pauseJob(@ModelAttribute QuartzJob job) {

        try {
            scheduler.pauseJob(JobKey.jobKey(job.getJobClassName()));
        } catch (SchedulerException e) {
            throw new SkeletonException("暂停定时任务失败");
        }
        job.setStatus(CommonStatus.STATUS_DISABLED.getStatus());
        quartzJobService.updateById(job);
        return new ResultUtil<>().setSuccessMsg("暂停定时任务成功");
    }

    @PostMapping("/resume")
    @SystemLog(description = "恢复定时任务")
    public Result<Object> resumeJob(@ModelAttribute QuartzJob job) {

        try {
            scheduler.resumeJob(JobKey.jobKey(job.getJobClassName()));
        } catch (SchedulerException e) {
            throw new SkeletonException("恢复定时任务失败");
        }
        job.setStatus(CommonStatus.STATUS_ENABLED.getStatus());
        quartzJobService.updateById(job);
        return new ResultUtil<>().setSuccessMsg("恢复定时任务成功");
    }

    @DeleteMapping("/delByIds/{ids}")
    @SystemLog(description = "删除定时任务")
    public Result<Object> deleteJob(@PathVariable String[] ids) {
        for (String id : ids) {
            QuartzJob job = quartzJobService.getById(id);
            delete(job.getJobClassName());
            quartzJobService.removeById(job);
        }
        return new ResultUtil<>().setSuccessMsg("删除定时任务成功");
    }

    /**
     * 添加定时任务
     *
     * @param jobClassName   任务类名
     * @param cronExpression 表达式
     * @param parameter      参数
     */
    public void add(String jobClassName, String cronExpression, String parameter) {

        try {
            // 启动调度器
            scheduler.start();

            //构建job信息
            JobDetail jobDetail = JobBuilder.newJob(getClass(jobClassName).getClass())
                    .withIdentity(jobClassName)
                    .usingJobData("parameter", parameter)
                    .build();

            //表达式调度构建器(即任务执行的时间)
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);

            //按新的cronExpression表达式构建一个新的trigger
            CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(jobClassName)
                    .withSchedule(scheduleBuilder).build();

            scheduler.scheduleJob(jobDetail, trigger);
        } catch (SchedulerException e) {
            log.error(e.toString());
            throw new SkeletonException("创建定时任务失败");
        } catch (Exception e) {
            throw new SkeletonException("后台找不到该类名任务");
        }
    }

    /**
     * 删除定时任务
     *
     * @param jobClassName 定时任务类
     */
    public void delete(String jobClassName) {

        try {
            scheduler.pauseTrigger(TriggerKey.triggerKey(jobClassName));
            scheduler.unscheduleJob(TriggerKey.triggerKey(jobClassName));
            scheduler.deleteJob(JobKey.jobKey(jobClassName));
        } catch (Exception e) {
            throw new SkeletonException("删除定时任务失败");
        }
    }

    public static Job getClass(String classname) throws Exception {
        Class<?> class1 = Class.forName(classname);
        return (Job) class1.newInstance();
    }
}
