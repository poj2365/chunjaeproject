package com.niw.study.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dto.StudyGroup;

public enum StudyGroupDao {
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

	public List<StudyGroup> searchStudyGroupAll(Connection conn, int cPage, int numPerpage) {
		List<StudyGroup> studygroups = new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupAll"));
			pstmt.setInt(1, (cPage-1)*numPerpage+1);
			pstmt.setInt(2, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				studygroups.add(getStudygroup(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return studygroups;
	}
	
	private StudyGroup getStudygroup(ResultSet rs) throws SQLException {
		return new StudyGroup(rs.getInt("group_number"), rs.getString("group_name"), rs.getString("user_id"), rs.getString("group_type"), 
				rs.getString("join_type"), rs.getDate("create_date"), rs.getString("description"), rs.getInt("group_limit"), rs.getString("status"));
	}

	public int studyGroupCount(Connection conn) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("studyGroupCount"));
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

	public StudyGroup searchStudyGroup(Connection conn, String groupNo) {
		StudyGroup group = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroup"));
			pstmt.setInt(1, Integer.parseInt(groupNo));
			rs=pstmt.executeQuery();
			if(rs.next()) {
				group=getStudygroup(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return group;
	}

	public List<StudyGroup> searchStudyGroupType(Connection conn, String searchType, String keyword, int cPage,
			int numPerpage) {
		List<StudyGroup> studygroups = new ArrayList();
		try {
			if(searchType.equals("groupNumber")) {
				pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupNumber"));
				pstmt.setInt(1, Integer.parseInt(keyword));
				System.out.println(searchType + Integer.parseInt(keyword));
			}else if(searchType.equals("groupName")){
				pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupType"));
				pstmt.setString(1, keyword);
				System.out.println(searchType + keyword);
			}
			pstmt.setInt(2, (cPage-1)*numPerpage+1);
			pstmt.setInt(3, cPage*numPerpage);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				studygroups.add(getStudygroup(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return studygroups;
	}

	public int searchStudyGroupCount(Connection conn, String searchType, String keyword) {
		int result = 0;
		try {
			if(searchType.equals("groupNumber")) {
				pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupCountNumber"));
				pstmt.setInt(1, Integer.parseInt(keyword));
			}else if(searchType.equals("groupName")){
				pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupCount"));
				pstmt.setString(1, keyword);
			}
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
	
	public int insertGroup(Connection conn, StudyGroup g) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertGroup"));
			pstmt.setString(1, g.groupName());
			pstmt.setString(2, g.userId());
			pstmt.setString(3, g.groupType());
			pstmt.setString(4, g.joinType());
			pstmt.setString(5, g.description());
			pstmt.setInt(6, g.groupLimit());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public StudyGroup searchStudyGroupId(Connection conn, StudyGroup g) {
		StudyGroup group = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupId"));
			pstmt.setString(1, g.groupName());
			pstmt.setString(2, g.userId());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				group=getStudygroup(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return group;
	}

	public List<StudyGroup> searchStudyGroupUserId(Connection conn, String userId) {
		List<StudyGroup> studygroups = new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupUserId"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				studygroups.add(getStudygroup(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return studygroups;
	}

	public int updateGroup(Connection conn, StudyGroup g) {
		int result = 0;
		try {  
			pstmt=conn.prepareStatement(sql.getProperty("updateGroup"));
			pstmt.setString(1, g.groupName());
			pstmt.setString(2, g.groupType());
			pstmt.setString(3, g.joinType());
			pstmt.setString(4, g.description());
			pstmt.setInt(5, g.groupLimit());
			pstmt.setString(6, g.status());
			pstmt.setInt(7, g.groupNumber());
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	public int deleteGroup(Connection conn, String groupNumber) {
		int result = 0;
		try {  
			pstmt=conn.prepareStatement(sql.getProperty("deleteGroup"));
			pstmt.setInt(1, Integer.parseInt(groupNumber));
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public List<StudyGroup> searchStudyGroupMain(Connection conn) {
		List<StudyGroup> studygroups = new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchStudyGroupMain"));
			rs=pstmt.executeQuery();
			while(rs.next()) {
				studygroups.add(getStudygroup(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return studygroups;
	}

	public List<StudyGroup> mainSearchStudyGroup(Connection conn, String keyWord) {
		List<StudyGroup> studygroups = new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("mainSearchStudyGroup"));
			pstmt.setString(1, keyWord);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				studygroups.add(getStudygroup(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return studygroups;
	}

}
