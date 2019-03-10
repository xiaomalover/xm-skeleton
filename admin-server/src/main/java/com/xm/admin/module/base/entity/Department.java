package com.xm.admin.module.base.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.data.annotation.Transient;

import java.math.BigDecimal;

/**
 * <p>
 *
 * </p>
 *
 * @author xiaomalover
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

    @TableField(fill = FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;

    @Transient
    @TableField(exist = false)
    private String parentTitle;

}
