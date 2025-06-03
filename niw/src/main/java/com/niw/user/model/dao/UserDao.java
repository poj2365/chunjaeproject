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
	
	public int updateUser(Connection conn, String userId, String phone, String address) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("updateUser"));
			pstmt.setString(1, phone);
			pstmt.setString(2, address);
			pstmt.setString(3, userId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public String findId(Connection conn, String userName, String userEmail) {
		String result= null;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("findId"));
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getString("USER_ID");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	public User getUser(ResultSet rs) throws SQLException {
		return User.builder()
				.userId(rs.getString("USER_ID"))
				.password(rs.getString("USER_PASSWORD"))  // USER_PASSWORD로 수정
				.userName(rs.getString("USER_NAME"))
				.userPhone(rs.getString("USER_PHONE"))
				.userEmail(rs.getString("USER_EMAIL"))
				.userProfileImage(rs.getString("USER_PROFILE_IMAGE"))
				.userPoint(rs.getInt("USER_POINT"))
				.userIntroduce(rs.getString("USER_INTRODUCE"))
				.enrollDate(rs.getDate("ENROLL_DATE"))
				.userRole(rs.getString("USER_ROLE"))
				.userAddress(rs.getString("USER_ADDRESS"))
				.userBirthDate(rs.getDate("USER_BIRTH_DATE"))
				.build();
	}
	
	public int insertUser(Connection conn, User user) {
	    int result = 0;
	   
	    try {
	    	System.out.println("=== insertUser 시작 ===");
	    	System.out.println("SQL: " + sql.getProperty("insertUser"));
	    	
	    	pstmt = conn.prepareStatement(sql.getProperty("insertUser"));

	        // 실제 테이블 구조에 맞춰 파라미터 순서 조정
	        pstmt.setString(1, user.userId());           // USER_ID
	        pstmt.setString(2, user.userName());         // USER_NAME
	        pstmt.setString(3, user.userPhone());        // USER_PHONE
	        pstmt.setString(4, user.userEmail());        // USER_EMAIL
	        pstmt.setString(5, user.userProfileImage()); // USER_PROFILE_IMAGE
	        pstmt.setInt(6, user.userPoint());           // USER_POINT
	        pstmt.setString(7, user.userIntroduce());    // USER_INTRODUCE
	        pstmt.setDate(8, user.enrollDate());         // ENROLL_DATE
	        pstmt.setString(9, user.password());         // USER_PASSWORD
	        pstmt.setString(10, user.userRole());        // USER_ROLE
	        pstmt.setString(11, user.userAddress());     // USER_ADDRESS
	        pstmt.setDate(12, user.userBirthDate());     // USER_BIRTH_DATE
	        
	        System.out.println("파라미터 설정 완료");
	        
	        result = pstmt.executeUpdate();
	        System.out.println("executeUpdate 결과: " + result);
	        
	    } catch (SQLException e) {
	        System.out.println("=== SQL 오류 발생 ===");
	        System.out.println("오류 코드: " + e.getErrorCode());
	        System.out.println("SQL 상태: " + e.getSQLState());
	        System.out.println("오류 메시지: " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }
	    
	    return result;
	}
	
	// UserDao 클래스에 추가할 메서드들

	/**
	 * 비밀번호 찾기를 위한 사용자 이메일 조회
	 * @param conn 데이터베이스 연결
	 * @param userId 사용자 아이디
	 * @param userName 사용자 이름
	 * @param birthDate 생년월일 (YYYY-MM-DD 형식)
	 * @return 사용자 이메일 (해당하는 사용자가 없으면 null)
	 */
	public String getUserEmailForPasswordReset(Connection conn, String userId, String userName, String birthDate) {
	    String userEmail = null;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("getUserEmailForPasswordReset"));
	        pstmt.setString(1, userId);
	        pstmt.setString(2, userName);
	        pstmt.setString(3, birthDate);
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	            userEmail = rs.getString("USER_EMAIL");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return userEmail;
	}

	/**
	 * 사용자 비밀번호 업데이트
	 * @param conn 데이터베이스 연결
	 * @param userId 사용자 아이디
	 * @param newPassword 새로운 비밀번호
	 * @return 업데이트 성공 시 1, 실패 시 0
	 */
	public int updateUserPassword(Connection conn, String userId, String newPassword) {
	    int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("updateUserPassword"));
	        pstmt.setString(1, newPassword);
	        pstmt.setString(2, userId);
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(pstmt);
	    }
	    return result;
	}
}