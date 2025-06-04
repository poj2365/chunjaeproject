package com.niw.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.point.model.service.PointService;

/**
 * Servlet implementation class AdminApproveRefund
 */
@WebServlet("/admin/approvePointRefund.do")
public class AdminApproveRefundPointServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public AdminApproveRefundPointServlet() {
        super();
     
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long refundId = Long.parseLong(request.getParameter("refundId"));
		String userId = request.getParameter("userId");
		int pointAmount = Integer.parseInt(request.getParameter("pointAmount"));
		int updateresult = PointService.ponitService().approvePointRefund(refundId,userId,pointAmount);
		 response.setContentType("text/plain; charset=UTF-8");
		    if (updateresult > 0) {
		        response.getWriter().write("success");
		    } else {
		        response.getWriter().write("fail");
		    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
