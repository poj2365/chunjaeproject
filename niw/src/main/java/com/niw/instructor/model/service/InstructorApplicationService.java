package com.niw.instructor.model.service;

import java.sql.Connection;
import static com.niw.common.JDBCTemplate.*;
import com.niw.instructor.model.dao.InstructorApplicationDao;
import com.niw.instructor.model.dto.InstructorApplication;
public enum InstructorApplicationService {
	SERVICE;
	
	private static final InstructorApplicationDao dao=InstructorApplicationDao.DAO;
	
	
	public int instructorApply(InstructorApplication instructorApplication) {
		Connection conn = getConnection();
		int result=dao.instructorApply(conn, instructorApplication);
		close(conn);
		return result;
	}
}
