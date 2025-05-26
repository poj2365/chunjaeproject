package com.niw.point.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.common.CommonTemplate;
import com.niw.point.model.dto.PointRefund;

/**
 * Servlet implementation class PointRefundServlet
 */
@WebServlet("/point/refundpoint.do")
public class PointRefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public PointRefundServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userId = request.getParameter("userId");
		String refundType = request.getParameter("refundType");
		int fileId = Integer.parseInt(request.getParameter("fileId"));
		int refundPoint = Integer.parseInt(request.getParameter("refundPoint"));
		String refundStatus = request.getParameter("refundStatus");
		String refundAccount = request.getParameter("refundAccount");
		
		PointRefund p = PointRefund.builder()
				.userId(userId)
				.refundAccount(refundType)
				.fileId(fileId)
				.refundPoint(refundPoint)
				.refundStatus(refundStatus)
				.refundAccount(refundAccount)
				.build();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
