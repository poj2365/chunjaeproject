package com.niw.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.point.model.service.PointService;

/**
 * Servlet implementation class AdminRejectRefundPointServlet
 */
@WebServlet("/admin/rejectPointRefund.do")
public class AdminRejectRefundPointServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AdminRejectRefundPointServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long refundId = Long.parseLong(request.getParameter("refundId"));
		System.out.println(refundId);
		String userId = request.getParameter("userId");
		System.out.println(userId);
		int pointAmount = Integer.parseInt(request.getParameter("pointAmount"));
		System.out.println(pointAmount);
		int updateresult = PointService.ponitService().rejectPointRefund(refundId,userId,pointAmount);
		System.out.println(updateresult);
		 response.setContentType("text/plain; charset=UTF-8");
		    if (updateresult > 0) {
		        response.getWriter().write("success");
		    } else {
		        response.getWriter().write("fail");
		    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
