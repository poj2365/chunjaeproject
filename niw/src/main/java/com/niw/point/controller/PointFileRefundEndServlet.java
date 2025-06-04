package com.niw.point.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.common.CommonTemplate;
import com.niw.point.model.dto.PointRefund;
import com.niw.point.model.service.PointService;

/**
 * Servlet implementation class PointFileRefundEndServlet
 */
@WebServlet("/point/refundendfile.do")
public class PointFileRefundEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public PointFileRefundEndServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		long now = System.currentTimeMillis();
		int rand = (int)(Math.random()*10000);
		
		long refundId = Long.parseLong("" + now + String.format("%04d", rand));
		String userId = request.getParameter("userId");
		String refundType = request.getParameter("refundType");
		long materialId = Long.parseLong(request.getParameter("fileId"));
		System.out.println(request.getParameter("refundFilePoint"));
		int filePoint = Integer.parseInt(request.getParameter("refundFilePoint"));
		
		
		PointRefund p = PointRefund.builder()
				.refundId(refundId)
				.userId(userId)
				.refundType(refundType)
				.fileId(materialId)
				.filePoint(filePoint)
				.build();
		
		int result = PointService.ponitService().refundFileHistoy(p);
	
		if (result > 0) {
			System.out.println("포인트 환불 기록 성공!");
			request.setAttribute("message", "환불 요청이 성공했습니다.");
		} else {
			System.out.println("포인트 환불 기록 실패");
			request.setAttribute("message", "환불 요청이 실패했습니다.");
		}
		
		response.sendRedirect(request.getContextPath() + "/user/mypage.do");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}