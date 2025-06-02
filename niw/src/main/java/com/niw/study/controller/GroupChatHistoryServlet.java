package com.niw.study.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.study.model.dto.Message;
import com.niw.study.model.service.GroupChatService;

/**
 * Servlet implementation class GroupChatHistoryServlet
 */
@WebServlet("/study/groupchathistory.do")
public class GroupChatHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GroupChatHistoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String groupNumber = request.getParameter("groupNumber");
		List<Message> msgList = GroupChatService.SERVICE.searchGroupChat(groupNumber);
		System.out.println(msgList);
		
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(msgList,response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
