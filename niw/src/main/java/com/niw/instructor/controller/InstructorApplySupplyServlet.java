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
import com.niw.instructor.model.dto.PortfolioFile;
import com.niw.instructor.model.service.InstructorApplicationService;
import com.niw.user.model.dto.User;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class InstructorApplySupplyServlet
 */
@WebServlet("/instructor/apply.do")
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");

		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/user/loginview.do");
			return;
		}

		String path = getServletContext().getRealPath("/resources/upload/instructor/apply/" + user.userId());
//		 String path = "/WEB-INF/resources/upload/instructor/apply/" + user.userId();
		File folder = new File(path);
		if (!folder.exists())
			folder.mkdirs();
		int size = 1024 * 1024 * 50;
		String encoding = "utf-8";
		DefaultFileRenamePolicy dfrp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path, size, encoding, dfrp);
		Enumeration<String> names = mr.getFileNames();
		String userId = user.userId();
		String instructorName = user.userName();

		String bankName = mr.getParameter("bankName");
		String accountHolder = mr.getParameter("accountHolder");
		String accountNumber = mr.getParameter("accountNumber").replaceAll("-", "");
		List<PortfolioFile> portfolioFiles = new ArrayList();
		while (names.hasMoreElements()) {
			String inputName = names.nextElement();
			String originalFile = mr.getOriginalFileName(inputName);
			String renameFile = mr.getFilesystemName(inputName);

			File uploadFile = new File(path, renameFile);
			int fileSize = (int) uploadFile.length();
			String fileType = getServletContext().getMimeType(originalFile);
			String fileExtension = originalFile.substring(originalFile.lastIndexOf('.') + 1).toLowerCase();

			String filePath = path + "/" + renameFile;
			PortfolioFile portfolioFile = new PortfolioFile(0, 0, originalFile, renameFile, filePath, fileSize,
					fileType, fileExtension, null);
			portfolioFiles.add(portfolioFile);
		}

		InstructorApplication instructorApplication = new InstructorApplication(size, userId, instructorName, bankName,
				accountHolder, accountNumber, accountNumber, portfolioFiles, null, null, null);
		int result = InstructorApplicationService.SERVICE.instructorApply(instructorApplication);
		response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		if(result>0) {
			response.getWriter().println("<script>");
			response.getWriter().println("alert('강사 지원이 완료되었습니다. 검토 후 연락드리겠습니다.');");
			response.getWriter().println("</script>");
			request.getRequestDispatcher("/WEB-INF/views/market/marketview.jsp").forward(request, response);
		}else {
			response.getWriter().println("<script>");
			response.getWriter().println("alert('강사 지원 처리 중 오류가 발생했습니다. 다시 시도해주세요.');");
			response.getWriter().println("history.back();");
			response.getWriter().println("</script>");
		}
	}

}
