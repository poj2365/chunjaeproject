package com.niw.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.common.CommonTemplate;


@WebServlet("/admin/adminpage/refund.do")
public class AdminRefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public AdminRefundServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("들어왓닝");
		request.getRequestDispatcher(CommonTemplate.WEB_VIEWS+"/admin/adminrefund.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
