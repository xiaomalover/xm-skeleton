package com.xm.admin.module.base.entity;

import java.util.List;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.utils.SnowFlakeUtil;
import com.xm.admin.module.base.entity.co.Permission;
import com.xm.common.entity.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
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
 * @since 2019-03-07
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_role")
public class Role extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());

    private String name;

    private Boolean defaultRole;

    private String description;

    private Integer dataType;

    @TableField(fill= FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill= FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;
    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "拥有权限")
    private List<Permission> permissions;
}
