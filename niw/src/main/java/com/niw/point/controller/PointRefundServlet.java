package com.niw.point.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.common.CommonTemplate;
import com.niw.point.model.dto.PointRefund;


@WebServlet("/point/refundpoint.do")
public class PointRefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public PointRefundServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
   		request.getRequestDispatcher(CommonTemplate.WEB_VIEWS+"/point/refundPoint.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
