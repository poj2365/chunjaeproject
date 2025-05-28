package com.niw.point.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.point.model.dto.PointHistory;
import com.niw.point.model.service.PointService;


@WebServlet("/point/pointhistory.do")
public class PointHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public PointHistoryServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<PointHistory> historys = PointService.ponitService().searchPointHistory(request.getParameter("userId"));
		request.setAttribute("historys", historys);
		request.getRequestDispatcher("/WEB-INF/views/point/myPoint.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
