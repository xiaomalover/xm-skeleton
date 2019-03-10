package com.xm.common.vo;

import lombok.Data;

import java.io.Serializable;

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
}
