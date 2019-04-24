package com.xm.admin.module.sys.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import com.xm.admin.common.ueditor.ActionEnter;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
@RequestMapping("/skeleton/ueditor")
public class UeditorController {

	@RequestMapping(value = "/exec")
	public String exec(HttpServletRequest request) throws UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");
		String rootPath = request.getRealPath("/");
		return new ActionEnter( request, rootPath ).exec();
	}

}
