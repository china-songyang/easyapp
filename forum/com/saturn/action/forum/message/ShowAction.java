package com.saturn.action.forum.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.Message;

public class ShowAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String show = request.getParameter("show");
		
		Message.show(show);
		return new JspView("/forum/message/show.jsp");
	}
	
	public String requestMapping() {
		return "/forum/message/show.action";
	}
}
