<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改帖子信息</title>
<%@ include file="/app/includes/header.jsp"%>
<%@ include file="/app/includes/kindEditor.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidator.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/app/js/formValidatorRegex.js"></script>

<script type="text/javascript">
	function edit() {
		editor.sync();
		$('#editForm').submit();
	}
	
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="text"]', {
			cssPath : '<%=request.getContextPath()%>/app/js/kindEditor/plugins/code/prettify.css',
			fileManagerJson : '<%=request.getContextPath()%>/app/system/upload/fileManager.action',
			uploadJson : '<%=request.getContextPath()%>/app/system/upload/upload.action',
			allowFileManager : true
		});
	});
	
	$(function() {
		$('#name').focus();
		
		$('#state').combobox({
			value : "${ForumMessage.state}",
			onSelect:function(record){
				$('#statename').val(record.text);
		    }
		});
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改帖子信息"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">

		<form id="editForm"
			action="<%=request.getContextPath()%>/forum/message/updateMessage.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>标题:</td>
					<td><input id="title" name="title" type="text"
						value="${ForumMessage.title}"></input>
					</td>
					<td>
						<div id="titleTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right">内容:</td>
					<td>
						<textarea name="text" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;">${ForumMessage.text}</textarea>
					</td>
					<td>
						<div id="textTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right">创建者:</td>
					<td><input id="creater" name="creater" type="text"
						value="${ForumMessage.creater}"></input>
					</td>
					<td>
						<div id="createrTip"></div>
					</td>
				</tr>
				<tr>
					<td style="text-align:right">显示:</td>
					<td><select id="state" class="easyui-combobox"
						name="state" url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=messageState" valueField="id"
						textField="text" editable="false"></select></td>
					<td><div id="stateTip"></div></td>
				</tr>
				<tr>
					<td colspan="3">
						<div style="padding: 10px;">
							<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
								onclick="edit()">确定</a> <a href="javascript:history.back(-1)"
								class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
						</div>
					</td>
				</tr>
			</table>
			<input type="hidden" id="id" name="id" value="${ForumMessage.id}">
			<input type="hidden" id="createtime" name="createtime" value="${ForumMessage.createtime}">
			<input type="hidden" id="userid" name="userid"  value="${ForumMessage.userid}">
			<input type="hidden" id="statename" name="statename" type="text"  value="${ForumMessage.statename}">
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
		});

		$("#id").formValidator({
			onfocus : "标识由数字、字母或者下划线组成，例如：admin"
		}).regexValidator({
			regexp : "loginId"
		});

		$("#name").formValidator({
			onfocus : "用户姓名不能为空,不超过10个字符！"
		}).inputValidator({
			min : 1,
			max : 10
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