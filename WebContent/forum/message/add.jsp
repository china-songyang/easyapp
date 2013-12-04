<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@page import="com.saturn.app.utils.DateUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加帖子</title>
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
	
	function add() {
		editor.sync();
		$('#addForm').submit();
	}
	
	$(function() {
		$('#id').focus();
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="添加帖子" icon="icon-add-form"
		collapsible="true" style="padding: 10px;">
		<form id="addForm" name="addForm"
			action="<%=request.getContextPath()%>/forum/message/addMessageByAdmin.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>标题:</td>
					<td><input id="title" name="title" type="text"></input></td>
					<td><div id="nameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>内容:</td>
					<td><textarea name="text" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"></textarea></input>
					</td>
					<td><div id="passwordTip"></div></td>
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
				<input type="hidden" id="createtime" name="createtime" value="<%=DateUtils.getSystemTime()%>">
				<input type="hidden" id="creater" name="creater" value="管理员">
				<input type="hidden" id="state" name="state" value="ok">
				<input type="hidden" id="statename" name="statename" value="正常">
				<input type="hidden" id="userid" name="userid" value="2"><br>
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