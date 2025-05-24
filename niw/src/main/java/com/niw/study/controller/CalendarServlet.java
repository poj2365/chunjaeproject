package com.niw.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.study.model.dto.Calendar;
import com.niw.study.model.dto.TimeRecord;
import com.niw.study.model.service.CalendarService;
import com.niw.study.model.service.TimeRecordService;

/**
 * Servlet implementation class CalenderServlet
 */
@WebServlet("/study/calender.do")
public class CalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = "user_0001";
		List<TimeRecord> trList = TimeRecordService.SERVICE.searchTime(userId);
		List<Calendar> c = CalendarService.SERVICE.searchCalendar(userId);
		request.setAttribute("calendar", c);
		request.setAttribute("trList", trList);
		request.getRequestDispatcher("/WEB-INF/views/study/calender.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
