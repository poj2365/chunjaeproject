package com.niw.user.util;

import java.io.StringWriter;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 * JSP를 문자열로 렌더링하는 유틸리티 클래스
 */
public class JspRendererUtil {
    
    /**
     * JSP 파일을 렌더링해서 HTML 문자열로 반환
     * 
     * @param jspPath JSP 파일 경로 (예: "/email/verification-email.jsp")
     * @param attributeName request에 설정할 속성명
     * @param attributeValue request에 설정할 속성값
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return 렌더링된 HTML 문자열
     */
    public static String renderJspToString(String jspPath, String attributeName, String attributeValue, 
            HttpServletRequest request, HttpServletResponse response) {
        try {
            // request에 데이터 설정
            request.setAttribute(attributeName, attributeValue);
            
            return renderJsp(jspPath, request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorHtml("JSP 렌더링 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    /**
     * JSP 파일을 렌더링해서 HTML 문자열로 반환 (여러 속성 지원)
     * 
     * @param jspPath JSP 파일 경로
     * @param attributes request에 설정할 속성들 (Map<속성명, 속성값>)
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return 렌더링된 HTML 문자열
     */
    public static String renderJspToString(String jspPath, Map<String, Object> attributes, 
            HttpServletRequest request, HttpServletResponse response) {
        try {
            // request에 속성들 설정
            if (attributes != null) {
                for (Map.Entry<String, Object> entry : attributes.entrySet()) {
                    request.setAttribute(entry.getKey(), entry.getValue());
                }
            }
            
            return renderJsp(jspPath, request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorHtml("JSP 렌더링 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 실제 JSP 렌더링 수행
     */
    private static String renderJsp(String jspPath, HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        // StringWriter로 응답을 캡처할 수 있는 HttpServletResponse 래퍼 생성
        StringWriter stringWriter = new StringWriter();
        HttpServletResponseWrapper responseWrapper = new HttpServletResponseWrapper(response) {
            @Override
            public java.io.PrintWriter getWriter() throws java.io.IOException {
                return new java.io.PrintWriter(stringWriter);
            }
        };
        
        // JSP 렌더링
        RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
        dispatcher.include(request, responseWrapper);
        
        // 렌더링된 HTML 반환
        return stringWriter.toString().trim();
    }
    
    /**
     * 오류 발생 시 기본 HTML 반환
     */
    private static String getErrorHtml(String errorMessage) {
        return "<html><body style='font-family: Arial, sans-serif;'>" +
               "<h1 style='color: #dc3545;'>오류 발생</h1>" +
               "<p>" + errorMessage + "</p>" +
               "<p>관리자에게 문의해주세요.</p>" +
               "</body></html>";
    }
}