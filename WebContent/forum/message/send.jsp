<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>发表帖子</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidatorRegex.js"></script>

<%@ include file="/app/includes/kindEditor.jsp" %>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	KindEditor.ready(function(K) {
			editor = K.create('textarea[name="text"]', {
				cssPath : '<%=request.getContextPath()%>/app/js/kindEditor/plugins/code/prettify.css',
				fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action',
				uploadJson : '<%=request.getContextPath()%>/app/system/upload/upload.action',
				allowFileManager : true
			});
		});
		
	function send() {
		editor.sync();
		$('#sendform').submit();
	}
	</script>
</head>
<body>
	<center>
		<a href="<%=request.getContextPath()%>/forum/index.jsp">返回</a>
		<br><br><br>
		<div>
			<form id="sendform" name="sendform" action="<%=request.getContextPath()%>/forum/message/addMessage.do" method="post">
				<div style="margin-left:-500px;">标题：<input type="text" id="title" name="title" /></div><br>
				<textarea name="text" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"></textarea>
				<input type="hidden" id="createtime" name="createtime" value="<%=DateUtils.getSystemTime()%>">
				<input type="hidden" id="creater" name="creater" value="${user.nickname}">
				<input type="hidden" id="state" name="state" value="ok">
				<input type="hidden" id="statename" name="statename" value="正常">
				<input type="hidden" id="userid" name="userid" value="${user.id}"><br>
				<div style="margin-right:670px;"><a href="#" onclick="send()">发表</a></div>
			</form>
		</div>
	</center>
</body>
</html>