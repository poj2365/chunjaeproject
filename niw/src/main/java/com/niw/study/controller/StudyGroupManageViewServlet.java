package com.niw.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.common.CommonTemplate;
import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.GroupRequest;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.GroupRequestService;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class StudyGroupManageViewServlet
 */
@WebServlet("/study/groupmanageview.do")
public class StudyGroupManageViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudyGroupManageViewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String groupNumber = request.getParameter("groupNumber");
		request.setAttribute("groupNumber", Integer.parseInt(groupNumber));
		List<GroupMember> members = GroupMemberService.SERVICE.searchGroupMember(groupNumber);
		request.setAttribute("members", members);
		List<GroupRequest> groupRequests = GroupRequestService.SERVICE.searchGroupRequestAll(groupNumber);
		request.setAttribute("groupRequests", groupRequests);
		
		request.getRequestDispatcher(CommonTemplate.WEB_VIEWS+"/study/studyGroupManage.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
