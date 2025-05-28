package com.niw.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.niw.user.model.dto.User;
import com.niw.user.model.service.UserService;

/**
 * Servlet implementation class UserEnrollServlet
 */
@WebServlet("/user/enroll.do")
public class UserEnrollServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserEnrollServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/user/userEnroll.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        request.getParameter("formData");
        
        Gson gson = new Gson();
        gson.fromJson("String", null)
        try {
            String userId = request.getParameter("userid");
            String userName = request.getParameter("name");
            String userType = request.getParameter("userType");
            String birthYear = request.getParameter("birthYear");
            String birthMonth = request.getParameter("birthMonth");
            String birthDay = request.getParameter("birthDay");
            String userEmail = request.getParameter("email");
            String postcode = request.getParameter("postcode");
            String address = request.getParameter("address");
            String addressDetail = request.getParameter("addressDetail");
            String password = request.getParameter("password");

            // 파라미터 디버깅 로그
            System.out.println("=== 회원가입 파라미터 확인 ===");
            System.out.println("userId: " + userId);
            System.out.println("userName: " + userName);
            System.out.println("userType: " + userType);
            System.out.println("userEmail: " + userEmail);
            System.out.println("birthYear: " + birthYear);
            System.out.println("birthMonth: " + birthMonth);
            System.out.println("birthDay: " + birthDay);

            // 기본 유효성 검사
            if (userId == null || userId.trim().isEmpty() ||
                userName == null || userName.trim().isEmpty() ||
                userEmail == null || userEmail.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                
                System.out.println("필수 파라미터 누락");
                out.write(gson.toJson(new EnrollResponse(false, "필수 정보를 모두 입력해주세요.")));
                return;
            }

            // 주소 조합
            String fullAddress = String.format("(%s) %s %s", postcode, address, addressDetail);

            String birthDateStr = String.format("%s-%02d-%02d",
                birthYear,
                Integer.parseInt(birthMonth),
                Integer.parseInt(birthDay)
            );
            Date userBirthDate = Date.valueOf(birthDateStr);

            // 회원 역할 설정
            String userRole = "student".equals(userType) ? "STUDENT" : "GENERAL";

            User newUser = User.builder()
                .userId(userId.trim())
                .password(password)
                .userName(userName.trim())
                .userPhone("")
                .userEmail(userEmail.trim())
                .userProfileImage("")
                .userPoint(0)
                .userIntroduce("")
                .enrollDate(new Date(System.currentTimeMillis()))
                .userRole(userRole)
                .userAddress(fullAddress)
                .userBirthDate(userBirthDate)
                .build();

            System.out.println("User 객체 생성 완료");
            System.out.println("User 정보: " + newUser.toString());

            int result = UserService.USERSERVICE.insertUser(newUser);
            
            System.out.println("insertUser 결과: " + result);

            if (result > 0) {
                System.out.println("회원가입 성공");
                out.write(gson.toJson(new EnrollResponse(true, "회원가입이 완료되었습니다.")));
            } else {
                System.out.println("회원가입 실패 - DB 처리 실패");
                out.write(gson.toJson(new EnrollResponse(false, "회원가입에 실패했습니다.")));
            }

        } catch (Exception e) {
            System.out.println("=== 회원가입 오류 발생 ===");
            e.printStackTrace();
            out.write(gson.toJson(new EnrollResponse(false, "서버 오류가 발생했습니다: " + e.getMessage())));
        } finally {
            out.close();
        }
    }

    // 응답용 내부 클래스
    private static class EnrollResponse {
        private boolean success;
        private String message;
        
        public EnrollResponse(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
        
        public boolean isSuccess() { return success; }
        public String getMessage() { return message; }
    }
}