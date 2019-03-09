package com.xm.admin.module.base.entity;
import java.math.BigDecimal;
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
public class SysPermission extends BaseEntity{

    private static final long serialVersionUID = 1L;

    private String description;

    private String name;

    private String parentId;

    private Integer type;

    private BigDecimal sortOrder;

    private String component;

    private String path;

    private String title;

    private String icon;

    private Integer level;

    private String buttonType;

    private Integer status;

    private String url;

    private LocalDateTime createdAt;

    private String createdBy;

    private LocalDateTime updatedAt;

    private String updatedBy;

}
