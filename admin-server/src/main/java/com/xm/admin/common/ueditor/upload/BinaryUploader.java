package com.xm.admin.common.ueditor.upload;

import com.xm.admin.common.ueditor.PathFormat;
import com.xm.admin.common.ueditor.define.AppInfo;
import com.xm.admin.common.ueditor.define.BaseState;
import com.xm.admin.common.ueditor.define.FileType;
import com.xm.admin.common.ueditor.define.State;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Slf4j
public class BinaryUploader {

    public static State save(HttpServletRequest request, Map<String, Object> conf) {

        boolean isAjaxUpload = request.getHeader("X_Requested_With") != null;

        if (!ServletFileUpload.isMultipartContent(request)) {
            return new BaseState(false, AppInfo.NOT_MULTIPART_CONTENT);
        }

        ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());

        if (isAjaxUpload) {
            upload.setHeaderEncoding("UTF-8");
        }

        try {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            MultipartFile file = multipartRequest.getFile("upfile");

            String savePath = (String) conf.get("savePath");
            String localSavePathPrefix = (String) conf.get("localSavePathPrefix");
            String originFileName = file.getOriginalFilename();
            String suffix = FileType.getSuffixByFilename(originFileName);

            originFileName = originFileName.substring(0, originFileName.length() - suffix.length());
            savePath = savePath + suffix;

            long maxSize = (Long) conf.get("maxSize");

            if (!validType(suffix, (String[]) conf.get("allowFiles"))) {
                return new BaseState(false, AppInfo.NOT_ALLOW_FILE_TYPE);
            }
            savePath = PathFormat.parse(savePath, originFileName);
            localSavePathPrefix = localSavePathPrefix + savePath;
            String physicalPath = localSavePathPrefix;
            log.info("BinaryUploader physicalPath:{},savePath:{}", localSavePathPrefix, savePath);
            InputStream is = file.getInputStream();

            //在此处调用ftp的上传图片的方法将图片上传到文件服务器
            String path = physicalPath.substring(0, physicalPath.lastIndexOf("/"));
            String picName = physicalPath.substring(physicalPath.lastIndexOf("/") + 1);
            State storageState = StorageManager.saveFileByInputStream(request, is, path, picName, maxSize);

            is.close();

            if (storageState.isSuccess()) {
                storageState.putInfo("type", suffix);
                storageState.putInfo("original", originFileName + suffix);
                storageState.putInfo("url", PathFormat.format(savePath));
            }

            return storageState;
        } catch (Exception e) {
            return new BaseState(false, AppInfo.PARSE_REQUEST_ERROR);
        }
    }

    private static boolean validType(String type, String[] allowTypes) {
        List<String> list = Arrays.asList(allowTypes);

        return list.contains(type);
    }
}
