package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;

/**
 * <p>
 *
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-06
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_department")
public class Department extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private Boolean isParent;

    private String parentId;

    private BigDecimal sortOrder;

    private Integer status;

    private String title;

    @TableField(exist = false)
    private String parentTitle;

}
