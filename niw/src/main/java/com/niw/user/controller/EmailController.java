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
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.niw.user.model.service.UserService;

/**
 * 완전한 이메일 인증 컨트롤러
 * DB 연동 + 실제 이메일 발송
 */
@WebServlet({
    "/user/sendEmailVerification.do",
    "/user/verifyEmailCode.do",
    "/user/sendPasswordResetEmail.do"
})
public class EmailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private Gson gson = new Gson();
    private EmailVerification emailVerification = new EmailVerification();
    private SendEmail sendEmail = new SendEmail();
//    private UserService userService = new UserService(); // 사용자 정보 확인용 서비스
    
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
                case "/user/sendPasswordResetEmail.do":
                    sendPasswordResetEmail(request, response, result);
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
     * 이메일 인증번호 발송 (일반 회원가입용)
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
     * 비밀번호 찾기 이메일 인증번호 발송
     */
    private void sendPasswordResetEmail(HttpServletRequest request, HttpServletResponse response, 
            Map<String, Object> result) throws Exception {
        
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String birthYear = request.getParameter("birthYear");
        String birthMonth = request.getParameter("birthMonth");
        String birthDay = request.getParameter("birthDay");
        System.out.println(userId);
        
        // 필수 파라미터 검증
        if (userId == null || userId.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "아이디를 입력해주세요.");
            return;
        }
        
        if (name == null || name.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "이름을 입력해주세요.");
            return;
        }
        
        if (birthYear == null || birthMonth == null || birthDay == null ||
            birthYear.trim().isEmpty() || birthMonth.trim().isEmpty() || birthDay.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "생년월일을 모두 입력해주세요.");
            return;
        }
        
        // 생년월일 형식 검증
        if (!isValidBirthDate(birthYear, birthMonth, birthDay)) {
            result.put("success", false);
            result.put("message", "올바른 생년월일을 입력해주세요.");
            return;
        }
        
        try {
            // 1. 사용자 정보 확인 (아이디, 이름, 생년월일로 사용자 존재 여부 및 이메일 조회)
            String birthDate = birthYear + "-" + 
                              String.format("%02d", Integer.parseInt(birthMonth)) + "-" + 
                              String.format("%02d", Integer.parseInt(birthDay));
            
            String userEmail = UserService.USERSERVICE.getUserEmailForPasswordReset(userId, name, birthDate);
            
            if (userEmail == null || userEmail.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "입력하신 정보와 일치하는 회원을 찾을 수 없습니다.");
                return;
            }
            
            // 2. 6자리 인증번호 생성
            String verificationCode = generateVerificationCode();
            
            // 3. 기존 인증번호 삭제
            emailVerification.deleteExistingVerification(userEmail);
            
            // 4. 새 인증번호 DB에 저장 (비밀번호 찾기용으로 구분)
            boolean saved = emailVerification.savePasswordResetCode(userEmail, verificationCode, userId);
            
            if (!saved) {
                result.put("success", false);
                result.put("message", "인증번호 저장에 실패했습니다.");
                return;
            }
            
            // 5. 비밀번호 찾기 이메일 발송
            boolean emailSent = sendEmail.sendPasswordResetEmail(userEmail, verificationCode, userId, name, request, response);
            
            if (emailSent) {
                // ⭐ 중요: 세션에 이메일과 사용자 아이디 저장
                HttpSession session = request.getSession();
                session.setAttribute("resetEmail", userEmail);
                session.setAttribute("resetUserId", userId);
                
                // 보안을 위해 이메일 마스킹 처리
                String maskedEmail = maskEmail(userEmail);
                
                result.put("success", true);
                result.put("message", "인증번호가 " + maskedEmail + "로 발송되었습니다.");
                result.put("maskedEmail", maskedEmail);
                
                // 개발용 로그 (운영 시 제거)
                System.out.println("=== 비밀번호 찾기 인증번호 발송 완료 ===");
                System.out.println("아이디: " + userId);
                System.out.println("이름: " + name);
                System.out.println("이메일: " + userEmail);
                System.out.println("인증번호: " + verificationCode);
                System.out.println("세션에 저장된 이메일: " + session.getAttribute("resetEmail"));
                System.out.println("세션에 저장된 사용자ID: " + session.getAttribute("resetUserId"));
                System.out.println("====================================");
                
            } else {
                // 이메일 발송 실패 시 DB에서 인증번호 삭제
                emailVerification.deleteVerificationCode(userEmail);
                result.put("success", false);
                result.put("message", "이메일 발송에 실패했습니다. 다시 시도해주세요.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "비밀번호 찾기 인증번호 발송 중 오류가 발생했습니다.");
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
    
    /**
     * 생년월일 유효성 검사
     */
    private boolean isValidBirthDate(String year, String month, String day) {
        try {
            int y = Integer.parseInt(year);
            int m = Integer.parseInt(month);
            int d = Integer.parseInt(day);
            
            // 기본적인 범위 체크
            if (y < 1900 || y > 2023) return false;
            if (m < 1 || m > 12) return false;
            if (d < 1 || d > 31) return false;
            
            // 월별 일자 체크
            if ((m == 4 || m == 6 || m == 9 || m == 11) && d > 30) return false;
            if (m == 2) {
                // 윤년 체크
                boolean isLeapYear = (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
                if (isLeapYear && d > 29) return false;
                if (!isLeapYear && d > 28) return false;
            }
            
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * 이메일 마스킹 처리 (보안)
     * 예: test@example.com -> t***@example.com
     */
    private String maskEmail(String email) {
        if (email == null || !email.contains("@")) {
            return email;
        }
        
        String[] parts = email.split("@");
        String localPart = parts[0];
        String domainPart = parts[1];
        
        if (localPart.length() <= 2) {
            return localPart.charAt(0) + "*@" + domainPart;
        } else {
            return localPart.charAt(0) + "***@" + domainPart;
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // GET 요청도 POST로 처리
        doPost(request, response);
    }
    
    
}