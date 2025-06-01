package com.niw.study.model.service;

import java.sql.Connection;
import java.util.List;

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
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
	}


	public GroupRequest searchGroupRequest(GroupRequest gr) {
		conn = JDBCTemplate.getConnection();
		GroupRequest groupRequest = dao.searchGroupRequest(conn, gr);
		JDBCTemplate.close(conn);
		return groupRequest;
	}

	public List<GroupRequest> searchGroupRequestAll(String groupNumber) {
		conn = JDBCTemplate.getConnection();
		List<GroupRequest> groupRequests = dao.searchGroupRequestAll(conn, groupNumber);
		JDBCTemplate.close(conn);
		return groupRequests;
	}


	public int updateGroupRequest(String userId, String groupNumber, String status) {
		conn = JDBCTemplate.getConnection();
		int result = dao.updateGroupRequest(conn, userId, groupNumber, status);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
	}
	
	
}
