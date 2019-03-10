package com.xm.admin.common.handler;

import java.beans.PropertyEditorSupport;

/**
 * 自定义方法参数绑定
 * 由于 Permission的一些属性是List<Object>,前端传过来的是List<String> 会报类型不匹配，所以置空，单独用户参数接收 @ModelAttribute
 *
 * @author xiaomalover <xiaomalover@gmail.com>
 */
public class PermissionEditor extends PropertyEditorSupport {

    @Override
    public void setAsText(String text) {
        setValue(parseString(text));
    }

    private String parseString(String text) {
        return null;
    }
}
