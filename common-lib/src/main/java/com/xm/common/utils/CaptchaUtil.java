package com.xm.common.utils;

import com.alibaba.fastjson.JSONObject;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Base64;
import java.util.Random;

/**
 * 随机字符验证码生成工具类
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@SuppressWarnings("unused")
public class CaptchaUtil {

    /**
     * 图片的宽度
     */
    private int width = 160;
    /**
     * 图片的高度
     */
    private int height = 40;
    /**
     * 验证码字符个数
     */
    private int codeCount = 4;
    /**
     * 验证码干扰线数
     */
    private int lineCount = 20;
    /**
     * 验证码
     */
    private String code = null;
    /**
     * 验证码图片Buffer
     */
    private BufferedImage buffImg = null;

    private Random random = new Random();

    public CaptchaUtil() {
        createImage();
    }

    public CaptchaUtil(int width, int height) {
        this.width = width;
        this.height = height;
        createImage();
    }

    public CaptchaUtil(int width, int height, int codeCount) {
        this.width = width;
        this.height = height;
        this.codeCount = codeCount;
        createImage();
    }

    public CaptchaUtil(int width, int height, int codeCount, int lineCount) {
        this.width = width;
        this.height = height;
        this.codeCount = codeCount;
        this.lineCount = lineCount;
        createImage();
    }

    public CaptchaUtil(int width, int height, int codeCount, int lineCount, String code) {
        this.width = width;
        this.height = height;
        this.codeCount = codeCount;
        this.lineCount = lineCount;
        createImage(code);
    }

    /**
     * 生成图片
     */
    private void createImage() {
        String code = randomStr(codeCount); // 得到随机字符
        doCreate(code);
    }

    /**
     * 生成指定字符图片
     */
    private void createImage(String code) {
        doCreate(code);
    }

    /**
     * 生成验证码图片
     *
     * @param code 验证码
     */
    private void doCreate(String code) {
        // 字体的宽度
        int fontWidth = width / codeCount;
        // 字体的高度
        int fontHeight = height - 5;
        int codeY = height - 8;

        // 图像buffer
        buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = buffImg.getGraphics();
        //Graphics2D g = buffImg.createGraphics();
        // 设置背景色
        g.setColor(getRandColor(200, 250));
        g.fillRect(0, 0, width, height);

        // 设置字体
        //Font font1 = getFont(fontHeight);
        Font font = new Font("Fixedsys", Font.BOLD, fontHeight);
        g.setFont(font);

        // 设置干扰线
        setSomeLines(g);

        // 添加噪点
        float yawpRate = 0.01f;// 噪声率
        int area = (int) (yawpRate * width * height);
        for (int i = 0; i < area; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);

            buffImg.setRGB(x, y, random.nextInt(255));
        }

        this.code = code;
        for (int i = 0; i < codeCount; i++) {
            String strRand = code.substring(i, i + 1);
            g.setColor(getRandColor(1, 255));
            // g.drawString(a,x,y);
            // a为要画出来的东西，x和y表示要画的东西最左侧字符的基线位于此图形上下文坐标系的 (x, y) 位置处
            g.drawString(strRand, i * fontWidth + 3, codeY);
        }
    }

    private void setSomeLines(Graphics g) {
        for (int i = 0; i < lineCount; i++) {
            int xs = random.nextInt(width);
            int ys = random.nextInt(height);
            int xe = xs + random.nextInt(width);
            int ye = ys + random.nextInt(height);
            g.setColor(getRandColor(1, 255));
            g.drawLine(xs, ys, xe, ye);
        }
    }

    /**
     * 得到随机字符
     *
     * @param length 随机串长度
     * @return 指定长度的随机串
     */
    public String randomStr(int length) {
        String basicString = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
        StringBuilder builder = new StringBuilder();
        int len = basicString.length() - 1;
        double r;
        for (int i = 0; i < length; i++) {
            r = (Math.random()) * len;
            builder.append(basicString.charAt((int) r));
        }
        return builder.toString();
    }

    /**
     * 得到随机颜色
     *
     * @param fc 范围
     * @param bc 范围
     * @return 颜色
     */
    private Color getRandColor(int fc, int bc) {
        // 给定范围获得随机颜色
        if (fc > 255) {
            fc = 255;
        }
        if (bc > 255) {
            bc = 255;
        }
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    /**
     * 产生随机字体
     */
    private Font getFont(int size) {
        Random random = new Random();
        Font[] font = new Font[5];
        font[0] = new Font("Ravie", Font.PLAIN, size);
        font[1] = new Font("Antique Olive Compact", Font.PLAIN, size);
        font[2] = new Font("Fixedsys", Font.PLAIN, size);
        font[3] = new Font("Wide Latin", Font.PLAIN, size);
        font[4] = new Font("Gill Sans Ultra Bold", Font.PLAIN, size);
        return font[random.nextInt(5)];
    }

    // 扭曲方法
    private void shear(Graphics g, int w1, int h1, Color color) {
        shearX(g, w1, h1, color);
        shearY(g, w1, h1, color);
    }

    private void shearX(Graphics g, int w1, int h1, Color color) {

        int period = random.nextInt(2);

        int frames = 1;
        int phase = random.nextInt(2);

        for (int i = 0; i < h1; i++) {
            double d = (double) (period >> 1)
                    * Math.sin((double) i / (double) period
                    + (6.2831853071795862D * (double) phase)
                    / (double) frames);
            g.copyArea(0, i, w1, 1, (int) d, 0);

            g.setColor(color);
            g.drawLine((int) d, i, 0, i);
            g.drawLine((int) d + w1, i, w1, i);
        }

    }

    private void shearY(Graphics g, int w1, int h1, Color color) {

        int period = random.nextInt(40) + 10; // 50;

        int frames = 20;
        int phase = 7;
        for (int i = 0; i < w1; i++) {
            double d = (double) (period >> 1)
                    * Math.sin((double) i / (double) period
                    + (6.2831853071795862D * (double) phase)
                    / (double) frames);
            g.copyArea(i, 0, 1, h1, 0, (int) d);

            g.setColor(color);
            g.drawLine(i, (int) d, i, 0);
            g.drawLine(i, (int) d + h1, i, h1);

        }

    }

    public void write(OutputStream sos) throws IOException {
        ImageIO.write(buffImg, "png", sos);
        sos.close();
    }

    public JSONObject getBase64Captcha() {

        ByteArrayOutputStream baos = new ByteArrayOutputStream();//io流
        try {
            //从缓冲区，把图片写入到base64 字符串
            ImageIO.write(buffImg, "png", baos);//写入流中
            baos.close();
            byte[] bytes = baos.toByteArray();//转换成字节
            String png_base64 = new String(Base64.getEncoder().encode(bytes));//转换成base64串
            png_base64 = png_base64.replaceAll("\n", "").replaceAll("\r", "");

            //返回成功数据
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", true);
            jsonObject.put("message", "获取验证码成功");
            jsonObject.put("data", "data:image/png;base64," + png_base64);
            return jsonObject;
        } catch (IOException e) {
            //返回失败数据
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("status", false);
            jsonObject.put("message", "获取验证码失败");
            return jsonObject;
        }
    }

    public BufferedImage getBuffImg() {
        return buffImg;
    }

    public String getCode() {
        return code.toLowerCase();
    }
}
