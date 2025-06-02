package com.niw.study.controller;

import java.io.IOException;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.study.model.dto.GroupMember;
import com.niw.study.model.dto.GroupRequest;
import com.niw.study.model.dto.StudyGroup;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.GroupRequestService;
import com.niw.study.model.service.StudyGroupService;

/**
 * Servlet implementation class StudyGroupRequestServlet
 */
@WebServlet("/study/insertgrouprequest.do")
public class GroupRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupRequestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String jsonData = request.getReader().lines().collect(Collectors.joining());
		Gson gson = new Gson();
		GroupRequest gr = gson.fromJson(jsonData, GroupRequest.class);
		GroupMember gm = gson.fromJson(jsonData, GroupMember.class);
			
		GroupRequest groupRequest = GroupRequestService.SERVICE.searchGroupRequest(gr);
		if(groupRequest==null) {
			int result = GroupRequestService.SERVICE.insertGroupRequest(gr);
			int insertMember =  GroupMemberService.SERVICE.insertGroupMember(gm);
		}else {
			  response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			  response.setContentType("application/json");
		      return;
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
