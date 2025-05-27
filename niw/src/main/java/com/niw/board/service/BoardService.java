package com.niw.board.service;

import static com.niw.common.JDBCTemplate.close;
import static com.niw.common.JDBCTemplate.commit;
import static com.niw.common.JDBCTemplate.getConnection;
import static com.niw.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.niw.board.model.dao.BoardDao;
import com.niw.board.model.dto.Article;
import com.niw.board.model.dto.Comment;

public enum BoardService {
	SERVICE;
	
	public int insertArticle() {
		Connection conn = getConnection();
		int result = BoardDao.DAO.insertArticle(conn);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public List<Article> searchArticle(int category, String searchData, int likes, String order, int cPage, int numPerPage, int totalData){
		Connection conn = getConnection();
		List<Article> articles = BoardDao.DAO.searchArticle(conn, category, searchData, likes, order, cPage, numPerPage, totalData);
		close(conn);
		return articles;
	}
	
	public int countArticle(int category, String searchData, int likes) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.countArticle(conn, category, searchData, likes);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public Article searchArticleById(int articleId) {
		Connection conn = getConnection();
		Article article = BoardDao.DAO.searchArticleById(conn, articleId);
		close(conn);
		return article;
	}
	
	public List<Comment> searchCommentByArticle(int articleId) {
		Connection conn = getConnection();
		List<Comment> comments = BoardDao.DAO.searchCommentByArticle(conn, articleId);
		close(conn);
		return comments;
	}
	
	public int saveBookmark(String userId, String articleId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.saveBookmark(conn, userId, articleId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int deleteBookmark(String userId, String articleId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.deleteBookmark(conn, userId, articleId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int searchBookmark(String userId, int articleId) {
		Connection conn = getConnection();
		int bookmark = BoardDao.DAO.searchBookmark(conn, userId, articleId);
		close(conn);
		return bookmark;
	}
	
	public int searchReport(String userId, int targetId, String targetType) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.searchReport(conn, userId, targetId, targetType);
		close(conn);
		return result;		
	}
	
	public int saveReport(String userId, int targetId, String targetType, String reason, String details) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.saveReport(conn, userId, targetId, targetType, reason, details);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;		
	}
	
	public int saveRecommend(String userId, int recType, String boardType, int targetId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.saveRecommend(conn, userId, recType, boardType, targetId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int deleteRecommend(String userId, int recType, String boardType, int targetId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.deleteRecommend(conn, userId, recType, boardType, targetId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int searchRecommend(String userId, int recType, String boardType, int targetId) {
		Connection conn = getConnection();
		int bookmark = BoardDao.DAO.searchRecommend(conn, userId, recType, boardType, targetId);
		close(conn);
		return bookmark;
	}
	
	public int increaseRecommend(int recType, String boardType, int targetId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.increaseRecommend(conn, recType, boardType, targetId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int decreaseRecommend(int recType, String boardType, int targetId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.decreaseRecommend(conn, recType, boardType, targetId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
}
