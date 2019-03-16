package com.xm.api.hystrix;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.concurrent.Callable;

public class RequestContextHolderCallable<V> implements Callable<V> {
    private final Callable<V> delegate;
    private final RequestAttributes originalRequestAttributes;

    public RequestContextHolderCallable(Callable<V> delegate, RequestAttributes originalRequestAttributes) {
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
