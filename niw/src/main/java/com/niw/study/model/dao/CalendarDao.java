package com.niw.study.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dto.Calendar;

public enum CalendarDao {
	DAO;

	private Properties sql = new Properties();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	{// 초기화 블록
		String path = CalendarDao.class.getResource("/sql/study_sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sql.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Calendar> searchCalendar(Connection conn, String userId) {
		List<Calendar> c = new ArrayList();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchCalendar"));
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				c.add(getCalendar(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}

	private Calendar getCalendar(ResultSet rs) throws SQLException {
		return new Calendar(rs.getString("calendar_name"), rs.getString("calendar_content"),
				rs.getDate("start_time"), rs.getDate("end_time"),rs.getString("user_id"));
	}

	public int insertCalendar(Connection conn, Calendar c) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertCalendar"));
			pstmt.setString(1, c.calendarName());
			pstmt.setString(2, c.calendarContent());
			pstmt.setTimestamp(3, new Timestamp(c.startTime().getTime()));
			pstmt.setTimestamp(4, new Timestamp(c.endTime().getTime()));
			pstmt.setString(5, c.userId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
}
