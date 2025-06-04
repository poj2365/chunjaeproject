package com.niw.instructor.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.instructor.model.service.InstructorApplicationService;
import com.niw.instructor.model.service.InstructorApplicationService.ApplicationListResult;
import com.niw.user.model.dto.User;

@WebServlet("/admin/adminpage/instructor.do")
public class InstructorApplicationListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;
    private static final int PAGE_BAR_SIZE = 5; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        
        if (loginUser == null || !loginUser.userRole().equals("ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/user/loginview.do");
            return;
        }
        

        String status = request.getParameter("status");
        String cPageStr = request.getParameter("cPage");
        
  
        if (status == null) status = "전체";
        
        int cPage = 1;
        if (cPageStr != null) {
            try {
                cPage = Integer.parseInt(cPageStr);
            } catch (NumberFormatException e) {
                cPage = 1;
            }
        }
        

        InstructorApplicationService service = InstructorApplicationService.SERVICE;
        ApplicationListResult result = service.getApplicationList(status, cPage, PAGE_SIZE);
        

        String pageBar = generatePageBar(request, cPage, result.getTotalPage(), service);
        

        request.setAttribute("applications", result.getApplications());
        request.setAttribute("pageBar", pageBar);
        request.setAttribute("totalCount", result.getTotalCount());
        request.setAttribute("currentPage", result.getCurrentPage());
        request.setAttribute("totalPage", result.getTotalPage());
        request.setAttribute("selectedStatus", status);
        
 
        request.setAttribute("pendingCount", service.getApplicationList("WATING", 1, 1).getTotalCount());
        request.setAttribute("approvedCount", service.getApplicationList("APPROVED", 1, 1).getTotalCount());
        request.setAttribute("rejectedCount", service.getApplicationList("REJECTED", 1, 1).getTotalCount());
        
 
        String xRequestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(xRequestedWith)) {

            request.getRequestDispatcher("/WEB-INF/views/admin/instructorList.jsp").forward(request, response);
        } else {

            request.getRequestDispatcher("/WEB-INF/views/admin/instructorList.jsp").forward(request, response);
        }
    }
    
    private String generatePageBar(HttpServletRequest request, int cPage, int totalPage, InstructorApplicationService service) {
        if (totalPage == 0) {
            return ""; 
        }
        
        int pageNo = service.getStartPage(cPage, PAGE_BAR_SIZE);
        int pageEnd = service.getEndPage(cPage, PAGE_BAR_SIZE, totalPage);
        
        StringBuffer pageBar = new StringBuffer("<ul class='pagination justify-content-center'>");
        
   
        if (cPage == 1) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> prev </a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link instructor-page-link' href='#' data-page='" + (pageNo > 1 ? pageNo - 1 : 1) + "'> prev </a>");
            pageBar.append("</li>");
        }
        
   
        for (int i = pageNo; i <= pageEnd; i++) {
            if (i == cPage) {
                pageBar.append("<li class='page-item active'>");
                pageBar.append("<a class='page-link' href='#'>" + i + "</a>");
            } else {
                pageBar.append("<li class='page-item'>");
                pageBar.append("<a class='page-link instructor-page-link' href='#' data-page='" + i + "'> " + i + " </a>");
            }
            pageBar.append("</li>");
        }
        
     
        if (cPage == totalPage) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'> next </a>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link instructor-page-link' href='#' data-page='" + (pageEnd < totalPage ? pageEnd + 1 : totalPage) + "'> next </a>");
        }
        pageBar.append("</li>");
        pageBar.append("</ul>");
        
        return pageBar.toString();
    }
}