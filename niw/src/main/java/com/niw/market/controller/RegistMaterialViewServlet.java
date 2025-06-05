package com.niw.market.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.instructor.model.dto.InstructorApplication;
import com.niw.instructor.model.service.InstructorApplicationService;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class RegistMaterialViewServlet
 */
@WebServlet("/market/materialregist.do")
public class RegistMaterialViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistMaterialViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User loginUser = (User)session.getAttribute("loginUser");
		String id = loginUser.userId();
		InstructorApplication application=InstructorApplicationService.SERVICE.searchbyUserId(id);
		String introduce = application.introduction();
		
		request.setAttribute("introduce", introduce);
		request.getRequestDispatcher("/WEB-INF/views/market/materialregist.jsp").forward(request, response);
	}	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
