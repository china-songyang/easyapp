package com.saturn.forum;

import java.sql.Connection;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;

public class Message {
	private String id;
	private String userid;
	private String title;
	private String text;
	private String creater;
	private String createtime;
	private String state;
	private String statename;
	
	private static ORMapping<Message> mapping = new ResultORMapping<Message>();
	
	public static int add(Message message) {
		return SimpleDaoTemplate.update("INSERT INTO FORUM_MESSAGE(userid, title, text, creater, createtime, state, statename) VALUES(?, ?, ?, ?, ?, ?, ?)", 
				message.getUserid(), message.getTitle(), message.getText(), message.getCreater(),
				message.getCreatetime(), message.getState(), message.getStatename());
	}
	
	public static int edit(Message vo) {
		return SimpleDaoTemplate.update("update forum_message set userid = ?, title = ?, text = ?, creater = ?, createtime = ?, state = ?, statename = ? where id = ?", 
				vo.getUserid(), vo.getTitle(), vo.getText(), 
				vo.getCreater(), vo.getCreatetime(), vo.getState(), 
				vo.getStatename(),vo.getId()
				);
	}
	public static void removes(String[] idss) {
		if(idss != null) {
			for(String id : idss) {
				remove(id);
			}
		}
	}
	
	public static int remove(final String id) { 
		return SimpleDaoTemplate.update(new ITransaction() {
			public int execute(Connection connection) {
				SimpleDaoTemplate.update(connection, "delete from forum_message where id = ?", id);
				return SimpleDaoTemplate.update(connection, "delete from forum_message where id = ?", id);
			}
		});
	}
	public static Message get(String id) {
		return SimpleDaoTemplate.queryOne("select * from forum_message where 1=1 and id='" + id +"'", 
				null, mapping, Message.class);
	}
	
	public static ListData<Message> getMessages(Message message, String start,
			String offset, String orderBy, String order){
		return SimpleDaoTemplate.query("SELECT * FROM FORUM_MESSAGE WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(message,"title","text", "creater", "createtime")
				.addCondition("ORDER BY {0} {1}",orderBy,order), 
				mapping, Message.class, start,offset);
	}
	
	public static int show(String id) {
		Message vo = get(id);
		String state = vo.getState();
		
		if("ok".equals(state)) {
			vo.setState("off");
			vo.setStatename("禁止");
		} else {
			vo.setState("ok");
			vo.setStatename("正常");
		}
		
		return edit(vo);
	}
	public Message(){
		
	}
	public Message(String userid, String title, String text, String creater, 
			String createtime, String state, String statename){
		super();
		this.userid = userid;
		this.title = title;
		this.text = text;
		this.creater = creater;
		this.createtime = createtime;
		this.state = state;
		this.statename = statename;

	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getStatename() {
		return statename;
	}
	public void setStatename(String statename) {
		this.statename = statename;
	}
	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
