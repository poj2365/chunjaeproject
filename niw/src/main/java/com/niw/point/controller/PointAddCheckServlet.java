package com.niw.point.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.niw.common.CommonTemplate;

/**
 * Servlet implementation class PointAddCheckServlet
 */
@WebServlet("/point/verifyPayment")
public class PointAddCheckServlet extends HttpServlet {
    private static final String IMP_KEY = "7168663054823466"; // 본인 REST API Key
    private static final String IMP_SECRET = "53lWitAeCRueY2S26m5LqAq2TNimYC0b3KZWt2irKGKzSBuktTMZ51R2wo4ixIWDI8FJbScJ5ACTnoN0"; // 본인 REST API Secret

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("제발되라");

        // 요청 JSON 파싱
        BufferedReader reader = request.getReader();
        Gson gson = new Gson();
        JsonObject jsonRequest = JsonParser.parseReader(reader).getAsJsonObject();

        String impUid = jsonRequest.get("imp_uid").getAsString();
        String merchantUid = jsonRequest.get("merchant_uid").getAsString();

        // 1. 토큰 요청
        URL url = new URL("https://api.iamport.kr/users/getToken");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JsonObject tokenReq = new JsonObject();
        tokenReq.addProperty("imp_key", IMP_KEY);
        tokenReq.addProperty("imp_secret", IMP_SECRET);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(tokenReq.toString().getBytes("UTF-8"));
        }

        BufferedReader tokenReader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        JsonObject tokenRes = JsonParser.parseReader(tokenReader).getAsJsonObject();
        String accessToken = tokenRes.getAsJsonObject("response").get("access_token").getAsString();

        // 2. 결제 정보 조회
        URL payUrl = new URL("https://api.iamport.kr/payments/" + impUid);
        HttpURLConnection payConn = (HttpURLConnection) payUrl.openConnection();
        payConn.setRequestMethod("GET");
        payConn.setRequestProperty("Authorization", accessToken);

        BufferedReader payReader = new BufferedReader(new InputStreamReader(payConn.getInputStream()));
        JsonObject payRes = JsonParser.parseReader(payReader).getAsJsonObject();
        JsonObject payment = payRes.getAsJsonObject("response");

        int paidAmount = payment.get("amount").getAsInt();
        String status = payment.get("status").getAsString();

        // 3. 검증 (예: 우리 DB에서 주문 가격이 11000원이라고 가정)
        int expectedAmount = 11000; // TODO: merchantUid로 DB에서 주문 조회

        JsonObject jsonResponse = new JsonObject();
        if (paidAmount == expectedAmount && "paid".equals(status)) {
        	System.out.println("성공");
            jsonResponse.addProperty("result", "success");
            jsonResponse.addProperty("message", "결제 성공");
            
            // DB에 저장하는 알고리즘 
            
           
        } else {
        	System.out.println("fail");
            jsonResponse.addProperty("result", "fail");
            jsonResponse.addProperty("message", "결제 금액 불일치 또는 실패");
            
            // JSON 응답 반환/        
//            response.sendRedirect(CommonTemplate.WEB_VIEWS + "/point/addPoint.jsp");
                
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(gson.toJson(jsonResponse));
     
    }
    
}