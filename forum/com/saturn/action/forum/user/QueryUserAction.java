package com.saturn.action.forum.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.User;

public class QueryUserAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		User user = User.get(id);
		request.setAttribute("user", user);
		return new JspView("/forum/user/edit.jsp");
	}
	public String requestMapping() {
		return "/forum/user/queryUser.action";
	}
}
