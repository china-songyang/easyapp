<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function login() {
		$('#loginform').submit();
	}
</script>
</head>
<body>
		<form id="loginform" name="loginform" method="post" action="<%=request.getContextPath()%>/forum/user/login.do">
			用户名：<input type="text" name="nickname" id="nickname"><br>
			密	码：<input type="password" name="psw" id="psw"><br>
			<a href="#" onclick="login()">登录</a>
		</form>
</body>
</html>