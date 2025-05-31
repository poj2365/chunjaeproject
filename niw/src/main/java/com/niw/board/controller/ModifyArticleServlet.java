package com.niw.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.board.model.dto.Article;
import com.niw.board.service.BoardService;


@WebServlet("/board/modifyarticle.do")
public class ModifyArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ModifyArticleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		Article article = BoardService.SERVICE.searchArticleById(articleId);
		request.setAttribute("article", article);
		request.getRequestDispatcher("/WEB-INF/views/board/boardupdate.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
