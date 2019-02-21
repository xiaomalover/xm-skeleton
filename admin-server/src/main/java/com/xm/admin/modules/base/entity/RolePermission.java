package com.xm.admin.modules.base.entity;

import com.xm.admin.base.BaseExtEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "sys_role_permission")
@TableName("sys_role_permission")
public class RolePermission extends BaseExtEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "角色id")
    private String roleId;

    @ApiModelProperty(value = "权限id")
    private String permissionId;
}
