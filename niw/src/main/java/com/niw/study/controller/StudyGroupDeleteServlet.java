package com.niw.study.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.common.CommonTemplate;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.StudyGroupService;

/**
 * Servlet implementation class StudyGroupDeleteServlet
 */
@WebServlet("/study/deletegroup.do")
public class StudyGroupDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudyGroupDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String groupNumber = request.getParameter("groupNumber");
		int memberDelete = GroupMemberService.SERVICE.deleteGroupMember(groupNumber);
		int result = StudyGroupService.SERVICE.deleteGroup(groupNumber);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
