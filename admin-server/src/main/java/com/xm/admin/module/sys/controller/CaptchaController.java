package com.xm.admin.module.sys.controller;

import com.alibaba.fastjson.JSONObject;
import com.xm.common.utils.CaptchaUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Captcha;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@RequestMapping("/skeleton/common/captcha")
@RestController
@Transactional
public class CaptchaController {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @GetMapping("/init")
    public Result<Object> initCaptcha() {

        String captchaId = UUID.randomUUID().toString().replace("-", "");
        String code = new CaptchaUtil().randomStr(4);
        Captcha captcha = new Captcha();
        captcha.setCaptchaId(captchaId);
        //缓存验证码
        redisTemplate.opsForValue().set(captchaId, code, 3L, TimeUnit.MINUTES);
        return new ResultUtil<Object>().setData(captcha);
    }

    @GetMapping("/draw/{captchaId}")
    public JSONObject drawCaptcha(@PathVariable("captchaId") String captchaId, HttpServletResponse response) throws IOException {

        //得到验证码 生成指定验证码
        String code = redisTemplate.opsForValue().get(captchaId);
        CaptchaUtil vCode = new CaptchaUtil(108, 36, 4, 10, code);
        return vCode.getBase64Captcha();
    }
}
