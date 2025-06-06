package com.niw.study.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return c;
	}

	private Calendar getCalendar(ResultSet rs) throws SQLException {
		return new Calendar(rs.getInt("calendar_no"), rs.getString("calendar_name"), rs.getString("calendar_content"),
				rs.getTimestamp("start_time"), rs.getTimestamp("end_time"),rs.getString("user_id"));
	}

	public int insertCalendar(Connection conn, Calendar c) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("insertCalendar"));
			pstmt.setString(1, c.calendarName());
			pstmt.setString(2, c.calendarContent());
			pstmt.setTimestamp(3, c.startTime());
			pstmt.setTimestamp(4, c.endTime());
			pstmt.setString(5, c.userId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public Calendar searchCalendarById(Connection conn, Calendar c) {
		Calendar calendar = null;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchCalendarById"));
			pstmt.setInt(1, c.calendarNo());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				calendar=getCalendar(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(calendar);
		return calendar;
	}

	public int updateCalendar(Connection conn, Calendar c) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("updateCalendar"));
			pstmt.setString(1, c.calendarName());
			pstmt.setString(2, c.calendarContent());
			pstmt.setTimestamp(3, c.startTime());
			pstmt.setTimestamp(4, c.endTime());
			pstmt.setString(5, c.userId());
			pstmt.setInt(6, c.calendarNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int deleteCalendar(Connection conn, Calendar c) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("deleteCalendar"));
			pstmt.setString(1, c.userId());
			pstmt.setInt(2, c.calendarNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

}
