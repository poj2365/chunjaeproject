package com.niw.study.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dao.CalendarDao;
import com.niw.study.model.dto.Calendar;

public enum CalendarService {
	SERVICE;

	private CalendarDao dao = CalendarDao.DAO;
	
	public List<Calendar> searchCalendar(String userId) {
		Connection conn = JDBCTemplate.getConnection();
		List<Calendar> c = dao.searchCalendar(conn, userId);
		JDBCTemplate.close(conn);
		return c;
	}
	
	public int insertCalendar(Calendar c) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.insertCalendar(conn,c);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
	}

	public Calendar searchCalendarById(Calendar c) {
		Connection conn = JDBCTemplate.getConnection();
		Calendar calendar = dao.searchCalendarById(conn, c);
		JDBCTemplate.close(conn);
		return calendar;
	}

	public int updateCalendar(Calendar c) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.updateCalendar(conn,c);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
	}

	public int deleteCalendar(Calendar c) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.deleteCalendar(conn,c);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		JDBCTemplate.close(conn);
		return result;
	}


}
