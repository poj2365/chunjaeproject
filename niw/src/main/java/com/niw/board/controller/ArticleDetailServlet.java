package com.niw.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.board.model.dto.Article;
import com.niw.board.model.dto.Comment;
import com.niw.board.service.BoardService;

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
		request.setAttribute("article", article);
		request.setAttribute("comments", comment);
		request.getRequestDispatcher("/WEB-INF/views/board/boarddetail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
