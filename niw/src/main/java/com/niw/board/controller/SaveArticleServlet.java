package com.niw.board.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.board.model.dto.Article;
import com.niw.board.service.BoardService;
import com.niw.user.model.dto.User;

@WebServlet("/board/savearticle.do")
public class SaveArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveArticleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		int category = Integer.parseInt(request.getParameter("category"));
		int date = Integer.parseInt(request.getParameter("date"));
		Timestamp datetime = null;
		long hour = 3600 * 1000;
		switch(date) {
			case 1: datetime = new Timestamp(System.currentTimeMillis() + hour); break;
			case 3: datetime = new Timestamp(System.currentTimeMillis() + 3 * hour); break;
			case 24: datetime = new Timestamp(System.currentTimeMillis() + 24 * hour); break;
			case -1: 
				String dateStr = request.getParameter("custom");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				java.util.Date parsedDate = null;
				try {
					parsedDate = sdf.parse(dateStr);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				datetime = new Timestamp(parsedDate.getTime());
			break;
			default: datetime = new Timestamp(System.currentTimeMillis()); break;
		}
		String content = request.getParameter("content");
		String userId = ((User) request.getSession().getAttribute("loginUser")).userId();
		int result = BoardService.SERVICE.saveArticle(Article.builder()
															 .userId(userId)
															 .articleCategory(category)
															 .articleDateTime(datetime)
															 .articleTitle(title)
															 .articleContent(content)
															 .build());
		response.sendRedirect(request.getContextPath() + "/board/boardentrance.do?category=" + category);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
