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
import com.niw.point.model.dto.PointRefundFileList;
import com.niw.point.model.dto.PointRefundList;

public class PointDao {

	private Properties sql = new Properties();
	// 프로퍼티 만들기
	private PreparedStatement pstmt;
	private ResultSet rs;

	private static final PointDao DAO = new PointDao();

	private PointDao() {
		String path = PointDao.class.getResource("/sql/point_sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sql.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static PointDao pointDao() {
		return DAO;
	}

	public int insertPointHistory(Connection conn, Point p) {
		int result = 0;

		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchUserPoint"));
			pstmt.setString(1, p.getUserId());
			rs = pstmt.executeQuery();
			int myPoint = 0;
			if (rs.next()) {
				myPoint = rs.getInt("user_point");
			}
			pstmt = conn.prepareStatement(sql.getProperty("insertPointHistory"));// -> 이게 왜 null?
			pstmt.setLong(1, p.getPointId());
			pstmt.setString(2, p.getUserId());
			pstmt.setInt(3, p.getPointAmount());
			pstmt.setInt(4, p.getPrice());
			pstmt.setString(5, p.getPointDescription());
			pstmt.setString(6, p.getPortOneId());
			pstmt.setInt(7, myPoint + p.getPointAmount());
			;
			result = pstmt.executeUpdate();

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
		try {
			pstmt = conn.prepareStatement(sql.getProperty("refundPoint"));

			pstmt.setLong(1, p.getRefundId());
			pstmt.setString(2, p.getUserId());
			pstmt.setString(3, p.getRefundType());
			pstmt.setInt(4, p.getRefundPoint());
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
		try {
			pstmt = conn.prepareStatement(sql.getProperty("refundFile"));
			pstmt.setLong(1, p.getRefundId());
			pstmt.setString(2, p.getUserId());
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

	public int chargePoint(Connection conn, String userId, int addpoint) {
		int result = 0;
		try {

			pstmt = conn.prepareStatement(sql.getProperty("addPoint"));
			pstmt.setInt(1, addpoint);
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

	public List<PointHistory> searchPointHistory(Connection conn, String userId) {
		List<PointHistory> historys = new ArrayList();
		int amount = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("myPointHistory"));
			pstmt.setString(1, userId);
			pstmt.setString(2, userId);
			pstmt.setString(3, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Date date = rs.getDate("EVENT_TIME");
				String description = rs.getString("description");
				String content;
				if (description.contains("환불")) {
				    content = description; // 이미 '환불'이 포함되어 있으면 그대로!
				} else {
				    content = description + " " + rs.getString("event_type"); 
				}
				if (rs.getString("event_type").equals("구매")) {
					amount = rs.getInt("change_point") * -1;
				} else {
					amount = rs.getInt("change_point");
				}
				int mypoint = rs.getInt("remain_point");

				PointHistory p = new PointHistory(date, content, amount, mypoint);
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

	public List<PointMyFile> showMyFiles(Connection conn, String userId) {
		List<PointMyFile> files = new ArrayList<PointMyFile>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("showMyFile"));
			System.out.println(sql.getProperty("showMyFile"));
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				long materialId = rs.getLong("material_id");
				String materialName = rs.getString("material_title");
				int materialPrice = rs.getInt("material_price");
				PointMyFile file = new PointMyFile(materialName, materialId, materialPrice);
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

	public List<PointRefundList> showAllRefundList(Connection conn) {
		List<PointRefundList> lists = new ArrayList<PointRefundList>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("showAllRefundList"));
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String refundId = rs.getString("refund_id");
				String userId = rs.getString("user_id");
				String userName = rs.getString("user_name");
				Date refundDate = rs.getDate("refund_date");
				int pointAmount = rs.getInt("refund_point");
				String bank = rs.getString("refund_bank");
				String bankAccount = rs.getString("refund_account");
				String status = rs.getString("refund_status");
				PointRefundList list = new PointRefundList(refundId, userId, userName, refundDate, pointAmount, bank,
						bankAccount, status);
				lists.add(list);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return lists;

	}
	
	public List<PointRefundFileList> showAllRefundFileList(Connection conn) {
		List<PointRefundFileList> lists = new ArrayList<PointRefundFileList>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("showAllRefundFileList"));
			rs = pstmt.executeQuery();

			while (rs.next()) {
				String refundId = rs.getString("refund_id");
				System.out.println(refundId);
				String userId = rs.getString("user_id");
				String userName = rs.getString("user_name");
				Date refundDate = rs.getDate("refund_date");
				String fileName = rs.getString("material_title");
				System.out.println(fileName);
				int price = rs.getInt("material_price");
				String status = rs.getString("refund_status");
				PointRefundFileList list = new PointRefundFileList(refundId, userId, userName, refundDate, fileName, price,status);
				lists.add(list);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return lists;

	}
	
	

	public int approvePointRefund(Connection conn, Long refundId, String userId, int pointAmount) {
		int result = 0;
		int point = 0;
		pointAmount = pointAmount * -1;
		try {
			// 포인트 업데이트하기
			pstmt = conn.prepareStatement(sql.getProperty("updateUserPoint"));
			pstmt.setInt(1, pointAmount);
			pstmt.setString(2, userId);
			
			result = pstmt.executeUpdate();
			
			// 업데이트 된 포인트 가져오기
			pstmt = conn.prepareStatement(sql.getProperty("myPoint"));
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				point = rs.getInt("USER_POINT");
			}

			// 업데이트한 포인트 남은포인트 컬럼에 넣어주기
			pstmt = conn.prepareStatement(sql.getProperty("approveRefund"));
			pstmt.setInt(1, point);
			pstmt.setLong(2, refundId);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rs);
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int rejectPointRefund(Connection conn, Long refundId, String userId, int pointAmount) {
		int result = 0;
		int point = 0;
		try {
			pstmt = conn.prepareStatement(sql.getProperty("myPoint"));
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				point = rs.getInt("USER_POINT");
			}
			pstmt = conn.prepareStatement(sql.getProperty("rejectRefund"));
			pstmt.setLong(1, point);
			pstmt.setLong(2, refundId);
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
