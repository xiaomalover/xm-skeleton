package com.xm.admin.module.base.entity;

import java.util.Map;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.utils.ObjectUtil;
import com.xm.admin.common.utils.SnowFlakeUtil;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.persistence.Id;

/**
 * <p>
 *  管理员日志
 * </p>
 *
 * @author xiaomalover
 * @since 2019-03-06
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_admin_log")
public class AdminLog extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @Id
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());

    private Integer costTime;

    private String ip;

    private String ipInfo;

    private String name;

    private String requestParam;

    private String requestType;

    private String requestUrl;

    private String username;

    @TableField(fill= FieldFill.INSERT)
    private String createdAt;

    private String createdBy;

    @TableField(fill= FieldFill.INSERT_UPDATE)
    private String updatedAt;

    private String updatedBy;

    /**
     * 转换请求参数为Json
     * @param paramMap 参数
     */
    public void setMapToParams(Map<String, String[]> paramMap) {
        this.requestParam = ObjectUtil.mapToString(paramMap);
    }
}
