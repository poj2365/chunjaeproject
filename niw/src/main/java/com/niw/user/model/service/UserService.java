package com.niw.user.model.service;

import static com.niw.common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.niw.user.model.dao.UserDao;
import com.niw.user.model.dto.User;

public enum UserService {
	USERSERVICE;
	
	private UserDao dao = UserDao.DAO;
	
	public List<User> searchAll(){
		return null;
	}
	
	public User searchById(String userId) {
		Connection conn = getConnection();
		User user = dao.searchById(conn, userId);
		close(conn);
		return user;
	}
	

	public int insertUser(User user) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result = dao.insertUser(conn, user);
			
			if (result > 0) {
				commit(conn);
			} else {
				rollback(conn);
			}
			
		} catch (Exception e) {
			rollback(conn);
			e.printStackTrace();
		} finally {
			close(conn);
		}
		
		return result;
	}
	public String findId(String userName, String userEmail) {
		Connection conn = getConnection();
		String result = null;
		
		try {
			result = dao.findId(conn, userName, userEmail);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn);
		}
		
		return result;
	}
	
	
	// UserService 클래스에 추가할 메서드들

	/**
	 * 비밀번호 찾기를 위한 사용자 이메일 조회
	 * @param userId 사용자 아이디
	 * @param userName 사용자 이름
	 * @param birthDate 생년월일 (YYYY-MM-DD 형식)
	 * @return 사용자 이메일 (해당하는 사용자가 없으면 null)
	 */
	public String getUserEmailForPasswordReset(String userId, String userName, String birthDate) {
	    Connection conn = getConnection();
	    String userEmail = null;
	    
	    try {
	        userEmail = dao.getUserEmailForPasswordReset(conn, userId, userName, birthDate);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(conn);
	    }
	    
	    return userEmail;
	}

	/**
	 * 사용자 비밀번호 초기화 (abcd1234!로 변경)
	 * @param userId 사용자 아이디
	 * @return 성공 시 true, 실패 시 false
	 */
	public boolean resetUserPassword(String userId) {
	    Connection conn = getConnection();
	    int result = 0;
	    
	    try {
	        // 비밀번호를 abcd1234!로 초기화
	        result = dao.updateUserPassword(conn, userId, "abcd1234!");
	        
	        if (result > 0) {
	            commit(conn);
	        } else {
	            rollback(conn);
	        }
	        
	    } catch (Exception e) {
	        rollback(conn);
	        e.printStackTrace();
	    } finally {
	        close(conn);
	    }
	    
	    return result > 0;
	}
	
	
	/**
	 * 이메일 중복 체크
	 * @param email 확인할 이메일
	 * @return 사용 가능하면 true, 중복이면 false
	 */
//	public boolean checkEmailAvailable(String email) {
//		Connection conn = getConnection();
//		boolean isAvailable = false;
//		
//		try {
//			User user = dao.searchByEmail(conn, email);
//			isAvailable = (user == null);
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			close(conn);
//		}
//		
//		return isAvailable;
//	}
}