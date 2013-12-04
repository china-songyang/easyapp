package com.saturn.forum;

import java.sql.Connection;

import org.json.JSONObject;

import com.saturn.app.db.DymaticCondition;
import com.saturn.app.db.ITransaction;
import com.saturn.app.db.ListData;
import com.saturn.app.db.ORMapping;
import com.saturn.app.db.ResultORMapping;
import com.saturn.app.db.SimpleDaoTemplate;
import com.saturn.app.exception.BSException;
import com.saturn.app.utils.CodeUtils;

public class User {
	private String id;
	private String email;
	private String nickname;
	private String psw;
	private String state;
	private String statename;
	private String createtime;
	
	
	private static ORMapping<User> mapping = new ResultORMapping<User>();
	
	public static User get(String id) {
		return SimpleDaoTemplate.queryOne("select * from forum_user where 1 = 1 and id ='" + id + "'",
				 null, mapping, User.class);
	}
	
	public static User getByName(String nickname) {
		return SimpleDaoTemplate.queryOne("select * from forum_user where 1 = 1 and nickname ='" + nickname + "'",
				 null, mapping, User.class);
	}
	
	public static int add(User user) {
		if (getByName(user.getNickname()) != null) {
			throw new BSException("用户名：" + user.getNickname() + " 重复，请重新输入");
		}

		user.setPsw(CodeUtils.encode(user.getPsw()));
		return SimpleDaoTemplate.update("insert into forum_user(email, nickname, psw, state, statename, createtime) values(?, ?, ?, ?, ?, ?)", 
				user.getEmail(),user.getNickname(), user.getPsw(),user.getState(),user.getStatename(), user.getCreatetime());
	}
	
	public static int edit(User user) {
		return SimpleDaoTemplate.update("UPDATE FORUM_USER SET nickname = ?, email = ?, state = ?, statename = ? where id = ?",
				user.getNickname(), user.getEmail(), user.getState(), user.getStatename(), user.getId());
	}
	
	public static int remove(final String id) {
		return SimpleDaoTemplate.update(new ITransaction() {
			
			public int execute(Connection connection) {
				SimpleDaoTemplate.update(connection, "DELETE FROM FORUM_USER WHERE id = ?", id);
				return SimpleDaoTemplate.update(connection, "DELETE FROM FORUM_USER WHERE id = ?", id);
			}
		});
	}
	
	public static void removes(String [] ids) {
		if(ids != null) {
			for(String id : ids) {
				remove(id);
			}
		}
	}
	
	public static ListData<User> getUsers(User user, String start, String offset, String orderBy, String order){
		return SimpleDaoTemplate.query("SELECT * FROM FORUM_USER WHERE 1 = 1",
				new DymaticCondition().addSimpleCondition(user,"email","nickname")
				.addCondition("ORDER BY {0} {1}",orderBy,order), mapping, User.class, start,offset);
	}
	
	public static int show(String id) {
		User vo = get(id);
		String state = vo.getState();
		if("ok".equals(state)) {
			vo.setState("off");
			vo.setStatename("禁用");
		} else {
			vo.setState("ok");
			vo.setStatename("正常");
		}
		
		return edit(vo);
	}
	
	public User() {
		
	}
	
	public User(String nickname,String psw, String email, String state, String statename, String createtime){
		this.email = email;
		this.nickname = nickname;
		this.psw = psw;
		this.state = state;
		this.statename = statename;
		this.createtime = createtime;
	}
	
	
	public String getStatename() {
		return statename;
	}

	public void setStatename(String statename) {
		this.statename = statename;
	}

	public String getCreatetime() {
		return createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPsw() {
		return psw;
	}
	public void setPsw(String psw) {
		this.psw = psw;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	@Override
	public String toString() {
		return new JSONObject(this).toString();
	}
}
