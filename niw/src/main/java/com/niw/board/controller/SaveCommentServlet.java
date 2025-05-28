package com.niw.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.board.service.BoardService;
import com.niw.user.model.dto.User;

@WebServlet("/board/savecomment.do")
public class SaveCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveCommentServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");
		String articleData = url.split("&")[0];
		int articleId = Integer.parseInt(articleData.split("=")[1]);
		
		int level = Integer.parseInt(request.getParameter("level"));
		int targetId = Integer.parseInt(request.getParameter("targetId"));
		String content = request.getParameter("commentTextarea");
		String userId = ((User) request.getSession().getAttribute("loginUser")).userId();
		int result = BoardService.SERVICE.saveComment(userId, articleId, content, targetId, level);
		response.sendRedirect(request.getContextPath() + "/board/boarddetail.do?" + url);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
