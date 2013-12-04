package com.saturn.action.forum.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.User;

public class AddUserByAdminAction implements IAction{

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		User vo = BeanUtils.getBean(request, User.class);
		
		if(User.add(vo) == 1) {
			return new JspView("/forum/user/show.jsp");
		} else {
			return new JspErrorView("添加用户失败！");
		}
	}

	public String requestMapping() {
		return "/forum/user/addUserByAdmin.action";
	}
	
}
