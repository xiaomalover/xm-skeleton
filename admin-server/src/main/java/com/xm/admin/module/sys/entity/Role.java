package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

/**
 * <p>
 *
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_role")
public class Role extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String name;

    private Boolean defaultRole;

    private String description;

    private Integer dataType;

    @TableField(exist = false)
    private List<Permission> permissions;
}
