package com.niw.point.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.common.JDBCTemplate;
import com.niw.point.model.dto.Point;
import com.niw.point.model.dto.PointHistory;
import com.niw.point.model.dto.PointMyFile;
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
			pstmt= conn.prepareStatement(sql.getProperty("searchUserPoint"));
			pstmt.setString(1,p.getUserId());
			rs = pstmt.executeQuery();
			int myPoint =0;
			if(rs.next()) {
				myPoint = rs.getInt("user_point");
			}
			pstmt =  conn.prepareStatement(sql.getProperty("insertPointHistory"));// -> 이게 왜 null?
			pstmt.setLong(1, p.getPointId());
			pstmt.setString(2, p.getUserId());
			pstmt.setInt(3, p.getPointAmount());
			pstmt.setInt(4, p.getPrice());
			pstmt.setString(5, p.getPointDescription());
			pstmt.setString(6, p.getPortOneId());
			pstmt.setInt(7, myPoint+p.getPointAmount());;
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
//			pstmt = conn.prepareStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	public List<PointHistory> searchPointHistory (Connection conn,String userId){
		List<PointHistory> historys = new ArrayList();
		int amount=0;
		try {
			pstmt = conn.prepareStatement("pointHistory");
			pstmt.setString(1, userId);
			pstmt.setString(2, userId);
			pstmt.setString(3, userId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Date date = rs.getDate("event_date");
				String content = rs.getString("description") + " " +rs.getString("event_type");
				if(rs.getString("event_type").equals("구매")) {
					 amount = rs.getInt("change_point") * -1;
				} else {
					 amount = rs.getInt("change_point");
				}
				int mypoint = rs.getInt("remain_point");
				
				PointHistory p = new PointHistory(date,content,amount,mypoint);
				historys.add(p);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return historys;
	}
	
	public List<PointMyFile> showMyFiles (Connection conn,String userId){
		List<PointMyFile> files = new ArrayList<PointMyFile>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("showMyFile"));
			System.out.println(sql.getProperty("showMyFile"));
			pstmt.setString(1, userId);
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				long materialId = rs.getLong("material_id");
				String materialName = rs.getString("material_title");
				int materialPrice = rs.getInt("material_price");
				PointMyFile file = new PointMyFile(materialName,materialId,materialPrice);
				files.add(file);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return files;
	}

}
