package com.xm.admin.common.handler;

import com.xm.admin.module.base.entity.Role;
import java.beans.PropertyEditorSupport;

public class RolesEditor extends PropertyEditorSupport {

    public void setAsText(String text) {
        setValue(parseString(text));
    }

    private Role parseString(String text) {
        return null;
    }
}
