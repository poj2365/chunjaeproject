package com.niw.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.user.model.dto.User;
import com.niw.user.model.service.UserService;

/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet("/user/login.do")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginServlet() {
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
		String userId = request.getParameter("username");
		String password = request.getParameter("password");
		
		String saveId=request.getParameter("rememberMe");
				
				Cookie  cookie = new Cookie("saveId", userId);
				if(saveId!=null) {
					
					cookie.setMaxAge(60*60*24);
					cookie.setPath("/");
					response.addCookie(cookie);
					
					
				}else {
					cookie.setMaxAge(0);
					cookie.setPath("/");
					response.addCookie(cookie);
				}
		
		//String saveId=request.getParameter("saveId");
		
		User user =UserService.USERSERVICE.searchById(userId);
		//String username=user.getUserName();
		
		if(user!=null&&user.password().equals(password)) {

			
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);
			System.out.println("로그인성공");
			response.sendRedirect(request.getContextPath());
		
			
		}else{
		request.setAttribute("msg","아이디나 패스워드가 일치하지 않습니다. :(");
		request.setAttribute("loc", "/user/loginview.do");
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			
		}
		
	}

}
