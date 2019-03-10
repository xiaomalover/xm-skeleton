package com.xm.admin.quartz.jobs;

import cn.hutool.core.date.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * 示例带参定时任务
 *
 * @author Exrickx
 */
@Slf4j
public class JobWithoutParam implements Job {

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        log.info("无参测试任务执行了，时间:{}", DateUtil.now());
    }
}
