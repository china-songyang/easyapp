package com.saturn.action.forum.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.Message;

public class UpdateMessage implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Message vo = BeanUtils.getBean(request, Message.class);
		if(Message.edit(vo) == 1) {
			return new JspView("/forum/message/show.jsp");
		} else {
			return null;
		}
	}
	public String requestMapping() {
		return "/forum/message/updateMessage.action";
	}
}
