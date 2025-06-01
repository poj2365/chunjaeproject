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

import com.google.gson.Gson;
import com.niw.study.model.dto.TimeRecord;
import com.niw.study.model.service.TimeRecordService;

/**
 * Servlet implementation class StudyGroupRankServlet
 */
@WebServlet("/study/grouprank.do")
public class StudyGroupRankServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudyGroupRankServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String groupNumber = request.getParameter("groupNumber");
		LocalDate today = LocalDate.now(); // 오늘 날짜
		LocalDateTime startDate = today.atStartOfDay();
		LocalDateTime endDate = startDate.plusDays(1);

		List<TimeRecord> trListGroup = TimeRecordService.SERVICE.searchTimeTodayGroup(groupNumber,startDate, endDate);
		
		System.out.println(groupNumber);
		System.out.println(startDate);
		System.out.println(endDate);
		System.out.println(trListGroup);
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(trListGroup,response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
