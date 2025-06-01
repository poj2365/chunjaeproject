package com.niw.study.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dao.GroupMemberDao;
import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.StudyGroup;

public enum GroupMemberService {
	SERVICE;
	
	private GroupMemberDao dao = GroupMemberDao.DAO;
	private Connection conn = null;
	
	public int insertGroupMember(GroupMember gm) {
		conn = JDBCTemplate.getConnection();
		int result = dao.insertGroupMember(conn, gm);
		JDBCTemplate.close(conn);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		return result;
	}

	public int groupMemberCount(String groupNo) {
		conn = JDBCTemplate.getConnection();
		int result = dao.groupMemberCount(conn, groupNo);
		JDBCTemplate.close(conn);
		return result;
	}

	public List<GroupMember> searchGroupMember(String groupNo) {
		conn = JDBCTemplate.getConnection();
		List<GroupMember> members = dao.searchGroupMember(conn,groupNo);
		JDBCTemplate.close(conn);
		return members;
	}

	public List<GroupMember> searchGroupMemberId(String userId) {
		conn = JDBCTemplate.getConnection();
		List<GroupMember> members = dao.searchGroupMemberId(conn, userId);
		JDBCTemplate.close(conn);
		return members;
	}

	public int groupMemberCountId(String userId) {
		conn = JDBCTemplate.getConnection();
		int result = dao.groupMemberCountId(conn, userId);
		JDBCTemplate.close(conn);
		return result;
	}
	
	public int deleteGroupMember(String groupNumber) {
		conn = JDBCTemplate.getConnection();
		int result = dao.deleteGroupMember(conn, groupNumber);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
}

	public int deleteGroupMemberById(String userId, String groupNumber) {
		conn = JDBCTemplate.getConnection();
		int result = dao.deleteGroupMemberById(conn, userId, groupNumber);
		JDBCTemplate.close(conn);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		return result;
	}

	public int updateGroupMember(String userId, String groupNumber, String status) {
		conn = JDBCTemplate.getConnection();
		int result = dao.updateGroupMember(conn, userId, groupNumber, status);
		JDBCTemplate.close(conn);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		return result;
	}
}
