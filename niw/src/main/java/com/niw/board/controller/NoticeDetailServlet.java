package com.niw.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.board.model.dto.Notice;
import com.niw.board.service.BoardService;

@WebServlet("/board/noticedetail.do")
public class NoticeDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeId = Integer.parseInt(request.getParameter("noticeId"));
		Notice notice = BoardService.SERVICE.searchNoticeById(noticeId);
		request.setAttribute("notice", notice);
		request.getRequestDispatcher("/WEB-INF/views/board/boardnotice.jsp").forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
