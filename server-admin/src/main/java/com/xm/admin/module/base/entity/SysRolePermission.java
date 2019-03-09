package com.xm.admin.module.base.entity;
import java.time.LocalDateTime;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
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
public class SysRolePermission extends BaseEntity{

    private static final long serialVersionUID = 1L;

    private String permissionId;

    private String roleId;

    private LocalDateTime createdAt;

    private String createdBy;

    private LocalDateTime updatedAt;

    private String updatedBy;

}
