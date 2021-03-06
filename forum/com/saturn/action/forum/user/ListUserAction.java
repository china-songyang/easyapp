package com.saturn.action.forum.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.forum.User;

public class ListUserAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		DataGridInfo dataGridInfo = new DataGridInfo(request);
		
		User user = new User(
				request.getParameter("nickname"), 
				request.getParameter("psw"),
				request.getParameter("email"), 
				request.getParameter("state"),
				request.getParameter("statename"),
				request.getParameter("createtime")
				);
		
		ListData<User> data = User.getUsers(user, dataGridInfo.getStartPage(),
				dataGridInfo.getRows(), dataGridInfo.getSortId(), dataGridInfo.getOreder());
		
		return new JsonView(JSONUtils.getDataGridJSON
				(data.getTotal(), data.getList()));
	}
	public String requestMapping() {
		return "/forum/user/listUser.action";
	}
}
