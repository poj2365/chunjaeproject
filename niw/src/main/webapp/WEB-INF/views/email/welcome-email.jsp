<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String userName = (String) request.getAttribute("userName");
    if (userName == null) userName = "회원";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습메이트 회원가입 환영</title>
</head>
<body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f5f6f7;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f5f6f7; padding: 20px;">
        <tr>
            <td align="center">
                <!-- 메인 컨테이너 -->
                <table width="600" cellpadding="0" cellspacing="0" style="background-color: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                    <!-- 헤더 -->
                    <tr>
                        <td style="padding: 40px 40px 20px; text-align: center; background: linear-gradient(135deg, #24b1b5 0%, #ff7d4d 100%); border-radius: 12px 12px 0 0;">
                            <h1 style="color: white; margin: 0; font-size: 28px;">🎉 환영합니다!</h1>
                            <p style="color: rgba(255,255,255,0.9); margin: 5px 0 0; font-size: 16px;">학습메이트 회원가입 완료</p>
                        </td>
                    </tr>
                    
                    <!-- 본문 -->
                    <tr>
                        <td style="padding: 40px;">
                            <h2 style="color: #333; margin: 0 0 20px; font-size: 24px;">안녕하세요, <%= userName %>님!</h2>
                            <p style="color: #666; margin: 0 0 30px; font-size: 16px; line-height: 1.6;">
                                학습메이트의 회원이 되신 것을 진심으로 축하드립니다!<br>
                                이제 다양한 학습 콘텐츠와 서비스를 자유롭게 이용하실 수 있습니다.
                            </p>
                            
                            <!-- 주요 서비스 소개 -->
                            <div style="background-color: #f8f9fa; border-radius: 12px; padding: 30px; margin: 30px 0;">
                                <h3 style="color: #24b1b5; margin: 0 0 20px; font-size: 20px;">🚀 주요 서비스</h3>
                                <ul style="margin: 0; padding-left: 20px; color: #666; line-height: 1.8;">
                                    <li><strong>학습자료:</strong> 다양한 강의 노트와 문제집을 제공합니다</li>
                                    <li><strong>스터디 매칭:</strong> 함께 공부할 스터디 그룹을 찾아보세요</li>
                                    <li><strong>커뮤니티:</strong> 학습 정보를 공유하고 질문해보세요</li>
                                    <li><strong>일정관리:</strong> 체계적인 학습 계획을 세워보세요</li>
                                    <li><strong>학습분석:</strong> 나의 학습 패턴을 분석해보세요</li>
                                </ul>
                            </div>
                            
                            <!-- 시작하기 버튼 -->
                            <div style="text-align: center; margin: 40px 0;">
                                <a href="#" style="display: inline-block; background-color: #24b1b5; color: white; text-decoration: none; padding: 15px 30px; border-radius: 25px; font-size: 16px; font-weight: bold; transition: all 0.3s;">
                                    지금 시작하기 →
                                </a>
                            </div>
                            
                            <!-- 도움말 섹션 -->
                            <div style="background-color: #e3f6f7; border-radius: 8px; padding: 20px; margin: 20px 0;">
                                <h4 style="color: #24b1b5; margin: 0 0 10px; font-size: 16px;">💡 도움이 필요하시나요?</h4>
                                <p style="color: #666; margin: 0; font-size: 14px; line-height: 1.6;">
                                    • <strong>이용가이드:</strong> 서비스 사용법을 자세히 안내해드립니다<br>
                                    • <strong>고객센터:</strong> 언제든지 문의해주세요 (평일 09:00-18:00)<br>
                                    • <strong>FAQ:</strong> 자주 묻는 질문들을 확인해보세요
                                </p>
                            </div>
                            
                            <p style="color: #999; margin: 30px 0 0; font-size: 14px;">
                                다시 한번 학습메이트를 선택해주셔서 감사합니다.<br>
                                함께 성장하는 학습 여정을 시작해보세요!<br><br>
                                <strong>학습메이트 팀 드림</strong>
                            </p>
                        </td>
                    </tr>
                    
                    <!-- 소셜 미디어 -->
                    <tr>
                        <td style="padding: 20px 40px; background-color: #f8f9fa; text-align: center;">
                            <p style="color: #666; margin: 0 0 15px; font-size: 14px;">학습메이트를 팔로우하세요!</p>
                            <div style="margin-bottom: 20px;">
                                <a href="#" style="display: inline-block; margin: 0 10px; color: #24b1b5; font-size: 24px; text-decoration: none;">📘</a>
                                <a href="#" style="display: inline-block; margin: 0 10px; color: #24b1b5; font-size: 24px; text-decoration: none;">📸</a>
                                <a href="#" style="display: inline-block; margin: 0 10px; color: #24b1b5; font-size: 24px; text-decoration: none;">🐦</a>
                                <a href="#" style="display: inline-block; margin: 0 10px; color: #24b1b5; font-size: 24px; text-decoration: none;">▶️</a>
                            </div>
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