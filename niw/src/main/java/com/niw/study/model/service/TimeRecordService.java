package com.niw.study.model.service;

import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dao.TimeRecordDao;
import com.niw.study.model.dto.TimeRecord;

public enum TimeRecordService {
	SERVICE;

	private TimeRecordDao dao = TimeRecordDao.DAO;
	
	public int insertTime(TimeRecord tr) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.insertTime(conn,tr);
		if(result>0) JDBCTemplate.commit(conn);
		else JDBCTemplate.rollback(conn);
		return result;
	}

	public List<TimeRecord> searchTimeToday(String userId, LocalDateTime startDate, LocalDateTime endDate) {
		Connection conn = JDBCTemplate.getConnection();
		List<TimeRecord> trList = dao.searchTimeToday(conn, userId,startDate,endDate);
		JDBCTemplate.close(conn);
		return trList;
	}
	
	public List<TimeRecord> searchTime(String userId) {
		Connection conn = JDBCTemplate.getConnection();
		List<TimeRecord> trList = dao.searchTime(conn, userId);
		JDBCTemplate.close(conn);
		return trList;
	}
}
