package com.saturn.action.forum.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.Message;

public class QueryMessageAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		
		Message message = Message.get(id);
		request.setAttribute("ForumMessage", message);
		
		return new JspView("/forum/message/edit.jsp");
	}
	public String requestMapping() {
		return "/forum/message/queryMessage.action";
	}
}
