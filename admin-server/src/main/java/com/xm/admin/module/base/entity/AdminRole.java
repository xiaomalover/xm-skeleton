package com.xm.admin.module.base.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.data.annotation.Transient;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_admin_role")
public class AdminRole extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String userId;

    private String roleId;

    @Transient
    @TableField(exist = false)
    private String roleName;

    @TableField(fill = FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;
}
