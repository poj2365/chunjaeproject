package com.niw.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.common.CommonTemplate;
import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.StudyGroup;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.StudyGroupService;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class StudyGroupViewServlet
 */
@WebServlet("/study/groupview.do")
public class StudyGroupViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudyGroupViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		int groupLimit = 0;
		if(user!=null) {
			groupLimit = GroupMemberService.SERVICE.groupMemberCountId(user.userId());
		}
		request.setAttribute("groupLimit", groupLimit);
		
		
		String groupNo = request.getParameter("no");
		StudyGroup group = StudyGroupService.SERVICE.searchStudyGroup(groupNo);
		request.setAttribute("group", group);
		int groupCnt = GroupMemberService.SERVICE.groupMemberCount(groupNo);
		request.setAttribute("groupCnt", groupCnt);
		
		List<GroupMember> members = GroupMemberService.SERVICE.searchGroupMember(groupNo);
		request.setAttribute("members", members);
		request.getRequestDispatcher(CommonTemplate.WEB_VIEWS+"/study/studyGroupView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
