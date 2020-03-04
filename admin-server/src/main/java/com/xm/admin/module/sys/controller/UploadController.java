package com.xm.admin.module.sys.controller;

import cn.hutool.json.JSONObject;
import com.xm.admin.common.utils.ImageUtil;
import com.xm.common.utils.ResultUtil;
import com.xm.common.vo.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.DigestUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

/**
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@Slf4j
@RestController
@RequestMapping("/skeleton/upload")
public class UploadController {

    @Value("${upload.rootPath}")
    private String imagePath;

    @Value("${upload.domain}")
    private String imageDomain;

    @PostMapping("/articleThumb")
    public Result<Object> uploadArticleThumb(@RequestParam(required = false) MultipartFile file) {
        return doUpload(file, "articleThumb");
    }

    @PostMapping("/common")
    public Result<Object> upload(
            @RequestParam(required = false) MultipartFile file,
            @RequestParam String folder
    ) {
        return doUpload(file, folder);
    }

    private Result<Object> doUpload(MultipartFile file, String folder) {
        try {

            String rootPath = imagePath;
            String savePath = rootPath + File.separator + folder;
            if (!ImageUtil.initDir(savePath)) {
                return new ResultUtil<>().setErrorMsg("创建上传目录失败");
            }
            String fName = file.getOriginalFilename();
            if (ObjectUtils.isEmpty(fName)) {
                return new ResultUtil<>().setErrorMsg("读取文件失败");
            }
            String suffix = fName.substring(fName.lastIndexOf(".") + 1);
            InputStream inputStream = file.getInputStream();

            //创建一个文件输出流
            String fileName = DigestUtils.md5DigestAsHex(fName.getBytes()) + "." + suffix;
            FileOutputStream fos = new FileOutputStream(savePath + File.separator + fileName);

            //创建一个缓冲区
            byte[] buffer = new byte[1024];
            //判断输入流中的数据是否已经读完的标识
            int length;
            //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
            while ((length = inputStream.read(buffer)) > 0) {
                //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                fos.write(buffer, 0, length);
            }
            //关闭输入流
            inputStream.close();
            //关闭输出流
            fos.close();

            String fullUrl = imageDomain + folder + "/" + fileName;

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("fullUrl", fullUrl);
            jsonObject.put("relative", folder + "/" + fileName);
            return new ResultUtil<>().setData(jsonObject);
        } catch (Exception e) {
            log.error(e.toString());
            return new ResultUtil<>().setErrorMsg(e.toString());
        }
    }

    @GetMapping(value = "/getDomain")
    public Result getImageDomain() {
        return new ResultUtil<>().setData(imageDomain);
    }
}
