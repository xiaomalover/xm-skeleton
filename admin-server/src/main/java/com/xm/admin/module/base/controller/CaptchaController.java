package com.xm.admin.module.base.controller;

import com.xm.admin.common.utils.CaptchaUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.admin.common.vo.Captcha;
import com.xm.common.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import com.alibaba.fastjson.JSONObject;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@RequestMapping("/skeleton/common/captcha")
@RestController
@Transactional
public class CaptchaController {

    @Autowired
    private StringRedisTemplate redisTemplate;

    @RequestMapping(value = "/init",method = RequestMethod.GET)
    public Result<Object> initCaptcha() {

        String captchaId = UUID.randomUUID().toString().replace("-","");
        String code = new CaptchaUtil().randomStr(4);
        Captcha captcha = new Captcha();
        captcha.setCaptchaId(captchaId);
        //缓存验证码
        redisTemplate.opsForValue().set(captchaId,code,3L, TimeUnit.MINUTES);
        return new ResultUtil<Object>().setData(captcha);
    }

    @RequestMapping(value = "/draw/{captchaId}", method = RequestMethod.GET)
    public JSONObject drawCaptcha(@PathVariable("captchaId") String captchaId, HttpServletResponse response) throws IOException {

        //得到验证码 生成指定验证码
        String code=redisTemplate.opsForValue().get(captchaId);
        CaptchaUtil vCode = new CaptchaUtil(108,36,4,10,code);
        return vCode.getBase64Captcha();
    }
}
