package com.xm.admin.module.base.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.utils.SnowFlakeUtil;
import com.xm.common.entity.BaseEntity;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "sys_admin_role")
@TableName("sys_admin_role")
public class AdminRole extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @Id
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());

    @ApiModelProperty(value = "用户唯一id")
    private String userId;

    @ApiModelProperty(value = "角色唯一id")
    private String roleId;

    @Transient
    @TableField(exist=false)
    @ApiModelProperty(value = "角色名")
    private String roleName;

    @TableField(fill= FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill= FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;
}
