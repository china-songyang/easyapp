<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="com.saturn.app.utils.DateUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加用户</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	function add() {
		$('#addForm').submit();
	}
	
	$(function() {
		$('#id').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加用户" icon="icon-add-form"
		collapsible="true" style="padding: 10px;">
		<form id="addForm" name="addForm"
			action="<%=request.getContextPath()%>/forum/user/addUserByAdmin.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>姓名:</td>
					<td><input id="nickname" name="nickname" type="text"></input></td>
					<td><div id="nameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>登录密码:</td>
					<td><input id="psw" name="psw" type="password"></input>
					</td>
					<td><div id="passwordTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>确认密码:</td>
					<td><input id="repassword" name="repassword" type="repassword"></input>
					</td>
					<td><div id="repasswordTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right">邮箱:</td>
					<td><input id="email" name="email" type="text" width="500px"></input>
					</td>
					<td><div id="emailTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" onclick="add()" class="easyui-linkbutton"
								iconCls="icon-add">添加</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div></td>
				</tr>
			</table>
			<input id="state" name="state" value="visible.true" type="hidden">
			<input id="statename" name="statename" value="正常" type="hidden">
			<input id="createtime" type="hidden" name="createtime" type="text" value="<%=DateUtils.getSystemTime()%>"></input>
			
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "addForm"
		});

		$("#id").formValidator({
			onfocus : "标识由数字、字母或者下划线组成，例如：admin"
		}).regexValidator({
			regexp : "loginId"
		}).inputValidator({
			min : 1,
			max : 50,
			onerror : "标识不超过50字符"
		}).ajaxValidator({
			url : "<%=request.getContextPath()%>/app/auth/user/isRepeatUserId.action",
			data : $('#id').val(),
			success : function(data) {
				return data == "false";
			},
			onerror : "标识已经存在"
		});

		$("#name").formValidator({
			onfocus : "用户姓名不能为空,不超过10个字符！"
		}).inputValidator({
			min : 1,
			max : 10
		});

		$("#password").formValidator({
			onfocus : "密码位数在6到12之间"
		}).inputValidator({
			min : 6,
			max : 12
		});

		$("#email").formValidator({
			empty : true,
			onfocus : "请正确填写邮箱，例如：some@163.com"
		}).regexValidator({
			regexp : "email"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});

		$("#phone").formValidator({
			empty : true,
			onfocus : "请正确填写电话(11位)，例如：13566969636"
		}).regexValidator({
			regexp : "phone"
		}).inputValidator({
			max : 100,
			onerror : "不超过100个字符"
		});
	});
</script>
</html>