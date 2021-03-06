<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改列</title>
<%@ include file="/app/includes/header.jsp"%>
<%
	String tableId = request.getParameter("tableId");
%>
<script type="text/javascript">
	function edit() {
		var type = $('#type').combogrid('getValue');
		
		if (type == "") {
			alert("列类型不能为空!");
			return;
		}
		
		$('#editForm').submit();
	}
	
	$(function() {
		$('#name').focus();
		
		$('#type').combobox({
			value : "${tablecolumn.type}",
			width : 256,
			onSelect:function(record){
				var value = record.text;
				
				$('#typeName').val(value);
				
				if (value == "int") {
					$('#length').val('11');
				}
		    }
		});
	});
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="修改列"
		icon="icon-edit-form" collapsible="true" style="padding: 10px;">

		<form id="editForm"
			action="<%=request.getContextPath()%>/app/system/easyform/tablecolumn/update.action"
			method="post">
			<table class="table-form">
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>列名:</td>
					<td><input id="name" name="name" type="text" value="${tablecolumn.name}" readonly="readonly"></input></td>
					<td><div id="nameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>中文名:</td>
					<td><input id="showName" name="showName" type="text" value="${tablecolumn.showName}"></input></td>
					<td><div id="showNameTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>类型:</td>
					<td><select id="type" class="easyui-combobox"
								name="type" url="<%=request.getContextPath()%>/app/system/dict/listDictByType.action?type=column.type" valueField="id"
								textField="text" editable="false"></select></td>
					<td><div id="typeTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right"><span style="color: red">*</span>长度</td>
					<td><input id="length" name="length" value="50" value="${tablecolumn.length}"></input></td>
					<td><div id="lengthTip"></div></td>
				</tr>
				<tr>
					<td style="text-align:right">默认值:</td>
					<td><input id="defaultValue" name="defaultValue" value="${tablecolumn.defaultValue}"></input></td>
					<td><div id="defaultValueTip"></div></td>
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
			<input id="id" name="id" type="hidden" value="${tablecolumn.id}"></input>
			<input id="typeName" type="hidden" name="typeName" type="text" value="${tablecolumn.typeName}"></input>
			<input id="tableId" type="hidden" name="tableId" type="text" value="<%=tableId%>"></input>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.formValidator.initConfig({
			formid : "editForm"
		});

		$("#showName").formValidator({
			onfocus : "中文名称不能为空,不超过20个字符！"
		}).inputValidator({
			min : 1,
			max : 20
		});
		
		$("#length").formValidator({
			onfocus : "请输出数字"
		}).regexValidator({
			regexp : "integer"
		}).inputValidator({
			min : 1,
			max : 50,
			onerror : "长度不超过50字符"
		});
	});
</script>
</html>