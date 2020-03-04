package com.xm.common.enums;

/**
 * 通用状态枚举
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public enum CommonStatus {
    /**
     * 状态 - 无效
     */
    STATUS_DISABLED(0, "无效"),

    /**
     * 状态 - 无效
     */
    STATUS_ENABLED(1, "有效"),

    /**
     * 状态 - 删除
     */
    STATUS_DELETED(2, "删除");

    /**
     * 状态
     */
    private int status;

    /**
     * 描述
     */
    private String description;

    CommonStatus(int status, String description) {
        this.status = status;
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
