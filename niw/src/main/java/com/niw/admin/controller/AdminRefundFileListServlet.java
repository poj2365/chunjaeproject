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
import com.niw.point.model.dto.PointRefundFileList;
import com.niw.point.model.service.PointService;


@WebServlet("/admin/adminpage/refundfilelist.do")
public class AdminRefundFileListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminRefundFileListServlet() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<PointRefundFileList> refundlists = PointService.ponitService().showAllRefundFileList();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		response.setContentType("application/json; charset=UTF-8");
	    gson.toJson(refundlists, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
