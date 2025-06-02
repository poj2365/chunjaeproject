package com.niw.study.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dao.GroupChatDao;
import com.niw.study.model.dto.Message;

public enum GroupChatService {
	SERVICE;

	private GroupChatDao dao = GroupChatDao.DAO;

	public List<Message> searchGroupChat(String groupNumber) {
		Connection conn = JDBCTemplate.getConnection();
		List<Message> msgList = dao.searchGroupChat(conn, groupNumber);
		JDBCTemplate.close(conn);
		return msgList;
	}
	
	public int insertGroupChat(Message msg) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.insertGroupChat(conn,msg);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
	}
	
}
