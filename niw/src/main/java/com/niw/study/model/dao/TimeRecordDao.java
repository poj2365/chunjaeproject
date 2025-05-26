package com.niw.study.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dto.TimeRecord;

public enum TimeRecordDao {
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

	public int insertTime(Connection conn, TimeRecord tr) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertTime"));
			pstmt.setString(1, tr.category());
			pstmt.setTimestamp(2, new Timestamp(tr.startTime().getTime()));
			pstmt.setTimestamp(3, new Timestamp(tr.endTime().getTime()));
			pstmt.setString(4, tr.totalTime());
			pstmt.setString(5, tr.userId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	TimeRecord getTime(ResultSet rs) throws SQLException {
		return new TimeRecord(rs.getInt("time_no"), rs.getString("category"),
				rs.getDate("start_time"), rs.getDate("end_time"),rs.getString("total_time"), rs.getString("user_id"));
	}

	public List<TimeRecord> searchTimeToday(Connection conn, String userId, LocalDateTime startDate, LocalDateTime endDate) {
		List<TimeRecord> trList = new ArrayList<TimeRecord>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchTimeToday"));
			pstmt.setString(1, userId);
			pstmt.setTimestamp(2,  Timestamp.valueOf(startDate));
			pstmt.setTimestamp(3,  Timestamp.valueOf(endDate));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				trList.add(getTime(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return trList;
	}
	
	public List<TimeRecord> searchTime(Connection conn, String userId) {
		List<TimeRecord> trList = new ArrayList<TimeRecord>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchTime"));
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				trList.add(getTime(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return trList;
	}
	
	public List<TimeRecord> searchTimeTodayAll(Connection conn, LocalDateTime startDate, LocalDateTime endDate) {
		List<TimeRecord> trList = new ArrayList<TimeRecord>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchTimeTodayAll"));
			pstmt.setTimestamp(1,  Timestamp.valueOf(startDate));
			pstmt.setTimestamp(2,  Timestamp.valueOf(endDate));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				trList.add(getTime(rs));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return trList;
	}
}

