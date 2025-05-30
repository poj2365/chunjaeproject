package com.niw.study.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.GroupRequestService;

/**
 * Servlet implementation class GroupMemberRejectServlet
 */
@WebServlet("/study/rejectmember.do")
public class GroupMemberRejectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupMemberRejectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("MemberId");
		String groupNumber = request.getParameter("groupNumber");
		String status = "REJECT";
		int result = GroupRequestService.SERVICE.updateGroupRequest(userId,groupNumber,status);
		int deleteMember = GroupMemberService.SERVICE.deleteGroupMemberById(userId,groupNumber);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
