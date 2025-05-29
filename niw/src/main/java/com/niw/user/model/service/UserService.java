package com.niw.user.model.service;

import static com.niw.common.JDBCTemplate.*;

import java.sql.Connection;
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