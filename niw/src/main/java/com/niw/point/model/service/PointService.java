package com.niw.point.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.point.model.dao.PointDao;
import com.niw.point.model.dto.Point;
import com.niw.point.model.dto.PointHistory;
import com.niw.point.model.dto.PointMyFile;
import com.niw.point.model.dto.PointRefund;

public class PointService {

	private static final PointService SERVICE = new PointService();

	private PointService() {
	}

	public static PointService ponitService() {
		return SERVICE;
	}

	private PointDao dao = PointDao.pointDao();

	public int insertPointHistory(Point p) {

		Connection conn = JDBCTemplate.getConnection();
		int result = dao.insertPointHistory(conn, p);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int refundPointHistoy(PointRefund p) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.refundPointHistory(conn, p);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int refundFileHistoy(PointRefund p) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.refundFileHistory(conn, p);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int chargePoint(int addpoint, String userId) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.chargePoint(conn, userId, addpoint);
		if (result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public List<PointHistory> searchPointHistory(String userId) {
		List<PointHistory> historys = new ArrayList<PointHistory>();
		Connection conn = JDBCTemplate.getConnection();
		historys = dao.searchPointHistory(conn, userId);
		JDBCTemplate.close(conn);
		return historys;
	}

	public List<PointMyFile> showMyFiles(String userId) {
		List<PointMyFile> files = new ArrayList<PointMyFile>();
		Connection conn = JDBCTemplate.getConnection();
		files = dao.showMyFiles(conn, userId);
		JDBCTemplate.close(conn);
		return files;
	}
	
	public List<PointRefund> showAllRefundList(){
		List<PointRefund> lists = new ArrayList<PointRefund>();
		Connection conn = JDBCTemplate.getConnection();
		//lists = dao.showAllRefundList(conn);
		JDBCTemplate.close(conn);
		return lists;
		
	}
	
	

}
