package com.niw.board.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.service.BoardService;

@WebServlet("/board/deletearticle.do")
public class DeleteArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DeleteArticleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader reader = request.getReader();
//		String reader = request.getReader().lines().collect(Collectors.joining());
		Gson gson = new Gson();
		Map<String, Object> deleteData = gson.fromJson(reader, Map.class);
		int articleId = -1;
		if(deleteData.get("articleId") instanceof Double) articleId = (int)(double)deleteData.get("articleId");
		else if(deleteData.get("articleId") instanceof String) articleId = Integer.parseInt((String) deleteData.get("articleId"));
		int result = BoardService.SERVICE.deleteArticle(articleId);
		gson.toJson(Map.of("flag", result),response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
