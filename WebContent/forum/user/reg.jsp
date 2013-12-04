<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.saturn.app.utils.DateUtils"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
			$('#addform').submit();
	}
</script>
</head>
<body>
		<form id="addform" name="addform" method="post" action="<%=request.getContextPath()%>/forum/user/addUser.do">
			<table class="table-form">
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>电子邮箱:</td>
					<td><input type="text" name="email" id="email"></input></td>
					<td>
						<div id="emailTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>昵称:</td>
					<td><input type="text" name="nickname" id="nickname"></input></td>
					<td>
						<div id="nicknameTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>密码:</td>
					<td><input type="password" name="psw" id="psw"></input></td>
					<td>
						<div id="pswTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>确认密码:</td>
					<td><input type="password" name="psw2" id="psw2"></input></td>
					<td>
						<div id="psw2Tip"></div>
					</td>
				</tr>
			</table>
			<input id="state" name="state" value="ok" type="hidden">
			<input id="statename" name="statename" value="正常" type="hidden">
			<input id="createtime" type="hidden" name="createtime" type="text" value="<%=DateUtils.getSystemTime()%>"></input>
			
			<a href="#" onclick="add()">注册</a>
		</form>
		
		<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addform"
		});

		$("#email").formValidator({
			empty : true,
			onfocus : "请正确填写邮箱，例如：tx@qq.com"
		}).regexValidator({
			regexp : "email"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});
		
		$("#psw").formValidator({
			onfocus : "密码位数在6到12之间"
		}).inputValidator({
			min : 6,
			max : 12
		});
		
		$("#psw2").formValidator({
			onfocus : "密码位数在6到12之间"
		}).inputValidator({
			min : 6,
			max : 12
		}).functionValidator({
			fun : function() {
				var psw = $('#psw').val();
				var psw2 = $('#psw2').val();
				
				this.isvalid = (psw == psw2);
			},
			onerror : "两次密码不一致"
		});
	});
</script>
</body>
</html>