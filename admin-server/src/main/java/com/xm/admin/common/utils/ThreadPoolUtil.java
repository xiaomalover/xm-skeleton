package com.xm.admin.common.utils;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * 线程池工具类
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class ThreadPoolUtil {

    /**
     * 线程缓冲队列
     */
    private static BlockingQueue<Runnable> bqueue = new ArrayBlockingQueue<>(100);

    /**
     * 核心线程数，会一直存活，即使没有任务，线程池也会维护线程的最少数量
     */
    private static final int SIZE_CORE_POOL = 5;

    /**
     * 线程池维护线程的最大数量
     */
    private static final int SIZE_MAX_POOL = 10;

    /**
     * 线程池维护线程所允许的空闲时间
     */
    private static final long ALIVE_TIME = 2000;

    /**
     * 创建线程池
     * 拒绝策略 AbortPolicy(): 拒绝执行并抛出 RejectedExecutionException.
     * 拒绝策略 CallerRunsPolicy():  用于被拒绝任务的处理程序，它直接在 execute 方法的调用线程中运行被拒绝的任务,
     * 如果执行程序已关闭，则会丢弃该任务。
     * 拒绝策略 DiscardPolicy() : 丢弃当前将要加入队列的任务本身。
     * 拒绝策略 DiscardOldestPolicy() : 丢弃任务队列中最旧任务。
     */
    private static ThreadPoolExecutor pool = new ThreadPoolExecutor(
            SIZE_CORE_POOL,
            SIZE_MAX_POOL,
            ALIVE_TIME,
            TimeUnit.MILLISECONDS,
            bqueue,
            new ThreadPoolExecutor.CallerRunsPolicy()
    );

    //静态代码块，启动时主动执行，只执行一次
    //不同于静态方法，静态属性，是通过访问类被动调用的
    static {
        //启动时开启核心线程
        pool.prestartAllCoreThreads();
    }

    /**
     * 获取线程池
     *
     * @return 线程池
     */
    public static ThreadPoolExecutor getPool() {
        return pool;
    }

    /**
     * 测试
     *
     * @param args 参数
     */
    public static void main(String[] args) {
        System.out.println(pool.getPoolSize());
    }
}
