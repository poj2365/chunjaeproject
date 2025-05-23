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
}
