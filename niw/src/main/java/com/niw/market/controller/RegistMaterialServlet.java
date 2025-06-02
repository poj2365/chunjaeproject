package com.niw.market.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.market.model.dto.Material;
import com.niw.market.model.service.MaterialService;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class RegistMaterialServlet
 */
@WebServlet("/market/registMaterial.do")
public class RegistMaterialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistMaterialServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user =(User)session.getAttribute("loginUser");
		Material material=(Material)session.getAttribute("material");
		int materialId=0;
		String userId = material.userId();
		String instructorName= material.instructorName();
		String instructorIntro= material.instructorIntro();
		String materialTitle=request.getParameter("materialTitle");
		String originalFileName=material.originalFileName();
		String savedFileName=material.savedFileName();
		String materialDescription=request.getParameter("materialDescription");
		
		int materialPrice = Integer.parseInt(request.getParameter("price"));
		int materialPage = material.materialPage();
		
		String previewPath=material.previewPath();
		String[] pages=request.getParameterValues("selectedPreviewPages");
		
		List<String> thumbnailFilePaths= new ArrayList<>();
		
		for(int i=0;i<pages.length;i++) {
			thumbnailFilePaths.add("resources/upload/market/"+userId+"/material/previews/"+savedFileName.substring(0,savedFileName.lastIndexOf("."))+"_preview_page"+pages[i]+".png");
		}
		
		String materialFilePath="resources/upload/market/"+userId+"/material"+savedFileName;
		String materialStatus=null;
		String materialCategory=request.getParameter("category");
		String materialGrade=request.getParameter("grade");
		String materialSubject=request.getParameter("subject");
		Date materialCreatedDate=null;
		Date materialUpdateDate=null;
		System.out.println(materialDescription);
		Material uploadMaterial=new Material(
				materialId,
				userId, 
				instructorName, 
				instructorIntro,
				materialTitle, 
				originalFileName, 
				savedFileName, 
				materialDescription,
				materialPrice,
				materialPage, 
				thumbnailFilePaths, 
				previewPath,
				materialFilePath, 
				materialStatus, 
				materialCategory, 
				materialGrade, 
				materialSubject, 
				materialCreatedDate, 
				materialUpdateDate,
				0,
				0,
				0,
				0
				);
		
		MaterialService.SERVICE.registMaterial(uploadMaterial);
		session.removeAttribute("material");
		System.out.println("등록완료");
		response.sendRedirect(request.getContextPath()+"/");
		System.out.println("등록완료");
		
			
	}

}
