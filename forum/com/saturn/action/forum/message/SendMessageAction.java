package com.saturn.action.forum.message;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.User;

public class SendMessageAction implements IAction {
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String nickname = "";
		try {
			nickname = new String(request.getParameter("nickname").getBytes(
					"iso-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		if (nickname.equals("") || nickname == null) {
			return new JspView("/forum/user/reg.jsp");
		} else {
			String state = User.getByName(nickname).getState();
			if ("off".equals(state)) {
				return new JspView("/forum/message/off.jsp");
			}
			User user = User.getByName(nickname);
			request.getSession().setAttribute("user", user);
			return new JspView("/forum/message/send.jsp");
		}

	}

	public String requestMapping() {
		return "/forum/message/sendMessage.do";
	}
}
