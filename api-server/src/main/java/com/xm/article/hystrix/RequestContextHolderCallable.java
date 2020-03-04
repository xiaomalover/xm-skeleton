package com.xm.article.hystrix;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import java.util.concurrent.Callable;

/**
 * 必须加此配置才能在feign线程的上下文中获取当前请求的上下文
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class RequestContextHolderCallable<V> implements Callable<V> {
    private final Callable<V> delegate;
    private final RequestAttributes originalRequestAttributes;

    RequestContextHolderCallable(Callable<V> delegate, RequestAttributes originalRequestAttributes) {
        this.delegate = delegate;
        this.originalRequestAttributes = originalRequestAttributes;
    }

    @Override
    public V call() throws Exception {
        RequestAttributes currentRequestAttributes = RequestContextHolder.getRequestAttributes();
        try {
            RequestContextHolder.setRequestAttributes(originalRequestAttributes);
            return delegate.call();
        } finally {
            RequestContextHolder.setRequestAttributes(currentRequestAttributes);
        }
    }
}
