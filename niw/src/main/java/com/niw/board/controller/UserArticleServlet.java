package com.niw.board.controller;

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

@WebServlet("/user/myPosts.do")
public class UserArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UserArticleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loginUser");
		if(user != null) {
			int category = 0;
			int cPage = 1, numPerPage = 10, pageBarSize = 5;
			if(request.getParameter("cPage") != null) {
				cPage = Integer.parseInt(request.getParameter("cPage"));
			}
			int totalData = BoardService.SERVICE.countArticle(category, "", 0);
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
			
			StringBuilder pageBar = new StringBuilder("<ul class='pagination justify-content-center'>");
	        if (cPage == 1) {
	            pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>prev</a></li>");
	        } else {
	            pageBar.append("<li class='page-item'><a class='page-link' href='")
	                   .append(request.getContextPath())
	                   .append("/user/myPosts.do?cPage=")
	                   .append(cPage - 1)
	                   .append("'>prev</a></li>");
	        }

	        for (int i = pageNo; i <= pageEnd; i++) {
	            if (i == cPage) {
	                pageBar.append("<li class='page-item active'><a class='page-link' href='#'>").append(i).append("</a></li>");
	            } else {
	                pageBar.append("<li class='page-item'><a class='page-link' href='")
	                       .append(request.getContextPath())
	                       .append("/user/myPosts.do?cPage=")
	                       .append(i)
	                       .append("'>")
	                       .append(i)
	                       .append("</a></li>");
	            }
	        }

	        if (cPage == totalPage) {
	            pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>next</a></li>");
	        } else {
	            pageBar.append("<li class='page-item'><a class='page-link' href='")
	                   .append(request.getContextPath())
	                   .append("/user/myPosts.do?cPage=")
	                   .append(cPage + 1)
	                   .append("'>next</a></li>");
	        }

	        pageBar.append("</ul>");
			
	        List<Article> articles = BoardService.SERVICE.searchArticleByUser(
	                user.userId(), "ARTICLE_DATETIME", cPage, numPerPage, totalData);

	        response.setContentType("application/json; charset=UTF-8");
	        response.getWriter().write(new Gson().toJson(Map.of(
	            "articles", articles,
	            "url", request.getContextPath() + "/boarddetail.do?articleId=",
	            "totalPages", totalPage
	        )));
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
