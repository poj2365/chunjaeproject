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
import com.niw.study.model.dto.GroupRequest;

public enum GroupRequestDao {
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

	public int insertGroupRequest(Connection conn, GroupRequest gr) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertGroupRequest"));
			pstmt.setString(1, gr.userId());
			pstmt.setString(2, gr.userName());
			pstmt.setString(3, gr.userAddress());
			pstmt.setString(4, gr.userPhone());
			pstmt.setString(5, gr.reason());
			pstmt.setInt(6, gr.groupNumber());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public GroupRequest searchGroupRequest(Connection conn, GroupRequest gr) {
		GroupRequest groupRequest = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchGroupRequest"));
			pstmt.setString(1, gr.userId());
			pstmt.setInt(2, gr.groupNumber());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				groupRequest=getGroupRequest(rs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return groupRequest;
	}
	
	GroupRequest getGroupRequest(ResultSet rs) throws SQLException {
		return new GroupRequest(rs.getInt("request_id"), rs.getString("user_id"), rs.getString("user_name"), rs.getString("user_address"),
				rs.getString("user_phone"), rs.getString("reason"), rs.getInt("group_number"), rs.getDate("request_date"),
				rs.getString("status"));
	}

	public List<GroupRequest> searchGroupRequestAll(Connection conn, String groupNumber) {
		List<GroupRequest> groupRequests = new ArrayList<GroupRequest>();
			try {
				pstmt=conn.prepareStatement(sql.getProperty("searchGroupRequestAll"));
				pstmt.setInt(1, Integer.parseInt(groupNumber));
				rs=pstmt.executeQuery();
				if(rs.next()) {
					groupRequests.add(getGroupRequest(rs));
				}
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(rs);
				JDBCTemplate.close(pstmt);
			}
			return groupRequests;
		}

	public int updateGroupRequest(Connection conn, String userId, String groupNumber, String status) {
			int result = 0;
			try {
				pstmt=conn.prepareStatement(sql.getProperty("updateGroupRequest"));
				System.out.println(status+ " : "+userId+":"+groupNumber);
				pstmt.setString(1, status);
				pstmt.setString(2, userId);
				pstmt.setInt(3, Integer.parseInt(groupNumber));
				result=pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(rs);
				JDBCTemplate.close(pstmt);
			}
			return result;
		}
}
