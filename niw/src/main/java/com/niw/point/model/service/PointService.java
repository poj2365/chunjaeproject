package com.niw.point.model.service;

import java.sql.Connection;

import com.niw.common.JDBCTemplate;
import com.niw.point.model.dao.PointDao;
import com.niw.point.model.dto.Point;
import com.niw.point.model.dto.PointRefund;

public class PointService {

	private static final PointService SERVICE = new PointService();

	private PointService() {}

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

}
