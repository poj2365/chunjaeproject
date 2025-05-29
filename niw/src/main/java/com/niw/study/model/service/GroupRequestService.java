package com.niw.study.model.service;

import java.sql.Connection;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dao.GroupRequestDao;
import com.niw.study.model.dto.GroupRequest;

public enum GroupRequestService {
	SERVICE;
	
	private GroupRequestDao dao = GroupRequestDao.DAO;
	private Connection conn = null;
	
	
	public int insertGroupRequest(GroupRequest gr) {
		conn = JDBCTemplate.getConnection();
		int result = dao.insertGroupRequest(conn, gr);
		JDBCTemplate.close(conn);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		return result;
	}


	public GroupRequest searchGroupRequest(GroupRequest gr) {
		conn = JDBCTemplate.getConnection();
		GroupRequest groupRequest = dao.searchGroupRequest(conn, gr);
		JDBCTemplate.close(conn);
		return groupRequest;
	}
	
	
}
