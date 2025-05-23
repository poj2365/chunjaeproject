package com.niw.study.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.study.model.dto.Calendar;
import com.niw.study.model.service.CalendarService;

/**
 * Servlet implementation class CalendarInsertServlet
 */
@WebServlet("/study/calendarsave.do")
public class CalendarSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarSaveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonData = request.getReader().lines().collect(Collectors.joining());
		Gson gson = new Gson();
		Calendar c = gson.fromJson(jsonData, Calendar.class);
//		Calendar c = Calendar.builder()
//				.calendarName(name)
//				.calendarContent(content)
//				.startTime(start)
//				.endTime(end)
//				.build();
		int result = CalendarService.SERVICE.insertCalendar(c);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
