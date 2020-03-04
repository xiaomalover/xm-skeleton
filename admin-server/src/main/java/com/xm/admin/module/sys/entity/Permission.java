package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import com.xm.common.enums.CommonStatus;
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

    private Integer status = CommonStatus.STATUS_ENABLED.getStatus();

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
}
