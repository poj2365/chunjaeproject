package com.niw.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.board.model.dto.Comment;
import com.niw.board.service.BoardService;

@WebServlet("/board/updatecomment.do")
public class UpdateCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateCommentServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int commentId = Integer.parseInt(request.getParameter("commentId"));
		String content = request.getParameter("commentTextarea");
		int result = BoardService.SERVICE.updateComment(Comment.builder()
																.commentId(commentId)
																.commentContent(content)
																.build());
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		response.sendRedirect(request.getContextPath() + "/board/boarddetail.do?articleId=" + articleId);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
