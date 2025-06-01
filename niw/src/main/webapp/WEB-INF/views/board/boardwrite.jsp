<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
<link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/45.1.0/ckeditor5.css" crossorigin>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<section class="mypage-container row flex-row m-4">
	<!-- 사이드 네비게이터 -->
	<aside class="sidebar col-lg-2">
        <div class="profile-section">
            <div class="profile-pic">
                <i class="bi bi-person-circle" style="font-size: 60px; color: #ccc;"></i>
            </div>
            <% if(loginUser!=null){%>
	            <div class="user-id"><%=loginUser.userId() %></div>
	            <div class="user-name"><%=loginUser.userName() %></div>
	            <div class="point-info">포인트:<%=loginUser.userPoint() %> P</div>
            <% }else{%>
            	<div class="user-id">Guest</div>
            <% }%>
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
	<!-- 메인보드 -->
	<article class="main-content col-lg-8">	
		<form action="<%=request.getContextPath()%>/board/savearticle.do" method="post">
			<div>
				<div class="d-flex flex-row justify-content-between align-items-center mb-3">
					<div class="d-flex flex-row align-items-center">
						<select name="category" class="form-select" style="min-width:100px">
							<option value="1">일반</option>
							<option value="2">질문</option>
						</select>
						<select name="date" id="scheduleSelect" class="form-select" style="min-width:200px">
							<option value="0" selected>바로 등록</option>
							<option value="1">1시간 후</option>
							<option value="3">3시간 후</option>
							<option value="24">24시간 후</option>
							<option value="-1">직접 입력</option>
						</select>
						<input 
							name="custom"
							type="text" 
							id="customDatetime" 
							class="form-control d-none"
							placeholder="날짜 선택 → 시간 선택"
							style="min-width:200px">
					</div>
					<button type="submit" class="btn btn-primary">작성</button>	     
				</div>
				<input type="text" class="form-control mb-3" id="postTitle" placeholder="제목을 입력하세요" name="title">
			</div>
		    <div class="main-container">
				<div class="editor-container editor-container_classic-editor" id="editor-container">
					<div class="editor-container__editor"><div id="editor"></div></div>
				</div>
			</div>
			<input type="hidden" id="content" name="content">
			</form>
	</article>
</section>
<script>
	const CKEDITOR_INITIAL_DATA = "";
</script>
<script src="https://cdn.ckeditor.com/ckeditor5/45.1.0/ckeditor5.umd.js" crossorigin></script>
<script src="https://cdn.ckeditor.com/ckeditor5/45.1.0/translations/ko.umd.js" crossorigin></script>
<script src="https://cdn.ckbox.io/ckbox/2.6.1/ckbox.js" crossorigin></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="<%=request.getContextPath()%>/resources/js/board/board.js"></script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>