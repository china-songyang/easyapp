<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>禁止发帖</title>
<%@ include file="/app/includes/header.jsp"%>
</head>
<body>
	<center>
		对不起您当前状态已被禁止发帖，请联系管理员。<br>
	<a href="<%=request.getContextPath()%>/forum/index.jsp">返回</a>
	</center>
	
</body>
</html>