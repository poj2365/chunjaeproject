package com.niw.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserIdPwFindServlet
 */
@WebServlet("/useridpwfinda.do")
public class UserIdPwFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserIdPwFindServlet() {
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
		
		
        String userName = request.getParameter("name");
        String birthYear = request.getParameter("birthYear");
        String birthMonth = request.getParameter("birthMonth");
        String birthDay = request.getParameter("birthDay");
        String userPhone = request.getParameter("phone");
        String userEmail = request.getParameter("email");
       
        String birthDateStr = String.format("%s-%02d-%02d",
                birthYear,
                Integer.parseInt(birthMonth),
                Integer.parseInt(birthDay)
            );
            Date userBirthDate = Date.valueOf(birthDateStr);
	
            
      
		
		
		
	}

}
