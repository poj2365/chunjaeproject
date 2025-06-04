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
 * Servlet implementation class ChangePasswordServlet
 */
@WebServlet(name="changePassword",urlPatterns="/user/changePassword.do")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
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
		User user = UserService.USERSERVICE.searchById(userId);
		String curPassword=request.getParameter("currentPwd");
		System.out.println(curPassword);
		String password=request.getParameter("newPwd");
		System.out.println(password);
		if(password.equals(curPassword)) {
		UserService.USERSERVICE.updateUserPassword(userId, password);
		System.out.println("변경성공");
		}
		User updatedUser=UserService.USERSERVICE.searchById(userId);
		session.setAttribute("loginUser", updatedUser);
		request.getRequestDispatcher("/WEB-INF/views/user/mypage/mypage.jsp").forward(request, response);
	}

}
