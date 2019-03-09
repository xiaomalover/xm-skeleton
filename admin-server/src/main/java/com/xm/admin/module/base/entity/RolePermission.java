package com.xm.admin.module.base.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.utils.SnowFlakeUtil;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * <p>
 * 
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@Table(name = "sys_role_permission")
@TableName("sys_role_permission")
public class RolePermission extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());

    private String permissionId;

    private String roleId;

    @TableField(fill= FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill= FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;

}
