package com.niw.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.study.model.dto.Calendar;
import com.niw.study.model.dto.TimeRecord;
import com.niw.study.model.service.CalendarService;
import com.niw.study.model.service.StudyGroupService;
import com.niw.study.model.service.TimeRecordService;
import com.niw.user.model.dto.User;

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
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		List<Calendar> c = null;
		List<TimeRecord> trList = null;
		if(user!=null) {
			trList = TimeRecordService.SERVICE.searchTime(user.userId());
			c = CalendarService.SERVICE.searchCalendar(user.userId());
		}
		
		request.setAttribute("calendar", c);
		request.setAttribute("trList", trList);
		request.getRequestDispatcher("/WEB-INF/views/study/calendar.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
