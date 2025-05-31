<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.niw.board.model.dto.Notice,
				java.util.List"%>
<%
	Notice notice = (Notice) request.getAttribute("notice");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
<section class="mypage-container row flex-row m-4">
	<!-- 사이드 네비게이터 -->
	<aside class="sidebar col-lg-2">
        <div class="profile-section">
            <div class="profile-pic">
                <i class="bi bi-person-circle" style="font-size: 60px; color: #ccc;"></i>
            </div>
            <div class="user-id">Guest</div>
        </div>
        <div class="menu-section">
            <div class="menu-title" >카테고리</div>
            <ul id="category">
                <li class="menu-item cursor-pointer" 
                	onclick="location.assign('<%=request.getContextPath() %>/board/boardentrance.do?category=0')" data-category="0">
                    전체글
                </li>
                <li class="menu-item cursor-pointer" 
                	onclick="location.assign('<%=request.getContextPath() %>/board/boardentrance.do?category=1')" data-category="1">
                    일반글
                </li>
                <li class="menu-item cursor-pointer" 
                	onclick="location.assign('<%=request.getContextPath() %>/board/boardentrance.do?category=2')" data-category="2">
                    질문글
                </li>
            </ul>
        </div>
    </aside>
    <article class="main-content col-lg-8">	
	    <div class="d-flex flex-column">
	    	<div class="mb-3">
				<span class="badge bg-danger">공지</span>
			</div>
			<h2 class="mb-3">
				<%=notice.noticeTitle()%>
			</h2>
			<span class="mb-3">
				<b> 관리자 </b>
			</span>
    	</div>
		<hr>
		<div class="text-break">
			<%= notice.noticeContent() %>
		</div>
    </article>
</section>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="<%=request.getContextPath()%>/resources/js/board/board.js"></script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>