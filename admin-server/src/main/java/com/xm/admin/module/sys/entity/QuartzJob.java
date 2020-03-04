package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.common.entity.BaseEntity;
import com.xm.common.enums.CommonStatus;
import lombok.Data;
import lombok.EqualsAndHashCode;

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
@TableName("qrtz_quartz_job")
public class QuartzJob extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String cronExpression;

    private String description;

    private String jobClassName;

    private String parameter;

    private Integer status = CommonStatus.STATUS_ENABLED.getStatus();
}
