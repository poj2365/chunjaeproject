package com.niw.user.controller;

import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.niw.user.util.JspRendererUtil;

public class SendEmail {
    /**
     * 이메일 발송 서비스 (JSP 템플릿 사용)
     */
    
    // 이메일 설정 (실제 운영 시에는 설정파일이나 환경변수로 관리)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_ID = "nulliswell@gmail.com"; // 발송용 Gmail 계정
    private static final String EMAIL_PASSWORD = "hadjykcilxwzaaof"; // Gmail 앱 비밀번호
    private static final String FROM_NAME = "학습메이트";
    
    /**
     * 이메일 인증번호 발송
     * 
     * @param toEmail 수신자 이메일
     * @param verificationCode 인증번호
     * @param request HttpServletRequest (JSP 렌더링용)
     * @param response HttpServletResponse (JSP 렌더링용)
     * @return 발송 성공 여부
     */
    public boolean sendVerificationEmail(String toEmail, String verificationCode, 
            HttpServletRequest request, HttpServletResponse response) {
        try {
            // SMTP 설정
            Properties props = getSmtpProperties();
            
            // 인증정보로 세션 생성
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_ID, EMAIL_PASSWORD);
                }
            });
            
            // 메시지 작성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_ID, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("학습메이트 이메일 인증번호");
            
            // JSP 템플릿을 렌더링해서 HTML 이메일 내용 생성
            String htmlContent = JspRendererUtil.renderJspToString(
                "/WEB-INF/views/email/verification-email.jsp", 
                "verificationCode", 
                verificationCode, 
                request, 
                response
            );
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
//            System.out.println();
            // 이메일 발송
            Transport.send(message);
            
            System.out.println("인증 이메일 발송 성공: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("인증 이메일 발송 실패: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 회원가입 완료 알림 이메일 발송
     * 
     * @param toEmail 수신자 이메일
     * @param userName 사용자 이름
     * @param request HttpServletRequest (JSP 렌더링용)
     * @param response HttpServletResponse (JSP 렌더링용)
     * @return 발송 성공 여부
     */
    public boolean sendWelcomeEmail(String toEmail, String userName, 
            HttpServletRequest request, HttpServletResponse response) {
        try {
            // SMTP 설정
            Properties props = getSmtpProperties();
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_ID, EMAIL_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_ID, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("학습메이트 회원가입을 환영합니다!");
            
            // JSP 템플릿을 렌더링해서 HTML 이메일 내용 생성
            String htmlContent = JspRendererUtil.renderJspToString(
                "/email/welcome-email.jsp", 
                "userName", 
                userName, 
                request, 
                response
            );
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            
            System.out.println("환영 이메일 발송 성공: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("환영 이메일 발송 실패: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 복잡한 이메일 발송 (여러 데이터 포함)
     * 
     * @param toEmail 수신자 이메일
     * @param subject 이메일 제목
     * @param jspPath JSP 템플릿 경로
     * @param templateData 템플릿에 전달할 데이터
     * @param request HttpServletRequest
     * @param response HttpServletResponse
     * @return 발송 성공 여부
     */
    public boolean sendTemplateEmail(String toEmail, String subject, String jspPath, 
            Map<String, Object> templateData, HttpServletRequest request, HttpServletResponse response) {
        try {
            // SMTP 설정
            Properties props = getSmtpProperties();
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_ID, EMAIL_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_ID, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            
            // JSP 템플릿을 렌더링해서 HTML 이메일 내용 생성
            String htmlContent = JspRendererUtil.renderJspToString(
                jspPath, 
                templateData, 
                request, 
                response
            );
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            
            System.out.println("템플릿 이메일 발송 성공: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("템플릿 이메일 발송 실패: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * SMTP 설정 Properties 반환
     */
    private Properties getSmtpProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        return props;
    }
}