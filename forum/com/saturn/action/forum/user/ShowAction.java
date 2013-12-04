package com.saturn.action.forum.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.User;

public class ShowAction implements IAction{

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String show = request.getParameter("show");
	
		User.show(show);
		
		return new JspView("/forum/user/show.jsp");
	}

	public String requestMapping() {
		return "/forum/user/show.action";
	}
	
}
