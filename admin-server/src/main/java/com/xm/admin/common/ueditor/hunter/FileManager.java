package com.xm.admin.common.ueditor.hunter;

import com.xm.admin.common.ueditor.PathFormat;
import com.xm.admin.common.ueditor.define.AppInfo;
import com.xm.admin.common.ueditor.define.BaseState;
import com.xm.admin.common.ueditor.define.MultiState;
import com.xm.admin.common.ueditor.define.State;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

public class FileManager {

    private String dir;
    private String rootPath;
    private String[] allowFiles;
    private int count;
    private String imageUrlPrefix;
    private String localSavePathPrefix;

    public FileManager(Map<String, Object> conf) {

        this.rootPath = (String) conf.get("rootPath");
        //this.dir = this.rootPath + conf.get("dir");
        this.dir = (String) conf.get("localSavePathPrefix") + conf.get("dir");
        this.allowFiles = this.getAllowFiles(conf.get("allowFiles"));
        this.count = (Integer) conf.get("count");
        this.imageUrlPrefix = (String) conf.get("imageUrlPrefix");
        this.localSavePathPrefix = (String) conf.get("localSavePathPrefix");
    }

    public State listFile(int index) {

        File dir = new File(this.dir);
        State state;

        if (!dir.exists()) {
            return new BaseState(false, AppInfo.NOT_EXIST);
        }

        if (!dir.isDirectory()) {
            return new BaseState(false, AppInfo.NOT_DIRECTORY);
        }

        Collection<File> list = FileUtils.listFiles(dir, this.allowFiles, true);

        if (index < 0 || index > list.size()) {
            state = new MultiState(true);
        } else {
            Object[] fileList = Arrays.copyOfRange(list.toArray(), index, index + this.count);
            state = this.getState(fileList);
        }

        state.putInfo("start", index);
        state.putInfo("total", list.size());

        return state;

    }

    private State getState(Object[] files) {

        MultiState state = new MultiState(true);
        BaseState fileState;

        File file;

        for (Object obj : files) {
            if (obj == null) {
                break;
            }
            file = (File) obj;
            fileState = new BaseState(true);
            fileState.putInfo("url", PathFormat.format(this.getPath(file)).replace(PathFormat.format(this.localSavePathPrefix), this.imageUrlPrefix));
            state.addState(fileState);
        }

        return state;

    }

    private String getPath(File file) {

        String path = file.getAbsolutePath();

        return path.replace(this.rootPath, "/");

    }

    private String[] getAllowFiles(Object fileExt) {

        String[] exts;
        String ext;

        if (fileExt == null) {
            return new String[0];
        }

        exts = (String[]) fileExt;

        for (int i = 0, len = exts.length; i < len; i++) {

            ext = exts[i];
            exts[i] = ext.replace(".", "");

        }

        return exts;

    }

}
