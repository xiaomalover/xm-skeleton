package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

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

    @TableField(exist = false)
    private String roleName;

}
