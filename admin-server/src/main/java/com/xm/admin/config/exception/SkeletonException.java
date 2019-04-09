package com.xm.admin.config.exception;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SkeletonException extends RuntimeException {

    private String msg;

    public SkeletonException(String msg) {
        super(msg);
        this.msg = msg;
    }
}
