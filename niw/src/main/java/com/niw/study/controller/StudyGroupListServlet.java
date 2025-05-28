package com.niw.study.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.common.CommonTemplate;
import com.niw.study.model.dto.StudyGroup;
import com.niw.study.model.service.GroupMemberService;
import com.niw.study.model.service.StudyGroupService;
import com.niw.user.model.dto.User;

/**
 * Servlet implementation class StudyGroupListServelt
 */
@WebServlet("/study/grouplist.do")
public class StudyGroupListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudyGroupListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginUser");
		int groupLimit = 0;
		if(user!=null) {
			groupLimit = StudyGroupService.SERVICE.searchStudyGroupCountId(user.userId());
		}
		request.setAttribute("groupLimit", groupLimit);
		
		String searchType = request.getParameter("searchType");
		String keyword = request.getParameter("keyword");
		List<StudyGroup> studygroups =null;
		int cPage = 0, totalData = 0, numPerpage = 10;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		if (searchType != null && keyword != null && !keyword.trim().isEmpty()) {
			studygroups = StudyGroupService.SERVICE.searchStudyGroupType(searchType, keyword, cPage, numPerpage);
			totalData = StudyGroupService.SERVICE.searchStudyGroupCount(searchType, keyword);
			request.setAttribute("searchType", searchType);
			request.setAttribute("keyword", keyword);
		} else {
			studygroups = StudyGroupService.SERVICE.searchStudyGroupAll(cPage, numPerpage);
			totalData = StudyGroupService.SERVICE.studyGroupCount();
		}
		request.setAttribute("studygroups", studygroups);

		// paging
		int pageBarSize = 5;

		int totalPage = (int) Math.ceil((double) totalData / numPerpage);
		if (totalPage == 0) totalPage = 1;

		int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		if (pageNo > totalPage) pageNo = 1;

		int pageEnd = Math.min(pageNo + pageBarSize - 1, totalPage);
		String baseUrl = request.getRequestURI();
		String connector = baseUrl.contains("?") ? "&" : "?";
		String queryParams = "";
		if (searchType != null && keyword != null) {
		    queryParams = "&searchType=" + searchType + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
		}

		StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");
		if (cPage == 1) {
			pageBar.append("<li class='page-item disabled'>");
			pageBar.append("<a class='page-link' href='#'> prev </a>");
			pageBar.append("</li>");
		} else {
			pageBar.append("<li class='page-item '>");
			pageBar.append("<a class='page-link' href='" + baseUrl+connector + "&cPage="
					+ (pageNo > 1 ? pageNo - 1 : 1) +queryParams + "'> prev </a>");
			pageBar.append("</li>");
		}
		for (int i = pageNo; i <= pageEnd; i++) {
			if (i == cPage) {
				pageBar.append("<li class='page-item disabled'>");
				pageBar.append("<a class='page-link' href='#'>" + i + "</a>");
			} else {
				pageBar.append("<li class='page-item'>");
				pageBar.append(
						"<a class='page-link' href='" + baseUrl+connector + "&cPage=" + i +queryParams + "'> " + i + " </a>");
			}
			pageBar.append("</li>");
		}
		if (cPage == totalPage) {
			pageBar.append("<li class='page-item disabled'>");
			pageBar.append("<a class='page-link' href='#'> next </a>");
		} else {
			pageBar.append("<li class='page-item'>");
			pageBar.append("<a class='page-link' href='" + baseUrl+connector + "&cPage="
					+ (pageEnd < totalPage ? pageEnd + 1 : totalPage) +queryParams + "'> next </a>");
		}
		pageBar.append("</li>");
		pageBar.append("</ul>");
		
		request.setAttribute("pageBar", pageBar);
		request.getRequestDispatcher(CommonTemplate.WEB_VIEWS + "/study/studyGroupList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
