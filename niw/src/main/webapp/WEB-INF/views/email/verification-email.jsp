<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String verificationCode = (String) request.getAttribute("verificationCode");
    if (verificationCode == null) verificationCode = "";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습메이트 이메일 인증</title>
</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f5f6f7;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f5f6f7; padding: 20px;">
        <tr>
            <td align="center">
                <!-- 메인 컨테이너 -->
                <table width="600" cellpadding="0" cellspacing="0" style="background-color: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                    <!-- 헤더 -->
                    <tr>
                        <td style="padding: 40px 40px 20px; text-align: center; background-color: #24b1b5; border-radius: 12px 12px 0 0;">
                            <h1 style="color: white; margin: 0; font-size: 28px;">학습메이트</h1>
                            <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0; font-size: 16px;">이메일 인증</p>
                        </td>
                    </tr>
                    
                    <!-- 본문 -->
                    <tr>
                        <td style="padding: 40px;">
                            <h2 style="color: #333; margin: 0 0 20px; font-size: 24px;">이메일 인증번호</h2>
                            <p style="color: #666; margin: 0 0 30px; font-size: 16px; line-height: 1.6;">
                                안녕하세요!<br>
                                학습메이트 회원가입을 위한 이메일 인증번호를 안내드립니다.<br>
                                아래 인증번호를 회원가입 페이지에 입력해주세요.
                            </p>
                            
                            <!-- 인증번호 박스 -->
                            <div style="background-color: #e3f6f7; padding: 30px; border-radius: 8px; text-align: center; margin: 30px 0;">
                                <p style="color: #666; margin: 0 0 10px; font-size: 14px;">인증번호</p>
                                <h1 style="color: #24b1b5; margin: 0; font-size: 48px; font-weight: bold; letter-spacing: 8px;">
                                    <%= verificationCode %>
                                </h1>
                            </div>
                            
                            <!-- 주의사항 -->
                            <div style="background-color: #fff3cd; border: 1px solid #ffeaa7; border-radius: 8px; padding: 20px; margin: 20px 0;">
                                <p style="color: #856404; margin: 0; font-size: 14px;">
                                    <strong>주의사항:</strong><br>
                                    • 인증번호는 발송 후 5분간 유효합니다.<br>
                                    • 인증번호를 타인에게 알리지 마세요.<br>
                                    • 본인이 요청하지 않은 인증이라면 무시하세요.
                                </p>
                            </div>
                            
                            <p style="color: #999; margin: 30px 0 0; font-size: 14px;">
                                감사합니다.<br>
                                학습메이트 팀
                            </p>
                        </td>
                    </tr>
                    
                    <!-- 푸터 -->
                    <tr>
                        <td style="padding: 20px 40px; background-color: #f8f9fa; border-radius: 0 0 12px 12px; text-align: center;">
                            <p style="color: #999; margin: 0; font-size: 12px;">
                                <br>
                                © 2024 학습메이트. All rights reserved.
                            </p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>