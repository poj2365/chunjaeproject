<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User" %>


 <%@ include file="/WEB-INF/views/common/header.jsp" %>
 <%
      if(loginUser == null) {
        response.sendRedirect(request.getContextPath() + "/user/loginview.do");
        return; 
      }
%>






<%@ include file="/WEB-INF/views/common/footer.jsp" %>