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
 * Servlet implementation class GroupMemberUpdateServlet
 */
@WebServlet("/study/updategroupmember.do")
public class GroupMemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupMemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String groupNumber = request.getParameter("groupNumber");
		String status = "APPROVED";
		int result = GroupRequestService.SERVICE.updateGroupRequest(userId,groupNumber,status);
		int updateMember = GroupMemberService.SERVICE.updateGroupMember(userId,groupNumber,status);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
