package com.niw.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.user.model.dto.User;
import com.niw.user.model.service.UserService;

/**
 * Servlet implementation class UserUpdateServlet
 */
@WebServlet("/user/update.do")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");
		String userId=loginUser.userId();
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		int result=0;
		result=UserService.USERSERVICE.updateUser(userId, phone, address);
		
		if(result>0) {
		User updatedUser = UserService.USERSERVICE.searchById(userId);	
		session.setAttribute("loginUser", updatedUser);
		request.getRequestDispatcher("/WEB-INF/views/user/mypage/mypage.jsp").forward(request, response);
	}

	}
}
