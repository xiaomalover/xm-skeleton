package com.xm.admin.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间互转工具
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class TimeUtil {

    /**
     * 时间戳转换成日期格式字符串
     * @param seconds 精确到秒的字符串
     * @param format 时间格式
     * @return 时间戳
     */
    public static Integer dateToStamp(String seconds, String format) {
        if (seconds == null || seconds.isEmpty() || seconds.equals("null")) {
            return 0;
        }

        if (format == null || format.isEmpty()) {
            format = "yyyy-MM-dd HH:mm:ss";
        }

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        try {
            Date date = simpleDateFormat.parse(seconds);
            return new Long(date.getTime() / 1000).intValue();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 获取当前整形时间戳
     * @return 整形时间戳
     */
    public static Integer nowIntTimestamp() {
        return new Long(System.currentTimeMillis() / 1000).intValue();
    }
}
