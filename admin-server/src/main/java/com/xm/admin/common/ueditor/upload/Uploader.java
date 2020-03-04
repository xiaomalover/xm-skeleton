package com.xm.admin.common.ueditor.upload;

import com.xm.admin.common.ueditor.define.State;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class Uploader {
    private HttpServletRequest request;
    private Map<String, Object> conf;

    public Uploader(HttpServletRequest request, Map<String, Object> conf) {
        this.request = request;
        this.conf = conf;
    }

    public final State doExec() {
        String filedName = (String) this.conf.get("fieldName");
        State state;

        if ("true".equals(this.conf.get("isBase64"))) {
            state = Base64Uploader.save(this.request.getParameter(filedName),
                    this.conf);
        } else {
            state = BinaryUploader.save(this.request, this.conf);
        }

        return state;
    }
}
