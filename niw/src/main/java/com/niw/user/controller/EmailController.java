package com.niw.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

/**
 * 완전한 이메일 인증 컨트롤러
 * DB 연동 + 실제 이메일 발송
 */
@WebServlet({
    "/user/sendEmailVerification.do",
    "/user/verifyEmailCode.do"
})
public class EmailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private Gson gson = new Gson();
    private EmailVerification emailVerification = new EmailVerification();
    private SendEmail sendEmail = new SendEmail();
    
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
                case "/user/sendEmailVerification.do":
                    sendEmailVerification(request, response, result);
                    break;
                case "/user/verifyEmailCode.do":
                    verifyEmailCode(request, response, result);
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
     * 이메일 인증번호 발송
     */
    private void sendEmailVerification(HttpServletRequest request, HttpServletResponse response, 
            Map<String, Object> result) throws Exception {
        
        String email = request.getParameter("email");
        
        if (email == null || email.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "이메일을 입력해주세요.");
            return;
        }
        
        // 이메일 형식 검증
        if (!isValidEmail(email)) {
            result.put("success", false);
            result.put("message", "올바른 이메일 형식을 입력해주세요.");
            return;
        }
        
        // 6자리 인증번호 생성
        String verificationCode = generateVerificationCode();
        
        try {
            // 1. 기존 인증번호 삭제 (오라클 프로시저)
            emailVerification.deleteExistingVerification(email);
            
            // 2. 새 인증번호 DB에 저장 (오라클 프로시저)
            boolean saved = emailVerification.saveVerificationCode(email, verificationCode);
            
            if (!saved) {
                result.put("success", false);
                result.put("message", "인증번호 저장에 실패했습니다.");
                return;
            }
            
            // 3. 실제 이메일 발송
            boolean emailSent = sendEmail.sendVerificationEmail(email, verificationCode, request, response);
            
            if (emailSent) {
                result.put("success", true);
                result.put("message", "인증번호가 발송되었습니다. 이메일을 확인해주세요.");
                
                // 개발용 로그 (운영 시 제거)
                System.out.println("=== 이메일 인증번호 발송 ===");
                System.out.println("이메일: " + email);
                System.out.println("인증번호: " + verificationCode);
                System.out.println("========================");
                
            } else {
                // 이메일 발송 실패 시 DB에서 인증번호 삭제
                emailVerification.deleteVerificationCode(email);
                result.put("success", false);
                result.put("message", "이메일 발송에 실패했습니다. 다시 시도해주세요.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "인증번호 발송 중 오류가 발생했습니다.");
        }
    }
    
    /**
     * 이메일 인증번호 확인
     */
    private void verifyEmailCode(HttpServletRequest request, HttpServletResponse response, 
            Map<String, Object> result) throws Exception {
        
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        
        if (email == null || email.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "이메일을 입력해주세요.");
            return;
        }
        
        if (code == null || code.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "인증번호를 입력해주세요.");
            return;
        }
        
        if (code.length() != 6) {
            result.put("success", false);
            result.put("message", "인증번호는 6자리 숫자입니다.");
            return;
        }
        
        try {
            // 오라클 프로시저로 인증번호 확인
            boolean isValid = emailVerification.verifyCode(email, code);
            
            if (isValid) {
                // 인증 성공 시 DB에서 인증번호 삭제
                emailVerification.deleteVerificationCode(email);
                
                result.put("success", true);
                result.put("message", "이메일 인증이 완료되었습니다.");
                
                System.out.println("이메일 인증 성공: " + email);
                
            } else {
                result.put("success", false);
                result.put("message", "인증번호가 일치하지 않거나 유효시간이 만료되었습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "인증 확인 중 오류가 발생했습니다.");
        }
    }
    
    /**
     * 6자리 인증번호 생성
     */
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 100000 ~ 999999
        return String.valueOf(code);
    }
    
    /**
     * 이메일 형식 유효성 검사
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        return email.matches(emailRegex);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // GET 요청도 POST로 처리
        doPost(request, response);
    }
}