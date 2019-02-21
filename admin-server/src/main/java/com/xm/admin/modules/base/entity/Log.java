package com.xm.admin.modules.base.entity;

import com.xm.admin.base.BaseExtEntity;
import com.xm.admin.common.utils.ObjectUtil;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Map;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Entity
@Table(name = "sys_admin_log")
@TableName("sys_admin_log")
public class Log extends BaseExtEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "方法操作名称")
    private String name;

    @ApiModelProperty(value = "请求路径")
    private String requestUrl;

    @ApiModelProperty(value = "请求类型")
    private String requestType;

    @ApiModelProperty(value = "请求参数")
    private String requestParam;

    @ApiModelProperty(value = "请求用户")
    private String username;

    @ApiModelProperty(value = "ip")
    private String ip;

    @ApiModelProperty(value = "ip信息")
    private String ipInfo;

    @ApiModelProperty(value = "花费时间")
    private Integer costTime;

    /**
     * 转换请求参数为Json
     * @param paramMap
     */
    public void setMapToParams(Map<String, String[]> paramMap) {

        this.requestParam = ObjectUtil.mapToString(paramMap);
    }

}
