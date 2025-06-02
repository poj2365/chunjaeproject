package com.niw.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.niw.user.model.service.UserService;

/**
 * 비밀번호 찾기 및 아이디 찾기 처리 컨트롤러
 */
@WebServlet({
    "/user/idpwfind.do",
    "/userIdPwFind"
})
public class IdPwFindController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private Gson gson = new Gson();
    private UserService userService = UserService.USERSERVICE;
    private EmailVerification emailVerification = new EmailVerification();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String command = requestURI.substring(contextPath.length());
        
        Map<String, Object> result = new HashMap<>();
        
        try {
            switch (command) {
                case "/user/idpwfind.do":
                    handleIdPwFind(request, response, result);
                    break;
                case "/userIdPwFind":
                    handlePasswordReset(request, response, result);
                    break;
                default:
                    result.put("success", false);
                    result.put("message", "잘못된 요청입니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "서버 오류가 발생했습니다: " + e.getMessage());
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    /**
     * 아이디 찾기 및 인증번호 확인 처리
     */
    private void handleIdPwFind(HttpServletRequest request, HttpServletResponse response, 
            Map<String, Object> result) throws Exception {
        
        String action = request.getParameter("action");
        
        if ("findId".equals(action)) {
            // 아이디 찾기 처리
            findUserId(request, result);
        } else if ("verifyEmailCode".equals(action)) {
            // 인증번호 확인 처리
            verifyEmailCode(request, result);
        } else {
            // action이 없는 경우 아이디 찾기로 처리
            findUserId(request, result);
        }
    }
    
    /**
     * 아이디 찾기 처리
     */
    private void findUserId(HttpServletRequest request, Map<String, Object> result) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        if (name == null || name.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "이름을 입력해주세요.");
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "이메일을 입력해주세요.");
            return;
        }
        
        try {
            String foundUserId = userService.findId(name.trim(), email.trim());
            
            if (foundUserId != null && !foundUserId.trim().isEmpty()) {
                // 아이디 마스킹 처리 (보안)
                String maskedUserId = foundUserId;
                
                result.put("success", true);
                result.put("userId", maskedUserId);
                result.put("message", "아이디를 찾았습니다.");
                
                System.out.println("아이디 찾기 성공: " + name + " / " + email + " -> " + foundUserId);
                
            } else {
                result.put("success", false);
                result.put("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "아이디 찾기 중 오류가 발생했습니다.");
        }
    }
    
    /**
     * 비밀번호 찾기 인증번호 확인 처리
     */
    private void verifyEmailCode(HttpServletRequest request, Map<String, Object> result) {
        String emailCode = request.getParameter("emailCode");
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("resetEmail");
        String resetUserId = (String) session.getAttribute("resetUserId");
        
        // 디버깅 로그
        System.out.println("=== 인증번호 확인 요청 ===");
        System.out.println("입력된 인증번호: " + emailCode);
        System.out.println("세션의 이메일: " + userEmail);
        System.out.println("세션의 사용자ID: " + resetUserId);
        
     
        if (emailCode == null || emailCode.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "인증번호를 입력해주세요.");
            return;
        }
        
        
        if (userEmail == null || userEmail.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "인증번호 발송 후 다시 시도해주세요.");
            return;
        }
        
        // 인증번호 길이 검증
        if (emailCode.trim().length() != 6) {
            result.put("success", false);
            result.put("message", "인증번호는 6자리 숫자입니다.");
            return;
        }
        
        try {
            // 비밀번호 찾기 인증번호 확인
            String userId = emailVerification.verifyPasswordResetCode(userEmail, emailCode.trim());
            
            if (userId != null && !userId.trim().isEmpty()) {
                // 인증 성공 - 세션에 사용자 아이디 저장
                session.setAttribute("verifiedUserId", userId);
                session.removeAttribute("resetEmail"); // 더 이상 필요 없음
                session.removeAttribute("resetUserId");
                
                result.put("success", true);
                result.put("message", "인증이 완료되었습니다.");
                
                System.out.println("✅ 비밀번호 찾기 인증 성공: " + userId);
                
            } else {
                result.put("success", false);
                result.put("message", "인증번호가 일치하지 않거나 유효시간이 만료되었습니다.");
                System.out.println("❌ 비밀번호 찾기 인증 실패");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "인증 확인 중 오류가 발생했습니다.");
            System.err.println("❌ 비밀번호 찾기 인증번호 확인 예외: " + e.getMessage());
        }
    }
    
    /**
     * 비밀번호 초기화 처리
     */
    /**
     * 비밀번호 변경 처리
     */
    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response, 
            Map<String, Object> result) throws Exception {
        
        String action = request.getParameter("action");
        
        if ("changePassword".equals(action)) {
            HttpSession session = request.getSession();
            String verifiedUserId = (String) session.getAttribute("verifiedUserId");
            
            if (verifiedUserId == null || verifiedUserId.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "인증을 먼저 완료해주세요.");
                return;
            }
            
            // 새 비밀번호 가져오기
            String newPassword = request.getParameter("newPassword");
            
            // 최소한의 서버 검증 (보안상 필요)
            if (newPassword == null || newPassword.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "새 비밀번호를 입력해주세요.");
                return;
            }
            
            try {
                // 사용자가 입력한 새 비밀번호로 변경
                boolean updateSuccess = userService.updateUserPassword(verifiedUserId, newPassword);
                
                if (updateSuccess) {
                    // 세션 정리
                    session.removeAttribute("verifiedUserId");
                    
                    result.put("success", true);
                    result.put("message", "비밀번호가 성공적으로 변경되었습니다.");
                    
                    System.out.println("비밀번호 변경 성공: " + verifiedUserId);
                    
                } else {
                    result.put("success", false);
                    result.put("message", "비밀번호 변경에 실패했습니다.");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
                result.put("success", false);
                result.put("message", "비밀번호 변경 중 오류가 발생했습니다.");
            }
            
        } else {
            result.put("success", false);
            result.put("message", "잘못된 요청입니다.");
        }
    }
    
    /**
     * 아이디 마스킹 처리 (보안)
     * 예: hong1234dong -> hong***dong
     */
//    private String maskUserId(String userId) {
//        if (userId == null || userId.length() <= 3) {
//            return userId;
//        }
//        
//        if (userId.length() <= 6) {
//            return userId.substring(0, 2) + "***" + userId.substring(userId.length() - 1);
//        } else {
//            return userId.substring(0, 3) + "***" + userId.substring(userId.length() - 2);
//        }
//    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // GET 요청도 POST로 처리
        doPost(request, response);
    }
}