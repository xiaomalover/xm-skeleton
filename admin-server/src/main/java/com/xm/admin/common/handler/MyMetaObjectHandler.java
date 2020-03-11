package com.xm.admin.common.handler;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;

/**
 * 填充器, 新增和修改时自动填充时间
 * 配合实体中的 @TableField(fill= FieldFill.INSERT) 和 @TableField(fill= FieldFill.INSERT_UPDATE) 使用
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        Long now = getTimestamp();
        String user = getUser();
        setFieldValByName("createdAt", now, metaObject);
        setFieldValByName("updatedAt", now, metaObject);
        setFieldValByName("createdBy", user, metaObject);
        setFieldValByName("updatedBy", user, metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        setFieldValByName("updatedAt", getTimestamp(), metaObject);
        setFieldValByName("updatedBy", getUser(), metaObject);
    }

    private Long getTimestamp() {
        return System.currentTimeMillis() / 1000;
    }

    private String getUser() {
        if (!ObjectUtils.isEmpty(SecurityContextHolder.getContext())) {
            if (!ObjectUtils.isEmpty(SecurityContextHolder.getContext().getAuthentication())) {
                UserDetails user = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                if (ObjectUtil.isNotNull(user)) {
                    return user.getUsername();
                }
            }
        }
        return "admin";
    }
}
