package com.niw.study.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.common.CommonTemplate;
import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.StudyGroup;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.StudyGroupService;

/**
 * Servlet implementation class StudyGroupCreateServlet
 */
@WebServlet("/study/groupcreate.do")
public class StudyGroupCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudyGroupCreateServlet() {
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
		int result = StudyGroupService.SERVICE.insertGroup(g);
		System.out.println(result);
		if(result>0) {
			g = StudyGroupService.SERVICE.searchStudyGroupId(g);
			System.out.println(g);
			response.setContentType("application/json;charset=utf-8");
			new Gson().toJson(g,response.getWriter());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
