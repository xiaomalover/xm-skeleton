package com.xm.admin.module.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.xm.admin.common.utils.ObjectUtil;
import com.xm.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Map;

/**
 * <p>
 * 管理员日志
 * </p>
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 * @since 2019-03-06
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("sys_admin_log")
public class AdminLog extends BaseEntity {

    private static final long serialVersionUID = 1L;

    private Integer costTime;

    private String ip;

    private String ipInfo;

    private String name;

    private String requestParam;

    private String requestType;

    private String requestUrl;

    private String username;

    /**
     * 转换请求参数为Json
     *
     * @param paramMap 参数
     */
    public void setMapToParams(Map<String, String[]> paramMap) {
        this.requestParam = ObjectUtil.mapToString(paramMap);
    }
}
