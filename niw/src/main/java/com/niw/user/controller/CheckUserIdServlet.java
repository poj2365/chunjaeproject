package com.niw.user.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.user.model.dto.User;
import com.niw.user.model.service.UserService;

/**
 * Servlet implementation class CheckUserIdServlet
 */
@WebServlet("/user/checkUserId.do")
public class CheckUserIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckUserIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String userid = request.getParameter("id");
		 System.out.println(userid);
		 User user= UserService.USERSERVICE.searchById(userid);
		 
		 new Gson().toJson(Map.of("result",user==null),response.getWriter());
		 
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 
		 

}
}
