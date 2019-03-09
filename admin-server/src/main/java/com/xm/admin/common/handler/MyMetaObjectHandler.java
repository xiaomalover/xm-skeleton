package com.xm.admin.common.handler;

import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import java.text.SimpleDateFormat;

/**
 * 填充器, 新增和修改时自动填充时间
 * 配合实体中的 @TableField(fill= FieldFill.INSERT) 和 @TableField(fill= FieldFill.INSERT_UPDATE) 使用
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    @Override
    public void insertFill(MetaObject metaObject) {
        String now = getSqlDate();
        setFieldValByName("createdAt", now, metaObject);
        setFieldValByName("updatedAt", now, metaObject);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        setFieldValByName("updatedAt", getSqlDate(), metaObject);
    }

    private String getSqlDate()
    {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(System.currentTimeMillis());
    }
}
