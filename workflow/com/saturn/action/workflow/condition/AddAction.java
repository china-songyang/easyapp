package com.saturn.action.workflow.condition;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.workflow.NodeCondition;

public class AddAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		NodeCondition vo = BeanUtils.getBean(request, NodeCondition.class);
		vo.setValue(request.getParameter("values"));
		
		if (NodeCondition.add(vo) == 1) {
			return new JspView("/app/workflow/condition/show.jsp?nodeId=" + vo.getNodeId());
		} else {
			return new JspErrorView("添加节点条件失败");
		}
	}

	public String requestMapping() {
		return "/app/workflow/condition/add.action";
	}
	
}
