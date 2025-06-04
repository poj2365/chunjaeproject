package com.niw.instructor.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.instructor.model.dto.InstructorApplication;
import com.niw.instructor.model.service.InstructorApplicationService;
import com.niw.user.model.dto.User;

@WebServlet("/admin/instructor/detail.do")
public class InstructorApplicationDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        
        if (loginUser == null || !loginUser.userRole().equals("ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/user/loginview.do");
            return;
        }
        
      
        String applicationIdStr = request.getParameter("id");
        
        if (applicationIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/adminpage/instructor.do");
            return;
        }
        
        try {
            int applicationId = Integer.parseInt(applicationIdStr);
            
            
            InstructorApplicationService service = InstructorApplicationService.SERVICE;
            InstructorApplication application = service.getApplicationDetail(applicationId);
            
            if (application == null) {
                response.sendRedirect(request.getContextPath() + "/admin/adminpage/instructor.do");
                return;
            }
            
         
            request.setAttribute("application", application);
            
          
            request.getRequestDispatcher("/WEB-INF/views/admin/instructorDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/adminpage/instructor.do");
        }
    }
}