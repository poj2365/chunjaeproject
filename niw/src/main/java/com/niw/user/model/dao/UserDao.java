package com.niw.user.model.dao;

import static com.niw.common.JDBCTemplate.*;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.niw.user.model.dto.User;

public enum UserDao {
	DAO;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	{
		String path = UserDao.class.getResource("/sql/user_sql.properties").getPath();
		try(FileReader fr = new FileReader(path)){
			sql.load(fr);
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	public User searchById(Connection conn, String id) {
		User user = null;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchById"));
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) user=getUser(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		
		}
		return user;
	}
	
	public User getUser(ResultSet rs) throws SQLException {
		return User.builder()
				.userId(rs.getString("USER_ID"))
				.password(rs.getString("USER_PASSWORD"))
				.userName(rs.getString("USER_NAME"))
				.userPhone(rs.getString("USER_PHONE"))
				.userEmail(rs.getString("USER_EMAIL"))
				.userProfileImage(rs.getString("USER_PROFILE_IMAGE"))
				.userPoint(rs.getInt("USER_POINT"))
				.userIntroduce(rs.getString("USER_INTRODUCE"))
				.enrollDate(rs.getDate("ENROLL_DATE"))
				.userRole(rs.getString("USER_ROLE"))				
				.build();
	}
}
