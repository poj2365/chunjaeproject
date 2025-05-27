package com.niw.point.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.point.model.dto.PointRefund;
import com.niw.point.model.service.PointService;

/**
 * Servlet implementation class PointRefundServlet
 */
@WebServlet("/point/refundendpoint.do")
public class PointRefundEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PointRefundEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		String refunddate = request.getParameter("refundDate");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date refundDate = null;
//		try {
//			 // refundDate = sdf.parse(refunddate);
//		} catch(ParseException e) {
//			e.printStackTrace();
//		}
		String refundType = request.getParameter("refundType");
		int refundPoint = Integer.parseInt(request.getParameter("refundPoint"));
		int refundAmount = (int)(Integer.parseInt(request.getParameter("refundPoint"))*0.9);
		String refundAccount = request.getParameter("accountNumber");
		
		PointRefund p = PointRefund.builder()
				.userId(userId)
				.refundDate(refundDate)
				.refundType(refundType)
				
				

				.build();
		
		int result = PointService.ponitService().refundPointHistoy(p);
		
		if (result > 0) {
			System.out.println("포인트 환불 기록 성공!");
			request.setAttribute("message", "환불 요청이 성공했습니다.");
		} else {
			System.out.println("포인트 환불 기록 실패");
			request.setAttribute("message", "환불 요청이 실패했습니다.");
		}
		request.getRequestDispatcher("/views/point/refundResult.jsp").forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
