package com.niw.market.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.market.model.dto.Material;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class CancleRegistServlet
 */
@WebServlet("/market/cancleRegist.do")
public class CancleRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CancleRegistServlet() {
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
		Material material = (Material) session.getAttribute("material");
		System.out.println(material.savedFileName());
		System.out.println("ss" + request.getParameter("savedFileName"));
		System.out.println("삭제실행");
		if (request.getParameter("savedFileName").equals(material.savedFileName())) {
			System.out.println("삭제완료");
			String filePath = material.materialFilePath() + File.separator + material.savedFileName();
			File file = new File(filePath);
			boolean deleted = file.delete();
			session.removeAttribute("material_" + user.userName());
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().print("{\"deleted\":" + deleted + "}");
			String previewPath = material.materialFilePath() + File.separator + "previews";
			File folder = new File(previewPath);

			if (folder.isDirectory()) {
				System.out.println("폴더지롱~");
				File[] files = folder.listFiles();
				if (files != null) {
					for (File f : files) {
						if (f.getName().startsWith("preview__page")) {
							boolean deletedPreview = f.delete();
							if (!deletedPreview) {
								System.err.println("삭제 실패: " + f.getName());
							}
						}
					}
				}
			}
		}
	}
}
