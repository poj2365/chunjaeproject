package com.niw.study.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.study.model.dto.TimeRecord;
import com.niw.study.model.service.TimeRecordService;

/**
 * Servlet implementation class TimerServlet
 */
@WebServlet("/study/timesave.do")
public class TimeSaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TimeSaveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonData = request.getReader().lines().collect(Collectors.joining());
		Gson gson = new Gson();
		TimeRecord tr = gson.fromJson(jsonData, TimeRecord.class);
		int result = TimeRecordService.SERVICE.insertTime(tr);
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(result,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
