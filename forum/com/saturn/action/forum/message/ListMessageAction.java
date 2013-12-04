package com.saturn.action.forum.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.forum.Message;

public class ListMessageAction implements IAction {
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		DataGridInfo dataGridInfo = new DataGridInfo(request);

		Message message = new Message(null, request.getParameter("title"),
				request.getParameter("text"), request.getParameter("creater"),
				request.getParameter("createtime"), null, null);

		ListData<Message> data = Message.getMessages(message,
				dataGridInfo.getStartPage(), dataGridInfo.getRows(),
				dataGridInfo.getSortId(), dataGridInfo.getOreder());
		
		return new JsonView(JSONUtils.getDataGridJSON(data.getTotal(),
				data.getList()));
	}

	public String requestMapping() {
		return "/forum/message/listMessage.action";
	}
}
