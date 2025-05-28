package com.niw.study.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.study.model.dao.StudyGroupDao;
import com.niw.study.model.dto.StudyGroup;

public enum StudyGroupService {
	SERVICE;
	
	private StudyGroupDao dao = StudyGroupDao.DAO;
	private Connection conn = null;

	public List<StudyGroup> searchStudyGroupAll(int cPage, int numPerpage) {
		conn = JDBCTemplate.getConnection();
		List<StudyGroup> studygroups = dao.searchStudyGroupAll(conn, cPage, numPerpage);
		JDBCTemplate.close(conn);
		return studygroups;
	}

	public int studyGroupCount() {
		conn = JDBCTemplate.getConnection();
		int result = dao.studyGroupCount(conn);
		JDBCTemplate.close(conn);
		return result;
	}

	public StudyGroup searchStudyGroup(String groupNo) {
		conn = JDBCTemplate.getConnection();
		StudyGroup group = dao.searchStudyGroup(conn, groupNo);
		JDBCTemplate.close(conn);
		return group;
	}


	public List<StudyGroup> searchStudyGroupType(String searchType, String keyword, int cPage, int numPerpage) {
		conn = JDBCTemplate.getConnection();
		List<StudyGroup> studygroups = dao.searchStudyGroupType(conn,searchType,keyword, cPage, numPerpage);
		JDBCTemplate.close(conn);
		return studygroups;
	}

	public int searchStudyGroupCount(String searchType, String keyword) {
		conn = JDBCTemplate.getConnection();
		int result = dao.searchStudyGroupCount(conn, searchType, keyword);
		return result;
	}

	public int insertGroup(StudyGroup g) {
		conn = JDBCTemplate.getConnection();
		int result = dao.insertGroup(conn, g);
		JDBCTemplate.close(conn);
		return result;
	}
	
	
}
