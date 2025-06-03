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
import com.niw.board.model.dto.Notice;

public enum BoardService {
	SERVICE;
	
	
	public List<Article> searchArticle(int category, String searchData, int likes, String order, int cPage, int numPerPage, int totalData){
		Connection conn = getConnection();
		List<Article> articles = BoardDao.DAO.searchArticle(conn, category, searchData, likes, order, cPage, numPerPage, totalData);
		close(conn);
		return articles;
	}
	
	public List<Article> searchArticleByUser(String userId, String order, int cPage, int numPerPage, int totalData){
		Connection conn = getConnection();
		List<Article> articles = BoardDao.DAO.searchArticleByUser(conn, userId, order, cPage, numPerPage, totalData);
		close(conn);
		return articles;
	}
	
	public List<Article> searchArticleByRecommend(int recommend, String searchData, int numPerPage){
		Connection conn = getConnection();
		List<Article> articles = BoardDao.DAO.searchArticleByRecommend(conn, recommend, searchData, numPerPage);
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

	public int countArticleByUser(String userId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.countArticleByUser(conn, userId);
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
	
	public int countCommentByUser(String userId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.countCommentByUser(conn, userId);
		close(conn);
		return result;
	}
	
	public List<Comment> searchCommentByUser(String userId, int cPage, int numPerPage, int totalData){
		Connection conn = getConnection();
		List<Comment> comments = BoardDao.DAO.searchCommentByUser(conn, userId, cPage, numPerPage, totalData);
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
	
	public int countBookmarkByUser(String userId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.countBookmarkByUser(conn, userId);
		close(conn);
		return result;
	}
	
	public List<Article> searchBookmarkByUser(String userId, int cPage, int numPerPage, int totalData){
		Connection conn = getConnection();
		List<Article> bookmarks = BoardDao.DAO.searchBookmarkByUser(conn, userId, cPage, numPerPage, totalData);
		close(conn);
		return bookmarks;
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
	
	public int saveComment(String userId, int articleId, String content, int targetId, int level) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.saveComment(conn, userId, articleId, content, targetId, level);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int saveArticle(Article article) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.saveArticle(conn, article);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int increaseView(int articleId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.increaseView(conn, articleId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int deleteArticle(int articleId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.deleteArticle(conn, articleId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;		
	}
	
	public int deleteComment(int commentId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.deleteComment(conn, commentId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;	
	}
	
	public int updateArticle(Article article) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.updateArticle(conn, article);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;	
	}
	
	public int updateComment(Comment comment) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.updateComment(conn, comment);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;	
	}
	
	public List<Notice> searchNotice(){
		Connection conn = getConnection();
		List<Notice> notices = BoardDao.DAO.searchNotice(conn);
		close(conn);
		return notices;
	}
	public Notice searchNoticeById(int noticeId){
		Connection conn = getConnection();
		Notice notice = BoardDao.DAO.searchNoticeById(conn, noticeId);
		close(conn);
		return notice;
	}
	
	public int countNotice() {
		Connection conn = getConnection();
		int result = BoardDao.DAO.countNotice(conn);
		close(conn);
		return result;
	}
	
	public int saveNotice(Notice notice) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.saveNotice(conn, notice);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	
	public int deleteNotice(int noticeId) {
		Connection conn = getConnection();
		int result = BoardDao.DAO.deleteNotice(conn, noticeId);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
}
