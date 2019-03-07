package com.xm.admin.module.base.entity;

import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.utils.SnowFlakeUtil;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.persistence.Id;
import javax.persistence.Transient;

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
public class Department extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());

    private Boolean isParent;

    private String parentId;

    private BigDecimal sortOrder;

    private Integer status;

    private String title;

    @TableField(fill= FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill= FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;

    @Transient
    @TableField(exist=false)
    private String parentTitle;

}
