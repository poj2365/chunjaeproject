package com.niw.point.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.point.model.dto.PointMyFile;
import com.niw.point.model.service.PointService;


@WebServlet("/point/pointfilelist.do")
public class PointFileListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public PointFileListServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userId = request.getParameter("userId");
		System.out.println(userId);
		List<PointMyFile> files = PointService.ponitService().showMyFiles(userId);
		response.setContentType("application/json; charset=UTF-8");
	    Gson gson = new Gson();
	    String json = gson.toJson(files);
	    response.getWriter().write(json);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
