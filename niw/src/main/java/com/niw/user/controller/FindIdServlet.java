package com.niw.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.niw.user.model.service.UserService;

/**
 * Servlet implementation class FindIdServlet
 */
@WebServlet("/user/idpwfinda.do")
public class FindIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
           
       }
   


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("name");
		String userEmail = request.getParameter("email");
		String userId = UserService.USERSERVICE.findId(userName, userEmail);
	System.out.println(userName);
		System.out.println(userEmail);
		System.out.println(userId);
		
		JSONObject jsonResponse = new JSONObject();
           if (userId != null) {
               jsonResponse.put("success", true);
               jsonResponse.put("userId", userId);
           } else {
               jsonResponse.put("success", false);
               jsonResponse.put("message", "일치하는 회원 정보가 없습니다.");
           }
           response.setContentType("application/json; charset=UTF-8");
           response.getWriter().write(jsonResponse.toString());
           
           response.getWriter().flush();
           response.getWriter().close();

           
		
	}

}
