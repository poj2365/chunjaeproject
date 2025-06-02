package com.niw.study.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.study.model.dto.StudyGroup;
import com.niw.study.model.service.StudyGroupService;

/**
 * Servlet implementation class StudyGroupUpdateServlet
 */
@WebServlet("/study/updategroup.do")
public class StudyGroupUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudyGroupUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonData = request.getReader().lines().collect(Collectors.joining());
		Gson gson = new Gson();
		StudyGroup g = gson.fromJson(jsonData, StudyGroup.class);
		int result = StudyGroupService.SERVICE.updateGroup(g);
		System.out.println(g);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
