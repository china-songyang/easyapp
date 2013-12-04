<%@page import="com.saturn.forum.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>论坛</title>
<%@ include file="/app/includes/header.jsp"%>
</head>
<body>
	<center>
	<div>
		导航
		<% User user = (User)session.getAttribute("forumUser");
			String nickname = "";
			if(user != null) {
				nickname = user.getNickname();
				if(nickname != null){%>
					欢迎：<a href="<%=request.getContextPath()%>/forum/user/login.jsp">${forumUser.nickname}</a><a href="<%=request.getContextPath()%>/forum/user/layoutAction.do">退出</a><br>
				<%} else {%>
					<a href="<%=request.getContextPath()%>/forum/user/reg.jsp">注册</a>&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/forum/user/login.jsp">登录</a><br>
						<%}
			} else {%>
				<a href="<%=request.getContextPath()%>/forum/user/reg.jsp">注册</a>&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/forum/user/login.jsp">登录</a><br>
		<%}%>
	------------------------------------------------------------------------------------------
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/forum/message/sendMessage.do?nickname=<%=nickname%>"  style="margin-right:500px;">发帖</a>
	<br><br><br><br><br><br><br><br><br><br>
		模块讨论区
	
	</div>
	<div>
	<br><br><br><br><br><br><br><br><br><br>
	------------------------------------------------------------------------------------------
	<br>
		页底  
	</div>
	</center>
</body>
</html>