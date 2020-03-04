package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 *
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-08
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("sys_role_permission")
public class RolePermission extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String permissionId;

    private String roleId;

}
