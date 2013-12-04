package com.saturn.action.forum.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.User;

public class LayoutAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		User user = (User)request.getSession().getAttribute("forumUser");
		String url = request.getParameter("urlValue");
		
		if(user != null) {
			request.getSession().removeAttribute("forumUser");
		}
		
		if(url == null || url.equals("")) {
			return new JspView("/forum/index.jsp");
		} else {
			url = url.replace("%2F", "/");
			return new JspView(url);
		}
	}
	public String requestMapping() {
		return "/forum/user/layoutAction.do";
	}
}
