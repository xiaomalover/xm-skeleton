package com.xm.admin.module.base.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.constant.CommonConstant;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

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
@TableName("qrtz_quartz_job")
public class QuartzJob extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private String cronExpression;

    private String description;

    private String jobClassName;

    private String parameter;

    private Integer status = CommonConstant.STATUS_NORMAL;
}
