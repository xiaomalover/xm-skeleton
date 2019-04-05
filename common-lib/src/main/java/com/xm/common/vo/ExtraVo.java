package com.xm.common.vo;

import lombok.Data;
import org.springframework.util.ObjectUtils;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 分页排序日期搜索前端收集VO
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class ExtraVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private int pageNumber;

    private int pageSize;

    private String sort;

    private String order;

    private String startDate;

    private String endDate;

    public String getEndDate()
    {
        if (!ObjectUtils.isEmpty(endDate)) {
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
            Date d;
            try {
                d = new Date(f.parse(endDate).getTime() + 24 * 3600 * 1000);
            } catch (ParseException e) {
                return endDate;
            }
            return f.format(d);
        }
        return endDate;
    }
}
