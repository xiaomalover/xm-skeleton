package com.xm.admin.modules.base.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.xm.admin.base.BaseExtEntity;
import com.xm.admin.common.constant.CommonConstant;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author Exrickx
 */
@Data
@Entity
@Table(name = "qrtz_quartz_job")
@TableName("qrtz_quartz_job")
public class QuartzJob extends BaseExtEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "任务类名")
    private String jobClassName;

    @ApiModelProperty(value = "cron表达式")
    private String cronExpression;

    @ApiModelProperty(value = "参数")
    private String parameter;

    @ApiModelProperty(value = "备注")
    private String description;

    @ApiModelProperty(value = "状态 0正常 -1停止")
    private Integer status = CommonConstant.STATUS_NORMAL;
}
