package com.niw.instructor.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.instructor.model.dto.InstructorApplication;
import com.niw.user.model.dto.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class InstructorApplySupplyServlet
 */
@WebServlet("/InstructorApplySupplyServlet")
public class InstructorApplySupplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InstructorApplySupplyServlet() {
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
		User user=(User)session.getAttribute("loginUser");
		String path=getServletContext().getRealPath("/resources/upload/instructor/apply/"+user.userId());
		File folder = new File(path);
		if(!folder.exists()) folder.mkdir();
		int size=1024*1024*50;
		String encoding ="utf-8";
		DefaultFileRenamePolicy dfrp=new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, size, encoding, dfrp);
		Enumeration<String> names=mr.getFileNames();
		String renameFile="";
		String userId=user.userId();
		String instructorName=user.userName();
		
		String bankName=mr.getParameter("bankName");
		String accountHolder=mr.getParameter("accountHolder");
		String accountNumber=mr.getParameter("accountNumber").replaceAll("-", "");
		List<String> portFolios = new ArrayList();
		while(names.hasMoreElements()) {
			String inputName=names.nextElement();
			renameFile=mr.getFilesystemName(inputName);
			portFolios.add(renameFile);
		}
		InstructorApplication instructorApplication = InstructorApplication.builder()
				.userId(userId)
				.instructorName(instructorName)
				.bankName(bankName)
				.accountHolder(accountHolder)
				.accountNumber(accountNumber)
				.introduction(accountNumber)
				.portFolio(portFolios)
				.build();
		

		doGet(request, response);
	}

}
