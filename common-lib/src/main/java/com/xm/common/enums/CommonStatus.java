package com.xm.common.enums;

public enum CommonStatus {
    STATUS_DISABLED(0, "无效"),
    STATUS_ENABLED(1, "有效");

    private int status;

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
