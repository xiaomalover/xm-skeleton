package com.xm.common.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Data
public class Captcha implements Serializable {

    private String captchaId;

    private String code;
}
