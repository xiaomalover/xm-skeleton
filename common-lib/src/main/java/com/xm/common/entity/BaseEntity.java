package com.xm.common.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.xm.common.utils.SnowFlakeUtil;
import lombok.Data;
import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 * 所有实体的其类，ID使用雪花算法
 */
@Data
public abstract class BaseEntity implements Serializable{

    private static final long serialVersionUID = 1L;

    @TableId
    private String id = String.valueOf(SnowFlakeUtil.getFlowIdInstance().nextId());
}
