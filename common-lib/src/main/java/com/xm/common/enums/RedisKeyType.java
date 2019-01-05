package com.xm.common.enums;

public enum RedisKeyType {

    TOKEN_PREFIX("token_", "用户TOKEN前缀");

    private String key;

    private String description;

    RedisKeyType(String key, String description) {
        this.key = key;
        this.description = description;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

