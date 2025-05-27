package com.niw.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.board.model.dto.Article;
import com.niw.board.model.dto.Comment;
import com.niw.board.service.BoardService;
import com.niw.user.model.dto.User;

@WebServlet("/board/boarddetail.do")
public class ArticleDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ArticleDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		Article article = BoardService.SERVICE.searchArticleById(articleId);
		List<Comment> comment = BoardService.SERVICE.searchCommentByArticle(articleId);
		int category = request.getParameter("category") == null? 0 :Integer.parseInt(request.getParameter("category"));
		String searchData = request.getParameter("searchData") == null? "" : request.getParameter("searchData");
		int order = request.getParameter("order") == null? 0 : Integer.parseInt(request.getParameter("order"));
		String searchOrder = null;
		switch(order) {
		case 0 : searchOrder = "ARTICLE_DATETIME"; break;
		case 1 : searchOrder = "ARTICLE_LIKES"; break;
		case 2 : searchOrder = "ARTICLE_VIEWS"; break;
		default: searchOrder = "ARTICLE_DATETIME"; break;
		}
		int numPerPage = request.getParameter("numPerPage") == null ? 10: Integer.parseInt(request.getParameter("numPerPage"));
		int likes = request.getParameter("likes") == null? 0 : Integer.parseInt(request.getParameter("likes"));
		int cPage = request.getParameter("cPage") == null? 1 : Integer.parseInt(request.getParameter("cPage"));
		int pageBarSize = 5;
		int totalData = BoardService.SERVICE.countArticle(category, searchData, likes);
		int totalPage = (totalData - 1) / numPerPage + 1; 
		int pageNo = 1, pageEnd = totalPage;
		if(pageBarSize < totalPage) {
			if(pageBarSize / 2 < cPage && cPage < totalPage - pageBarSize / 2) {
				pageNo = cPage - pageBarSize / 2;
				pageEnd = cPage + pageBarSize / 2;
			} else {
				if(cPage <= pageBarSize / 2) pageEnd = pageBarSize;
				if(cPage >= totalPage - pageBarSize / 2) pageNo = totalPage - pageBarSize + 1;
			}
		}
		StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");
		if(cPage == 1) {
			pageBar.append("<li class='page-item disabled'>");
			pageBar.append("<a class='page-link' href='#'> prev </a>");
			pageBar.append("</li>");
		} else {
			pageBar.append("<li class='page-item '>");
			pageBar.append("<a class='page-link' href='javascript:void(0);' onclick=\"searchArticle('" + (pageNo > 1? pageNo - 1 : 1) + "', '/board/underarticle.do')\"> prev </a>");
			pageBar.append("</li>");
		}
		for(int i = pageNo; i <= pageEnd; i++) {
			if(i == cPage) {
				pageBar.append("<li class='page-item disabled'>");
				pageBar.append("<a class='page-link' href='#'>"+ i + "</a>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<a class='page-link' href='javascript:void(0);' onclick=\"searchArticle('" + i +"', '/board/underarticle.do')\"> " + i + " </a>");
			}
			pageBar.append("</li>");
		}
		if(cPage == totalPage) {
			pageBar.append("<li class='page-item disabled'>");
			pageBar.append("<a class='page-link' href='#'> next </a>");
		} else {
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='javascript:void(0);' onclick=\"searchArticle('" + (pageEnd < totalPage? pageEnd + 1 : totalPage) +"', '/board/underarticle.do')\"> next </a>");
		}
		pageBar.append("</li>");
		pageBar.append("</ul>");
		List<Article> articles = BoardService.SERVICE.searchArticle(category, searchData, likes, searchOrder, cPage, numPerPage, totalData);
		HttpSession session = request.getSession();
		int bookmark = 0, report = 0, likedArticle = 0, dislikedArticle = 0;
		List<Integer> reportedComment = new ArrayList<>();
		List<Integer> likedComment = new ArrayList<>();
		List<Integer> dislikedComment = new ArrayList<>();
		if(session.getAttribute("loginUser") != null) {
			String userId = ((User) session.getAttribute("loginUser")).userId();
			bookmark = BoardService.SERVICE.searchBookmark(userId, articleId);
			report = BoardService.SERVICE.searchReport(userId, article.articleId() , "ARTICLE");
			likedArticle = BoardService.SERVICE.searchRecommend(userId, 1, "ARTICLE", article.articleId());
			dislikedArticle = BoardService.SERVICE.searchRecommend(userId, 0, "ARTICLE", article.articleId());
			for(Comment c : comment) {
				reportedComment.add(BoardService.SERVICE.searchReport(userId, c.commentId(), "COMMENTS"));
				likedComment.add(BoardService.SERVICE.searchRecommend(userId, 1, "COMMENTS", c.commentId()));
				dislikedComment.add(BoardService.SERVICE.searchRecommend(userId, 0, "COMMENTS", c.commentId()));
			}
		}
		while(reportedComment.size() < comment.size()) reportedComment.add(0);
		while(likedComment.size() < comment.size()) likedComment.add(0);
		while(dislikedComment.size() < comment.size()) dislikedComment.add(0);
		
		request.setAttribute("bookmark", bookmark);
		request.setAttribute("report", report);
		request.setAttribute("likedArticle", likedArticle);
		request.setAttribute("dislikedArticle", dislikedArticle);
		request.setAttribute("article", article);
		request.setAttribute("category", category);
		request.setAttribute("searchData", searchData);
		request.setAttribute("order", order);
		request.setAttribute("numPerPage", numPerPage);
		request.setAttribute("likes", likes);
		request.setAttribute("cPage", cPage);
		request.setAttribute("articles", articles);
		request.setAttribute("pageBar", pageBar);
		request.setAttribute("comments", comment);
		request.setAttribute("reportedComment", reportedComment);
		request.setAttribute("likedComment", likedComment);
		request.setAttribute("dislikedComment", dislikedComment);
		request.getRequestDispatcher("/WEB-INF/views/board/boarddetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
