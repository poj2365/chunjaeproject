package com.niw.study.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.niw.study.model.dto.Calendar;
import com.niw.study.model.service.CalendarService;

/**
 * Servlet implementation class CalendarSearchServlet
 */
@WebServlet("/study/calendarsearchbydate.do")
public class CalendarSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonData = request.getReader().lines().collect(Collectors.joining());
//		Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, jsonData);
//		시리얼라이징 하면 가능
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		Calendar c = gson.fromJson(jsonData, Calendar.class);
		Calendar calList = CalendarService.SERVICE.searchCalendarById(c);
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(calList,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
