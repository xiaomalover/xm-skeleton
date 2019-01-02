package com.xm.admin.common.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class City implements Serializable {

    String country;

    String province;

    String city;
}
