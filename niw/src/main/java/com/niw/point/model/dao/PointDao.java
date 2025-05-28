package com.niw.point.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.point.model.dto.Point;
import com.niw.point.model.dto.PointRefund;
import com.niw.user.model.dto.User;

public class PointDao {
	
	private Properties sql=new Properties();
	// 프로퍼티 만들기
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static final PointDao DAO = new PointDao();
	
	private  PointDao() {
		String path = PointDao.class.getResource("/sql/point_sql.properties").getPath();
		try(FileReader fr=new FileReader(path)) {
			sql.load(fr);
		}catch(IOException e) {
			e.printStackTrace();
		}
	}


	public static PointDao pointDao() {
		return DAO;
	}
	
	public int insertPointHistory(Connection conn, Point p) {
		int result =0;
		
		try {

			System.out.println(sql.getProperty("insertPointHistory"));
			pstmt =  conn.prepareStatement(sql.getProperty("insertPointHistory"));// -> 이게 왜 null?
			pstmt.setLong(1, p.getPointId());
			pstmt.setString(2, p.getUserId());
			pstmt.setInt(3, p.getPointAmount());
			pstmt.setInt(4, p.getPrice());
			pstmt.setString(5, p.getPointDescription());
			pstmt.setString(6, p.getPortOneId());
			
			result =pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	public int refundPointHistory(Connection conn, PointRefund p) {
		int result = 0;
		try{
			pstmt =  conn.prepareStatement(sql.getProperty("refundPoint"));

			pstmt.setLong(1, p.getRefundId());
			pstmt.setString(2,p.getUserId());
			pstmt.setString(3, p.getRefundType());
			pstmt.setInt(4 , p.getRefundPoint());
			pstmt.setInt(5, p.getRefundAmount());
			pstmt.setString(6, p.getRefundBank());
			pstmt.setString(7, p.getRefundAccount());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	public int refundFileHistory(Connection conn, PointRefund p) {
		int result = 0;
		try{
			pstmt =  conn.prepareStatement(sql.getProperty("refundFile"));
			pstmt.setLong(1, p.getRefundId());
			pstmt.setString(2,p.getUserId());
			pstmt.setString(3, p.getRefundType());
			pstmt.setLong(4, p.getFileId());
			pstmt.setInt(5, p.getFilePoint());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	

	
	public int chargePoint (Connection conn, String userId, int addpoint) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("addPoint"));
			pstmt.setInt(1,addpoint);
			pstmt.setString(2, userId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

}
