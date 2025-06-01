package com.niw.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.StudyGroup;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.StudyGroupService;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class StudyGroupDetail
 */
@WebServlet("/study/groupdetail.do")
public class StudyGroupDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudyGroupDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		if(user!=null) {			
			List<StudyGroup> groups = StudyGroupService.SERVICE.searchStudyGroupUserId(user.userId());
			request.setAttribute("groups", groups);
			List<GroupMember> members = GroupMemberService.SERVICE.searchGroupMemberId(user.userId());
			request.setAttribute("members", members);
			System.out.println(groups);
			System.out.println(members);
		}
		
		request.getRequestDispatcher("/WEB-INF/views/study/studyGroupDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
