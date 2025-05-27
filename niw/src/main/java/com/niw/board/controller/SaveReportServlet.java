package com.niw.board.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.board.service.BoardService;


@WebServlet("/board/report.do")
public class SaveReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public SaveReportServlet() {
        super();
     
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BufferedReader reader = request.getReader();
		Gson gson = new Gson();
		Map<String, Object> reportData = gson.fromJson(reader, Map.class);
		System.out.println(reportData);
		String userId = (String) reportData.get("userId");
		int targetId = Integer.parseInt((String) reportData.get("targetId"));
		String targetType = (String) reportData.get("targetType");
		String reason = (String) reportData.get("reason");
		String details = reportData.get("details") == null? null : (String) reportData.get("details");
		int result = BoardService.SERVICE.searchReport(userId, targetId, targetType);
		int report = 0;
		if(result == 0) {
			report = BoardService.SERVICE.saveReport(userId, targetId, targetType, reason, details);
		}
		
		new Gson().toJson(Map.of("reportFlag", result, "report", report),response.getWriter());
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
