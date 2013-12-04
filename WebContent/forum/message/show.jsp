<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帖子信息</title>
<%@ include file="/app/includes/header.jsp"%>
<script type="text/javascript">
	$(function() {
		$('#queryTable').datagrid({
			title : '帖子列表',
			iconCls : 'icon-datalist',
			nowrap : false,
			striped : true, //数据条纹显示
			collapsible : true,
			singleSelect : false,//只能选一行
			url : '<%=request.getContextPath()%>/forum/message/listMessage.action',
			sortName : 'id',
			sortOrder : 'desc',
			remoteSort : true,
			idField : 'id',//唯一标识列
			frozenColumns : [ [ {//不可被删除的列
				field : 'ck',
				checkbox : true
			}, {
				title : '标识',
				field : 'id',
				width : 60,
				sortable : true
			} ] ],
			columns : [ [  {
				field : 'creater',
				title : '创建者',
				width : 80	
			}, {
				field : 'title',
				title : '标题',
				width : 180,
				sortable : true
			}, {
				field : 'text',
				title : '内容',
				width : 500,
				sortable : true
			},{
				field : 'statename',
				title : '状态',
				width : 80,
				sortable : true,
				formatter : function(value, rec) {
					return '<span><a href="<%=request.getContextPath()%>/forum/message/show.action?show=' + rec.id + '">' + rec.statename +'</a>';
				}
			},  {
				field : 'createtime',
				title : '创建时间',
				width : 120	
			}, {
				field : 'opt',
				title : '操作', 
				align : 'center',
				rowspan : 2,
				width : 100,
				formatter : function(value, rec) {
						return '<span><a href="#" onclick="editVO(\'' + rec.id + '\');"><img src="<%=request.getContextPath()%>/app/themes/icons/edit.png" width="16" height="16" border="0" /></a>'+
						'&nbsp&nbsp<a href="#" onclick="deleteVO(\'' + rec.id + '\');"><img src="<%=request.getContextPath()%>/app/themes/icons/cancel.png" width="14" height="14" border="0" /></a></span>';
				}
			} ] ],
			pagination : true,
			rownumbers : true,
			toolbar : [ {
				id : 'btnadd',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					window.location.href='<%=request.getContextPath()%>/forum/message/add.jsp';
					return false;//解决IE6的不跳转的bug
				}
			}, {
				id : 'btnedit',
				text : '编辑',
				iconCls : 'icon-edit',
				handler : function() {
					var rows = $('#queryTable').datagrid('getSelections');
					if (rows.length == 0) {
						$.messager.alert('提示','请选择修改项','info');
						return;
					} else if (rows.length > 1) {
						$.messager.alert('提示','只能选择一项','info');
						return;
					}
					editVO(rows[0].id);
					//window.location.href='<%=request.getContextPath()%>/forum/user/queryUser.action?id='+rows[0].id;
					return false;
				}
			},{
				id : 'btndelete',
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					var rows = $('#queryTable').datagrid('getSelections');
					if (rows.length == 0) {
						$.messager.alert('提示','请选择删除项','info');
						return;
					} 
					
					var ids = [];
					for(var i=0;i<rows.length;i++){
						ids.push(rows[i].id);
					}

					$.messager.confirm('确认删除项', '确认删除该选项', function(result){
						if (result){
							window.location.href='<%=request.getContextPath()%>/forum/message/deleteMessage.action?ids='+ids.join('__');
						}
					});
					return false;
				}
			}]
		});
	});
	
	function deleteVO(id){
		$.messager.confirm('确认删除项', '确认删除该选项', function(result){
			if (result){
				window.location.href='<%=request.getContextPath()%>/forum/message/deleteMessage.action?ids=' + id;
			}
		});
		return false;
	}
	
	function editVO(id){
		window.location.href='<%=request.getContextPath()%>/forum/message/queryMessage.action?id='+ id;
		return false;
	}
	
	function queryVO() {
		$('#queryTable').datagrid({
			queryParams : {
				title : $('#title').val(),
				text : $('#text').val(),
				creater: $('#creater').val()
			}});
		$('#queryTable').datagrid("load");
	}
	
	function clearQueryForm() {
		$('#queryForm').form('clear');
	}
</script>
</head>
<body>
	<div id="panel" class="easyui-panel" title="查询条件"
		icon="icon-query-form" collapsible="true"
		style="padding: 10px;">

		<form id="queryForm" method="post">
			<label for="title">标题:</label>
			<input id="title" type="text" name="title"></input>
			<label for="text">内容:</label>
			<input id="text" type="text" name="text"></input>
			<label for="creater">创建者:</label>
			<input id="creater" type="text" name="creater"></input>
			<div style="padding: 10px;" >
				<a href="#" class="easyui-linkbutton" onclick="queryVO();" iconCls="icon-search">确定</a>
				<a href="#" class="easyui-linkbutton" onclick="clearQueryForm();" iconCls="icon-cancel">取消</a>
			</div>
		</form>
	</div>
	<table id="queryTable"></table>
</body>
</html>