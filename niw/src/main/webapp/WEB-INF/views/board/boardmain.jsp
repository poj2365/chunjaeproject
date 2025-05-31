<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List, 
				com.niw.board.model.dto.Article,
				com.niw.board.model.dto.Notice,
				java.time.LocalDateTime,
				java.sql.Timestamp,
				java.time.LocalDate,
				java.time.Duration"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
<script src="<%=request.getContextPath()%>/resources/js/board/board.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<% 
	int category = request.getParameter("category") == null? 0 : Integer.parseInt(request.getParameter("category")); 
	List<Article> articles = (List<Article>) request.getAttribute("articles");
	User user = (User) request.getSession().getAttribute("loginUser");
	List<Notice> notices = (List<Notice>) request.getAttribute("notices");
%>
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
                <li class="menu-item cursor-pointer <%=category == 0? "active":"" %>" 
                	onclick="activeChange(event, '/board/articlelist.do')" data-category="0">
                    전체글
                </li>
                <li class="menu-item cursor-pointer <%=category == 1? "active":"" %>" 
                	onclick="activeChange(event, '/board/articlelist.do')" data-category="1">
                    일반글
                </li>
                <li class="menu-item cursor-pointer <%=category == 2? "active":"" %>" 
                	onclick="activeChange(event, '/board/articlelist.do')" data-category="2">
                    질문글
                </li>
            </ul>
        </div>
    </aside>
	<!-- 메인보드 -->
	<article class="main-content col-lg-8">
		<!-- 게시글 상단 선택 요소 -->
		<div class="row flex-row justify-content-between mt-5">
			<div class="col-lg-5">
				<h2> 자유게시판 </h2>
			</div>
			<div class="col-lg-7 d-flex justify-content-end align-items-end">
				<div>
					<select id="order" class="form-select form-select-sm" onchange="searchArticle('1', '/board/articlelist.do')">
						<option value="0" selected>게시일순</option>
						<option value="1">추천수순</option>
						<option value="2">조회수순</option>
					</select>
				</div>
				<div>
					<select id="numPerPage" class="form-select form-select-sm" onchange="searchArticle('1', '/board/articlelist.do')">
						<option selected value="10">게시글수</option>
						<option value="10">10</option>
						<option value="30">30</option>
						<option value="50">50</option>
					</select>
				</div>
				<div>
					<form method="post" action="<%=request.getContextPath()%>/board/articlewrite.do" onsubmit="return checkLogin(<%=user!=null%>)">
						<button type="submit" class="btn btn-primary" style="width:80px">글쓰기</button>
					</form>
				</div>
			</div>
		</div>
		<hr>
		<!-- 게시글 리스트 컨테이너 -->
		<div id="notice-container">
			<%if(notices != null && !notices.isEmpty()) {
					for(Notice notice : notices){%>
						<div class="row flex-row justify-content-between align-items-center">
							<div class="col-lg-8 d-flex align-items-center">
								<span class="badge bg-danger me-3">공지</span>
								<span class="overflow-hidden">
									<a href="<%=request.getContextPath()%>/board/noticedetail.do?noticeId=<%=notice.noticeId()%>" class="text-decoration-none text-black">
										<%= notice.noticeTitle() %>
									</a>
								</span>
							</div>
							<ul class="list-unstyled row flex-row g-1 col-lg-3">
								<li><b>관리자</b> </li>
							</ul>
						</div>
						<hr>
					<%}
				}%>
		</div>
		<div id="article-container">
			<%if(articles != null && !articles.isEmpty()) {
				for(Article article : articles){
					boolean timeFlag = false;
					long hours = 0, minutes = 0, seconds = 0;
					LocalDateTime ldt = article.articleDateTime().toLocalDateTime();
					LocalDateTime now = LocalDateTime.now();
					if(ldt.toLocalDate().equals(now.toLocalDate())){
						timeFlag = true;
						Duration duration = Duration.between(ldt, now);
						hours = duration.toHours();
						minutes = duration.toMinutes() % 60;
						seconds = duration.toSeconds() % 60;
					}
				%>
					<div class="row flex-row justify-content-between align-items-center">
						<div class="col-lg-6 d-flex align-items-center">
							<span class="badge me-3
								<%switch(article.articleCategory()){
								case 1:%>
								bg-secondary
								<% break;
								case 2:%>
								bg-primary
								<% break;
								default:%>
								bg-dark
								<% break;
								} %>">
								<%switch(article.articleCategory()){
								case 1:%>
								일반
								<% break;
								case 2:%>
								질문
								<% break;
								default:%>
								미분류
								<% break;
								} %>
							</span>
							<span class="overflow-hidden">
								<a href="<%=request.getContextPath()%>/board/boarddetail.do?articleId=<%=article.articleId()%>" class="text-decoration-none text-black">
									<%= article.articleTitle() %>
								</a>
							</span>
						</div>
						<ul class="list-unstyled row flex-row g-1 col-lg-6">
							<li class="col-lg-2"><i class="bi-eye"><%= article.articleViews() %></i></li>
							<li class="col-lg-2"><i class="bi-hand-thumbs-up"><%= article.articleLikes() %></i></li>
							<li class="col-lg-2"><i class="bi-chat"><%= article.commentCount() %></i></li>
							<li class="col-lg-5"><%= article.userId()%> &middot; <%
								if(timeFlag){
									if(hours > 0){%><%=String.valueOf(hours)+"시간전"%>
									<%}else if(minutes > 0){%> <%= String.valueOf(minutes)+"분전"%>
									<%} else{%><%=String.valueOf(seconds)+"초전"%> 
								<%}} else {%>
									<%=ldt.toLocalDate()%>
								<%
							}%> </li>
							<li class="col-lg-1">
								<%if(user != null && (user.userId().equals(article.userId()) || user.userRole().equals("ADMIN"))){%>
									<i class="bi bi-x fw-bold border rounded-2 d-flex justify-content-center align-items-center"
									   style="width: 24px; height: 24px; cursor: pointer; font-style: normal;"
									   onclick="deleteArticle('<%= article.articleId() %>', '/board/boardentrance.do?category=0')"></i>
								<%} %>
							</li>
						</ul>						
					</div>
					<hr>
				<%}
			} else if(articles != null && articles.isEmpty()){%> 
				<div class="text-center">
					<b> 조회된 결과가 없습니다.</b>
				</div>
			<% } %>
				
		</div>
		<!-- 게시글 하단 선택요소 -->
		<div class="row flex-row justify-content-between mt-4">
			<div class="col-8 ml-4" id="search">
				<input type="text" placeholder="게시글 검색">
				<button type="button" class="btn btn-primary" onclick="searchFlag('1', '/board/articlelist.do')"> 검색 </button>
			</div>
			<div class="col-2">
				<select id="likes" class="form-select form-select-sm w-auto mr-4" onchange="searchArticle('1', '/board/articlelist.do')">
					<option value="0" selected>추천수</option>
					<option value="0">전체</option>
					<option value="5">5개 이상</option>
					<option value="10">10개 이상</option>
					<option value="50">50개 이상</option>
				</select>
			</div>
		</div>
		<div id="page-bar" class="col-12 text-center mt-4">
			<%if(request.getAttribute("pageBar") != null) { %>
				<%= request.getAttribute("pageBar") %>
			<%}%>
		</div>
	</article>
	
</section>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
			