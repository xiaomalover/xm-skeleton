package com.xm.common.vo;

import lombok.Data;
import org.springframework.util.ObjectUtils;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 分页排序日期搜索前端收集VO
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class ExtraVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private int pageNumber;

    private int pageSize;

    private String sort;

    private String order;

    private Long startDate;

    private Long endDate;

    public void setStartDate(String startDate)
    {
        if (!ObjectUtils.isEmpty(startDate)) {
            this.startDate = this.stringToTimestamp(startDate);
        }
    }

    public void setEndDate(String endDate)
    {
        if (!ObjectUtils.isEmpty(endDate)) {
            Long temp = this.stringToTimestamp(endDate);
            this.endDate =  temp + 24 * 3600;
        }
    }

    private Long stringToTimestamp(String time) {
        time += " 00:00:00";
        Long timestamp = 0L;
        try {
            timestamp = ((Timestamp.valueOf(time).getTime()) / 1000);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return timestamp;
    }
}
