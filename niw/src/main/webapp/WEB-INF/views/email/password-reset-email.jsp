<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습메이트 비밀번호 찾기</title>
    <style>
        body { 
            font-family: 'Malgun Gothic', '맑은 고딕', Arial, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background-color: #f8f9fa; 
        }
        .container { 
            max-width: 600px; 
            margin: 0 auto; 
            background-color: white; 
            border-radius: 10px; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
            overflow: hidden; 
        }
        .header { 
            background: linear-gradient(135deg, #24b1b5, #1a8a8e); 
            padding: 30px; 
            text-align: center; 
            color: white; 
        }
        .header h1 { 
            margin: 0; 
            font-size: 28px; 
            font-weight: bold; 
        }
        .content { 
            padding: 40px 30px; 
        }
        .greeting { 
            font-size: 18px; 
            margin-bottom: 20px; 
            color: #333; 
        }
        .verification-box { 
            background-color: #f8f9fa; 
            border: 2px dashed #24b1b5; 
            border-radius: 10px; 
            padding: 25px; 
            text-align: center; 
            margin: 30px 0; 
        }
        .verification-title { 
            font-size: 16px; 
            color: #666; 
            margin-bottom: 10px; 
        }
        .verification-code { 
            font-size: 32px; 
            font-weight: bold; 
            color: #24b1b5; 
            letter-spacing: 3px; 
            margin: 15px 0; 
        }
        .info-box { 
            background-color: #e3f6f7; 
            border-radius: 8px; 
            padding: 20px; 
            margin: 25px 0; 
        }
        .info-title { 
            font-size: 16px; 
            font-weight: bold; 
            color: #1a8a8e; 
            margin-bottom: 10px; 
        }
        .info-text { 
            font-size: 14px; 
            color: #555; 
            line-height: 1.6; 
        }
        .warning { 
            background-color: #fff3cd; 
            border: 1px solid #ffeaa7; 
            border-radius: 5px; 
            padding: 15px; 
            margin: 20px 0; 
        }
        .warning-text { 
            color: #856404; 
            font-size: 14px; 
        }
        .footer { 
            background-color: #f8f9fa; 
            padding: 20px; 
            text-align: center; 
            border-top: 1px solid #eee; 
        }
        .footer-text { 
            color: #666; 
            font-size: 12px; 
            line-height: 1.5; 
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 헤더 -->
        <div class="header">
            <h1>🔐 학습메이트</h1>
            <p style="margin: 10px 0 0 0; font-size: 16px;">비밀번호 찾기 인증번호</p>
        </div>
        
        <!-- 내용 -->
        <div class="content">
            <div class="greeting">안녕하세요, <strong>${userName}</strong>님!</div>
            <p style="color: #666; line-height: 1.6;">
                학습메이트 비밀번호 찾기를 요청하셨습니다.<br>
                아래 인증번호를 입력하여 비밀번호 초기화를 완료해주세요.
            </p>
            
            <!-- 사용자 정보 -->
            <div class="info-box">
                <div class="info-title">📋 요청 정보</div>
                <div class="info-text">
                    • 사용자 아이디: <strong>${userId}</strong><br>
                    • 요청 시간: <strong><%= new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm").format(new Date()) %></strong>
                </div>
            </div>
            
            <!-- 인증번호 -->
            <div class="verification-box">
                <div class="verification-title">인증번호</div>
                <div class="verification-code">${verificationCode}</div>
                <p style="margin: 0; font-size: 14px; color: #888;">위 번호를 비밀번호 찾기 페이지에 입력하세요</p>
            </div>
            
            <!-- 주의사항 -->
            <div class="warning">
                <div class="warning-text">
                    ⚠️ <strong>중요 안내사항</strong><br>
                    • 인증번호 유효시간: <strong>5분</strong><br>
                    • 인증 완료 시 비밀번호가 <strong>abcd1234!</strong>로 초기화됩니다<br>
                    • 로그인 후 반드시 새로운 비밀번호로 변경해주세요<br>
                    • 본인이 요청하지 않았다면 이 이메일을 무시하세요
                </div>
            </div>
            
            <p style="color: #666; font-size: 14px; line-height: 1.6;">
                만약 비밀번호 찾기를 요청하지 않으셨다면, 이 이메일을 무시하셔도 됩니다.<br>
                계정 보안에 문제가 있다고 생각되시면 고객센터로 문의해주세요.
            </p>
        </div>
        
        <!-- 푸터 -->
        <div class="footer">
            <div class="footer-text">
                본 메일은 발신전용 메일입니다. 문의사항이 있으시면 고객센터를 이용해주세요.<br>
                © 2024 학습메이트. All rights reserved.<br>
                서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F
            </div>
        </div>
    </div>
</body>
</html>