package com.niw.board.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.model.dto.Article;
import com.niw.board.service.BoardService;
import com.niw.user.model.dto.User;

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
		int category = Integer.parseInt(((String) restrictData.get("category")));
		String order = null;
		switch(Integer.parseInt((String) restrictData.get("order"))) {
			case 0 : order = "ARTICLE_DATETIME"; break;
			case 1 : order = "ARTICLE_LIKES"; break;
			case 2 : order = "ARTICLE_VIEWS"; break;
			default: order = "ARTICLE_DATETIME"; break;
		}
		int numPerPage = Integer.parseInt((String) restrictData.get("numPerPage"));
		int likes = Integer.parseInt((String) restrictData.get("likes"));
		String searchData = ((String) restrictData.get("searchData")) == null? "" : (String) restrictData.get("searchData");
		int cPage = 1;
		try{
			cPage = Integer.parseInt((String) restrictData.get("cPage"));
		} catch(NumberFormatException e) {
			
		}
		String url = (String) restrictData.get("url");
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
			pageBar.append("<a class='page-link' href='javascript:void(0);' onclick=\"searchArticle('" + (pageNo > 1? pageNo - 1 : 1) + "', '" + url + "')\"> prev </a>");
			pageBar.append("</li>");
		}
		for(int i = pageNo; i <= pageEnd; i++) {
			if(i == cPage) {
				pageBar.append("<li class='page-item disabled'>");
				pageBar.append("<a class='page-link' href='#'>"+ i + "</a>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append("<a class='page-link' href='javascript:void(0);' onclick=\"searchArticle('" + i +"', '" + url + "')\"> " + i + " </a>");
			}
			pageBar.append("</li>");
		}
		if(cPage == totalPage) {
			pageBar.append("<li class='page-item disabled'>");
			pageBar.append("<a class='page-link' href='#'> next </a>");
		} else {
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='javascript:void(0);' onclick=\"searchArticle('" + (pageEnd < totalPage? pageEnd + 1 : totalPage) +"', '" + url + "')\"> next </a>");
		}
		pageBar.append("</li>");
		pageBar.append("</ul>");
		List<Article> articles = BoardService.SERVICE.searchArticle(category, searchData, likes, order, cPage, numPerPage, totalData);
		User user = (User) request.getSession().getAttribute("loginUser");
		String userId = "";
		String userRole = "GENERAL";
		if(user != null) {
			userId = user.userId();
			userRole = user.userRole();
		}
		new Gson().toJson(Map.of("articles",articles, "pageBar", pageBar, "userId", userId, "userRole", userRole),response.getWriter());
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
