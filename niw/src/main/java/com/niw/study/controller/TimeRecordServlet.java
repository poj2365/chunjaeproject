package com.niw.study.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.study.model.dto.TimeRecord;
import com.niw.study.model.service.TimeRecordService;

/**
 * Servlet implementation class TimeRecordServlet
 */
@WebServlet("/study/timerecord.do")
public class TimeRecordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TimeRecordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = "user_0001";
		LocalDate today = LocalDate.now(); // 오늘 날짜
		LocalDateTime startDate = today.atStartOfDay();
		LocalDateTime endDate = today.atTime(LocalTime.MAX);

		List<TimeRecord> trList = TimeRecordService.SERVICE.searchTimeToday(userId, startDate, endDate);
		request.setAttribute("trList", trList);
		request.getRequestDispatcher("/WEB-INF/views/study/timeRecord.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
