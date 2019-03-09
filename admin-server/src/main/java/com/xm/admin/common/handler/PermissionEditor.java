package com.xm.admin.common.handler;

import java.beans.PropertyEditorSupport;

public class PermissionEditor extends PropertyEditorSupport {

    public void setAsText(String text) {
        setValue(parseString(text));
    }

    private String parseString(String text) {
        return null;
    }
}
