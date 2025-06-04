package com.niw.instructor.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.niw.instructor.model.Enums.ApplicationStatus;
import com.niw.instructor.model.service.InstructorApplicationService;
import com.niw.user.model.dto.User;

@WebServlet("/admin/instructor/approval.do")
public class InstructorApplicationApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        if (loginUser == null || !loginUser.userRole().equals("ADMIN")) {
            out.print("{\"success\": false, \"message\": \"권한이 없습니다.\"}");
            return;
        }
        
        try {
            
            String applicationIdStr = request.getParameter("applicationId");
            String action = request.getParameter("action"); // "approve" or "reject"
            String reviewComment = request.getParameter("reviewComment");
            
            if (applicationIdStr == null || action == null) {
                out.print("{\"success\": false, \"message\": \"필수 파라미터가 누락되었습니다.\"}");
                return;
            }
            
            int applicationId = Integer.parseInt(applicationIdStr);
            
         
            ApplicationStatus newStatus;
            if ("approve".equals(action)) {
                newStatus = ApplicationStatus.APPROVED;
            } else if ("reject".equals(action)) {
                newStatus = ApplicationStatus.REJECTED;
            } else {
                out.print("{\"success\": false, \"message\": \"잘못된 액션입니다.\"}");
                return;
            }
            
        
            InstructorApplicationService service = InstructorApplicationService.SERVICE;
            boolean success = service.processApplication(applicationId, newStatus, 
                                                       loginUser.userId(), reviewComment);
            
            if (success) {
                String message = newStatus == ApplicationStatus.APPROVED ? "승인되었습니다." : "반려되었습니다.";
                out.print("{\"success\": true, \"message\": \"신청서가 " + message + "\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"처리 중 오류가 발생했습니다.\"}");
            }
            
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"잘못된 신청서 ID입니다.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"서버 오류가 발생했습니다.\"}");
        }
    }
}