package com.niw.board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.model.dto.Article;
import com.niw.board.service.BoardService;

@WebServlet("/main/article.do")
public class MainArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MainArticleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchData = new Gson().fromJson(request.getReader(), String.class);
		List<Article> articles = BoardService.SERVICE.searchArticleByRecommend(10, searchData, 5);
		response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write(new Gson().toJson(articles));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
