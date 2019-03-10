package com.xm.admin.config.exception;

import lombok.Data;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class SkeletonException extends RuntimeException {

    private String msg;

    public SkeletonException(String msg) {
        super(msg);
        this.msg = msg;
    }
}
