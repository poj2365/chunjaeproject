package com.niw.study.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.StudyGroup;

public enum GroupMemberDao {
	DAO;
	
	private Properties sql = new Properties();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	{
		String path = CalendarDao.class.getResource("/sql/study_sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sql.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int insertGroupMember(Connection conn, GroupMember gm) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertGroupMember"));
			pstmt.setInt(1, gm.groupNumber());
			pstmt.setString(2, gm.userId());
			pstmt.setString(3, gm.role());
			pstmt.setString(4, gm.status());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int groupMemberCount(Connection conn, String groupNo) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("groupMemberCount"));
			pstmt.setInt(1, Integer.parseInt(groupNo));
			rs=pstmt.executeQuery();
			if(rs.next()) result=rs.getInt(1);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public List<GroupMember> searchGroupMember(Connection conn, String groupNo) {
		List<GroupMember> members = new ArrayList<GroupMember>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchGroupMember"));
			pstmt.setInt(1, Integer.parseInt(groupNo));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				members.add(getGroupMember(rs));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return members;
	}
	
	GroupMember getGroupMember(ResultSet rs) throws SQLException {
		return new GroupMember(rs.getInt("group_number"), rs.getString("user_id"), rs.getString("role"), 
				rs.getString("status"), rs.getDate("join_date"));
	}

	public List<GroupMember> searchGroupMemberId(Connection conn, String userId) {
		List<GroupMember> members = new ArrayList<GroupMember>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchGroupMemberId"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				members.add(getGroupMember(rs));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return members;
	}

	public int groupMemberCountId(Connection conn, String userId) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("groupMemberCountId"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) result=rs.getInt(1);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	
}
