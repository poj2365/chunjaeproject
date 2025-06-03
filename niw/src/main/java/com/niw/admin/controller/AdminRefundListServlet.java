package com.niw.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.niw.point.model.dto.PointRefund;
import com.niw.point.model.service.PointService;

/**
 * Servlet implementation class AdminRefundListServlet
 */
@WebServlet("/admin/adminpage/refundlist.do")
public class AdminRefundListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminRefundListServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<PointRefund> refundlists = PointService.ponitService().showAllRefundList();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		// Gson 으로 포맷을 바꿔 주어 2025-06-02 이런 형식으로 나오게 해준다.
		response.setContentType("application/json; charset=UTF-8");
	    // gson.toJson(refundList, response.getWriter());
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
