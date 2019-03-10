package com.xm.admin.module.base.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.util.List;

/**
 * 菜单/权限
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_permission")
public class Permission extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String name;

    private Integer level;

    private Integer type;

    private String title;

    private String path;

    private String component;

    private String icon;

    private String buttonType;

    private String parentId;

    private String description;

    private BigDecimal sortOrder;

    private Integer status = CommonConstant.STATUS_NORMAL;

    private String url;

    @TableField(exist = false)
    private List<Permission> children;

    @TableField(exist = false)
    private List<String> permTypes;

    @TableField(exist = false)
    private Boolean expand = true;

    @TableField(exist = false)
    private Boolean checked = false;

    @TableField(exist = false)
    private Boolean selected = false;

    @TableField(fill = FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;
}
