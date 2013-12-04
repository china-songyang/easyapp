package com.saturn.action.forum.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.Message;

public class AddMessageAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Message message = BeanUtils.getBean(request, Message.class);
		
		if(Message.add(message) ==1){
			return new JspView("/forum/index.jsp");
		} else {
			return new JspErrorView("发帖不成功");
		}
		
	}
	
	public String requestMapping() {
		return "/forum/message/addMessage.do";
	}
}
