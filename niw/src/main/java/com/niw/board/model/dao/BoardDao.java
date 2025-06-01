package com.niw.board.model.dao;

import static com.niw.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.board.model.dto.Article;
import com.niw.board.model.dto.Comment;
import com.niw.board.model.dto.Notice;

public enum BoardDao {
	DAO;
	
	private Properties sqlPro = new Properties();
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	{
		String path = BoardDao.class.getResource("/sql/board_sql.properties").getPath();
		try(FileReader fr = new FileReader(path)) {
			sqlPro.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	private Article getArticle(ResultSet rs) throws SQLException{
		return Article.builder()
					  .articleId(rs.getInt("article_id"))
					  .userId(rs.getString("user_id"))
					  .articleTitle(rs.getString("article_title"))
					  .articleContent(rs.getString("article_content"))
					  .articleDateTime(rs.getTimestamp("article_datetime"))
					  .articleModifiedTime(rs.getTimestamp("article_modified_time"))
					  .articleViews(rs.getInt("article_views"))
					  .articleLikes(rs.getInt("article_likes"))
					  .articleDislikes(rs.getInt("article_dislikes"))
					  .articleCategory(rs.getInt("article_category"))
					  .articleDelete(rs.getInt("article_delete"))
					  .commentCount(rs.getInt("comment_count"))
					  .build();
	}
	
	
	public List<Article> searchArticle(Connection conn, int category, String searchData, int likes, String order, int cPage, int numPerPage, int totalData){
		List<Article> articles = new ArrayList<>();
		try {
			if(category == 0) {
				String sql =  sqlPro.getProperty("searchArticle");
				String finalSql = sql.formatted(order);
				pstmt = conn.prepareStatement(finalSql);
				pstmt.setString(1, "%" + searchData + "%");
				pstmt.setInt(2, likes);
				pstmt.setInt(3, (cPage - 1) * numPerPage + 1);
				pstmt.setInt(4, totalData > cPage * numPerPage? cPage * numPerPage : totalData);
			} else {
				String sql =  sqlPro.getProperty("searchArticleByCategory");
				String finalSql = sql.formatted(order);
				pstmt = conn.prepareStatement(finalSql);
				pstmt.setInt(1, category);
				pstmt.setString(2, "%" + searchData + "%");
				pstmt.setInt(3, likes);
				pstmt.setInt(4, (cPage - 1) * numPerPage + 1);
				pstmt.setInt(5, totalData > cPage * numPerPage? cPage * numPerPage : totalData);
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				articles.add(getArticle(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return articles;
	}
	public List<Article> searchArticleByUser(Connection conn, String userId, String order, int cPage, int numPerPage, int totalData){
		List<Article> articles = new ArrayList<>();
		try {
			String sql =  sqlPro.getProperty("searchArticle");
			String finalSql = sql.formatted(order);
			pstmt = conn.prepareStatement(finalSql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(3, totalData > cPage * numPerPage? cPage * numPerPage : totalData);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				articles.add(getArticle(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return articles;
	}
	
	public int countArticle(Connection conn, int category, String searchData, int likes) {
		int result = 0;
		try {
			if(category == 0) {
				pstmt = conn.prepareStatement(sqlPro.getProperty("countArticle"));
				pstmt.setString(1, searchData);
				pstmt.setInt(2, likes);
			} else {
				pstmt = conn.prepareStatement(sqlPro.getProperty("countArticleByCategory"));
				pstmt.setInt(1, category);
				pstmt.setString(2, searchData);
				pstmt.setInt(3, likes);
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	public Article searchArticleById(Connection conn, int articleId) {
		Article article = null;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchArticleById"));
			pstmt.setInt(1, articleId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				article = getArticle(rs);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return article;
	}
	
	public List<Comment> searchCommentByArticle(Connection conn, int articleId) {
		List<Comment> comments = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchCommentByArticle"));
			pstmt.setInt(1, articleId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				comments.add(getComment(rs));
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return comments;
	}
	
	private Comment getComment(ResultSet rs) throws SQLException {
		return Comment.builder()
					  .commentId(rs.getInt("comment_id"))
					  .userId(rs.getString("user_id"))
					  .articleId(rs.getInt("article_id"))
					  .commentContent(rs.getString("comment_content"))
					  .commentLikes(rs.getInt("comment_likes"))
					  .commentDislikes(rs.getInt("comment_dislikes"))
					  .commentDateTime(rs.getTimestamp("comment_datetime"))
					  .commentModified(rs.getInt("comment_modified"))
					  .commentDelete(rs.getInt("comment_delete"))
					  .commentRef(rs.getInt("comment_ref"))
					  .commentLevel(rs.getInt("comment_level"))
					  .userRef(rs.getString("user_ref"))
					  .build();
		
	}
	
	public int deleteBookmark(Connection conn, String userId, String articleId) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("deleteBookmark"));
			pstmt.setInt(1, Integer.parseInt(articleId));
			pstmt.setString(2, userId);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int saveBookmark(Connection conn, String userId, String articleId) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("saveBookmark"));
			pstmt.setInt(1, Integer.parseInt(articleId));
			pstmt.setString(2, userId);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int searchBookmark(Connection conn, String userId, int articleId) {
		int bookmark = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchBookmark"));
			pstmt.setInt(1, articleId);
			pstmt.setString(2, userId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bookmark = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return bookmark;
	}
	
	public int searchReport(Connection conn, String userId, int targetId, String targetType) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchReport"));
			pstmt.setString(1, userId);
			pstmt.setInt(2, targetId);
			pstmt.setString(3, targetType);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return result;
	}
	
	public int saveReport(Connection conn, String userId, int targetId, String targetType, String reason, String details) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("saveReport"));
			pstmt.setString(1, userId);
			pstmt.setString(2, reason);
			pstmt.setString(3, details);
			pstmt.setString(4, targetType);
			pstmt.setInt(5, targetId);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int saveRecommend(Connection conn, String userId, int recType, String boardType, int targetId) {
		int recommend = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("saveRecommend"));
			pstmt.setString(1, userId);
			pstmt.setInt(2, recType);
			pstmt.setString(3, boardType);
			pstmt.setInt(4, targetId);
			recommend = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return recommend;
	}
	
	public int deleteRecommend(Connection conn, String userId, int recType, String boardType, int targetId) {
		int recommend = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("deleteRecommend"));
			pstmt.setString(1, userId);
			pstmt.setInt(2, recType);
			pstmt.setString(3, boardType);
			pstmt.setInt(4, targetId);
			recommend = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return recommend;
	}
	
	public int searchRecommend(Connection conn, String userId, int recType, String boardType, int targetId) {
		int recommendFlag = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchRecommend"));
			pstmt.setString(1, userId);
			pstmt.setInt(2, recType);
			pstmt.setString(3, boardType);
			pstmt.setInt(4, targetId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				recommendFlag = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return recommendFlag;
	}
	
	public int increaseRecommend(Connection conn, int recType, String boardType, int targetId) {
		int changeArticle = 0;
		try {
			String sql = sqlPro.getProperty("increaseRecommend");
			String boards = boardType.equals("ARTICLE")? "ARTICLE" : "COMMENT";
			String ld = recType == 0? "DISLIKES" : "LIKES";
			sql=sql.formatted(boardType.equals("ARTICLE")? "ARTICLE" : "COMMENTS", boards + "_" + ld, boards + "_" + ld, boards + "_ID");
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, targetId);
			changeArticle = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return changeArticle;
	}
	
	public int decreaseRecommend(Connection conn, int recType, String boardType, int targetId) {
		int changeArticle = 0;
		try {
			String sql = sqlPro.getProperty("decreaseRecommend");
			String boards = boardType.equals("ARTICLE")? "ARTICLE" : "COMMENT";
			String ld = recType == 0? "DISLIKES" : "LIKES";
			sql=sql.formatted(boardType.equals("ARTICLE")? "ARTICLE" : "COMMENTS", boards + "_" + ld, boards + "_" + ld, boards + "_ID");
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, targetId);
			changeArticle = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return changeArticle;
	}
	
	public int saveComment(Connection conn, String userId, int articleId, String content, int targetId, int level) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("saveComment"));
			pstmt.setString(1, userId);
			pstmt.setInt(2, articleId);
			pstmt.setString(3, content);
			if(level == 0) pstmt.setNull(4, java.sql.Types.NUMERIC);
			else pstmt.setInt(4, targetId);
			pstmt.setInt(5, level);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int saveArticle(Connection conn, Article article) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("saveArticle"));
			pstmt.setString(1, article.userId());
			pstmt.setString(2, article.articleTitle());
			pstmt.setString(3, article.articleContent());
			pstmt.setTimestamp(4, article.articleDateTime());
			pstmt.setInt(5, article.articleCategory());
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int increaseView(Connection conn, int articleId) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("increaseView"));
			pstmt.setInt(1, articleId);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int updateArticle(Connection conn, Article article) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("updateArticle"));
			pstmt.setString(1, article.articleTitle());
			pstmt.setInt(2, article.articleCategory());
			pstmt.setString(3, article.articleContent());
			pstmt.setInt(4, article.articleId());			
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int deleteArticle(Connection conn, int articleId) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("deleteArticle"));
			pstmt.setInt(1, articleId);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int updateComment(Connection conn, Comment comment) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("updateComment"));
			pstmt.setString(1, comment.commentContent());
			pstmt.setInt(2, comment.commentId());
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int deleteComment(Connection conn, int commentId) {
		int result = 0;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("deleteComment"));
			pstmt.setInt(1, commentId);
			pstmt.setInt(2, commentId);
			result = pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public List<Notice> searchNotice(Connection conn){
		List<Notice> notices = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchNotice"));
			rs = pstmt.executeQuery();
			while(rs.next()) {
				notices.add(Notice.builder()
								  .noticeId(rs.getInt("notice_id"))
								  .noticeTitle(rs.getString("notice_title"))
								  .build());
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return notices;
	}
	
	
	public Notice searchNoticeById(Connection conn, int noticeId){
		Notice notice = null;
		try {
			pstmt = conn.prepareStatement(sqlPro.getProperty("searchNoticeById"));
			pstmt.setInt(1, noticeId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				notice = Notice.builder()
								.noticeId(rs.getInt("notice_id"))
								.noticeTitle(rs.getString("notice_title"))
								.noticeContent(rs.getString("notice_content"))
								.build();
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return notice;
	}
	
	

}
