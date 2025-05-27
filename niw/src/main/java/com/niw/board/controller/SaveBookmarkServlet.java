package com.niw.board.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.service.BoardService;


@WebServlet("/board/savebookmark.do")
public class SaveBookmarkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveBookmarkServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		Map<String, Object> data = gson.fromJson(reader, Map.class);
		String bookmarkFlag = (String) data.get("bookmarkFlag");
		String userId = (String) data.get("userId");
		String articleId = (String) data.get("articleId");
		int result = 0;
		switch(bookmarkFlag) {	
			case "0": result = BoardService.SERVICE.saveBookmark(userId, articleId); break;
			case "1": result = BoardService.SERVICE.deleteBookmark(userId, articleId); break;
		}
		new Gson().toJson(Map.of("result", result, "bookmarkFlag", bookmarkFlag), response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
