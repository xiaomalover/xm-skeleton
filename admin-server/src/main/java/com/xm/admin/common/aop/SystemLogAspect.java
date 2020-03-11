package com.xm.admin.common.aop;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.xm.admin.common.annotation.SystemLog;
import com.xm.admin.common.utils.IpInfoUtil;
import com.xm.admin.common.utils.ThreadPoolUtil;
import com.xm.admin.module.sys.entity.AdminLog;
import com.xm.admin.module.sys.service.IAdminLogService;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.Map;

/**
 * Spring AOP实现日志管理
 * 多线程异步记录日志
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@SuppressWarnings("SpringJavaAutowiredFieldsWarningInspection")
@Aspect
@Component
@Slf4j
public class SystemLogAspect {

    /**
     * 多线程时，ThreadLocal，为每个线程保存线程内能访问的数据，通过ThreadLocal各个线程只能获取自身对应的数据，
     * 不能访问其他线程的数据
     */
    private static final ThreadLocal<Date> beginTimeThreadLocal = new NamedThreadLocal<>("ThreadLocal beginTime");

    @Autowired
    private IAdminLogService logService;

    @Autowired(required = false)
    private HttpServletRequest request;

    @Autowired
    private IpInfoUtil ipInfoUtil;

    /**
     * Controller层切点,注解方式
     */
    //@Pointcut("execution(* *..controller..*Controller*.*(..))")
    @Pointcut("@annotation(com.xm.admin.common.annotation.SystemLog)")
    public void controllerAspect() {
    }

    /**
     * 前置通知 (在方法执行之前返回)用于拦截Controller层记录用户的操作的开始时间
     */
    @Before("controllerAspect()")
    public void doBefore() {

        //线程绑定变量（该数据只有当前请求的线程可见）
        Date beginTime = new Date();
        beginTimeThreadLocal.set(beginTime);
    }

    /**
     * 后置通知(在方法执行之后返回) 用于拦截Controller层操作
     *
     * @param joinPoint 切点
     */
    @After("controllerAspect()")
    public void after(JoinPoint joinPoint) {
        try {

            String username = "admin";
            if (!ObjectUtils.isEmpty(SecurityContextHolder.getContext())) {
                if (!ObjectUtils.isEmpty(SecurityContextHolder.getContext().getAuthentication())) {
                    UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                    if (ObjectUtil.isNotNull(user)) {
                        username = user.getUsername();
                    }
                }
            }

            if (StrUtil.isNotBlank(username)) {

                AdminLog log = new AdminLog();

                //日志标题
                log.setName(getControllerMethodDescription(joinPoint));
                //日志请求url
                log.setRequestUrl(request.getRequestURI());
                //请求方式
                log.setRequestType(request.getMethod());
                //请求参数
                Map<String, String[]> logParams = request.getParameterMap();
                log.setMapToParams(logParams);
                //请求用户
                log.setUsername(username);
                //请求IP
                log.setIp(ipInfoUtil.getIpAddr(request));
                //请求开始时间
                long beginTime = beginTimeThreadLocal.get().getTime();
                long endTime = System.currentTimeMillis();
                //请求耗时
                Long logElapsedTime = endTime - beginTime;
                log.setCostTime(logElapsedTime.intValue());

                //调用线程保存至数据库
                ThreadPoolUtil.getPool().execute(new SaveSystemLogThread(log, logService));
            }
        } catch (Exception e) {
            log.error("AOP后置通知异常", e);
        }
    }

    /**
     * 保存日志至数据库
     */
    private static class SaveSystemLogThread implements Runnable {

        private AdminLog log;

        private IAdminLogService logService;

        SaveSystemLogThread(AdminLog log, IAdminLogService logService) {
            this.log = log;
            this.logService = logService;
        }

        @Override
        public void run() {
            logService.save(log);
        }
    }

    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     *
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception 异常
     */
    private static String getControllerMethodDescription(JoinPoint joinPoint) throws Exception {

        //获取目标类名
        String targetName = joinPoint.getTarget().getClass().getName();
        //获取方法名
        String methodName = joinPoint.getSignature().getName();
        //获取相关参数
        Object[] arguments = joinPoint.getArgs();
        //生成类对象
        Class targetClass = Class.forName(targetName);
        //获取该类中的方法
        Method[] methods = targetClass.getMethods();

        String description = "";

        for (Method method : methods) {
            if (!method.getName().equals(methodName)) {
                continue;
            }
            Class[] clazzs = method.getParameterTypes();
            if (clazzs.length != arguments.length) {
                //比较方法中参数个数与从切点中获取的参数个数是否相同，原因是方法可以重载哦
                continue;
            }
            description = !ObjectUtils.isEmpty(method.getAnnotation(SystemLog.class)) ?
                    method.getAnnotation(SystemLog.class).description() : "";
        }
        return description;
    }

}
