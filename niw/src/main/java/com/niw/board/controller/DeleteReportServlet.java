package com.niw.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.service.BoardService;


@WebServlet("/board/deleteReport.do")
public class DeleteReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DeleteReportServlet() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reportId = Integer.parseInt(request.getParameter("reportId"));
		int result = BoardService.SERVICE.deleteReportByAdmin(reportId);
		response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write(new Gson().toJson(result));
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
