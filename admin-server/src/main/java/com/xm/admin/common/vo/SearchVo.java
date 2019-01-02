package com.xm.admin.common.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class SearchVo implements Serializable {

    private String startDate;

    private String endDate;
}
