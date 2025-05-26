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

@WebServlet("/board/articlelist.do")
public class ArticleListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ArticleListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		Map<String, Object> restrictData = gson.fromJson(reader, Map.class);
		System.out.println(restrictData);
		int category = Integer.parseInt((String) restrictData.get("category"));
		String order = null;
		switch(Integer.parseInt((String) restrictData.get("order"))) {
			case 0 : order = "ARTICLE_DATETIME"; break;
			case 1 : order = "ARTICLE_LIKES"; break;
			case 2 : order = "ARTICLE_VIEWS"; break;
			default: order = "ARTICLE_DATETIME"; break;
		}
		int numPerPage = Integer.parseInt((String) restrictData.get("numPerPage"));
		int likes = Integer.parseInt((String) restrictData.get("likes"));
		int cPage = 1;
		int pageBarSize = 5;
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
