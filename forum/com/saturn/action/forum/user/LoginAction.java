package com.saturn.action.forum.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.CodeUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.forum.User;

public class LoginAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String nickname = request.getParameter("nickname");
		String psw = request.getParameter("psw");
		String url = request.getParameter("urlValue");
		
		psw = CodeUtils.encode(psw);
		
		User user = User.getByName(nickname);
		if(user != null) {
			if(user.getPsw().equals(psw)) {
				request.getSession().setAttribute("forumUser", user);
				if(url == null || url.equals("")) {
					return new JspView("/forum/index.jsp");
				} else {
					url = url.replace("%2F", "/");
					return new JspView(url);
				}
			} else {
				return new JspErrorView("密码输入错误，请重新输入！");
			}
		} else {
			return new JspErrorView("此用户不存在，请重新输入！");
		}
	}
	public String requestMapping() {
		return "/forum/user/login.do";
	}
}
