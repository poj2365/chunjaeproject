<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="java.util.List, 
				com.niw.board.model.dto.Article,
				java.time.LocalDateTime,
				java.sql.Timestamp,
				java.time.LocalDate,
				java.time.Duration"%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
<script src="<%=request.getContextPath()%>/resources/js/board/board.js"></script>

<% 
	int category = request.getParameter("category") == null? 0 : Integer.parseInt(request.getParameter("category")); 
	List<Article> articles = (List<Article>) request.getAttribute("articles");
%>
<section class="row justify-content-between mt-4">
	<!-- 사이드 네비게이터 -->
	<aside class="card col-lg-2 ms-3 me-3">
		<div class="card-header">
			<h5 class="section-title">
				카테고리
			</h5><br>
			<ul id="category" class="list-group list-group-flush">
				<li class="list-group-item 
					<%if(category == 0){ %>
							active
					<%} %>
				">
					<a href="javascript:void(0);" onclick="activeChange(event);" data-category="0">전체글</a>
				</li>
				<li class="list-group-item <%if(category == 1){ %>
						active
					<%} %>
				">
					<a href="javascript:void(0);" onclick="activeChange(event);" data-category="1">일반글</a>
				</li>
				<li class="list-group-item 
					<%if(category == 2){ %>
						active
					<%} %>
				">
					<a href="javascript:void(0);" onclick="activeChange(event);" data-category="2">질문글</a>
				</li>
			</ul>
		</div>			
	</aside>
	<!-- 메인보드 -->
	<article class="col-lg-9 ms-3 me-3">
		<!-- 게시글 상단 선택 요소 -->
		<div class="row flex-row justify-content-between">
			<div class="col-lg-5">
				<h2> 자유게시판 </h2>
			</div>
			<div class="col-lg-7 d-flex justify-content-end align-items-end">
				<div>
					<select id="order" class="form-select form-select-sm" onchange="searchArticle()">
						<option value="0" selected>게시일순</option>
						<option value="1">추천수순</option>
						<option value="2">조회수순</option>
					</select>
				</div>
				<div>
					<select id="numPerPage" class="form-select form-select-sm" onchange="searchArticle()">
						<option selected value="10">게시글수</option>
						<option value="10">10</option>
						<option value="30">30</option>
						<option value="50">50</option>
					</select>
				</div>
				<div>
					<form action="">
						<button type="submit" class="btn btn-primary" style="width:80px">글쓰기</button>
					</form>
				</div>
			</div>
		</div>
		<hr>
		<!-- 게시글 리스트 컨테이너 -->
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
								<a href="/board/boarddetail.do?articleId=<%=article.articleId()%>" class="text-decoration-none text-black">
									<%= article.articleTitle() %>
								</a>
							</span>
						</div>
						<ul class="list-unstyled row flex-row g-1 col-lg-6">
							<li class="col-lg-2"><i class="bi-eye"></i> <%= article.articleViews() %></li>
							<li class="col-lg-2"><i class="bi-hand-thumbs-up"></i> <%= article.articleLikes() %></li>
							<li class="col-lg-2"><i class="bi-chat"></i> <%= article.commentCount() %></li>
							<li class="col-lg-6"><%= article.userId()%> &middot; <%
								if(timeFlag){
									if(hours > 0){%><%=String.valueOf(hours)+"시간전"%>
									<%}else if(minutes > 0){%> <%= String.valueOf(minutes)+"분전"%>
									<%} else{%><%=String.valueOf(seconds)+"초전"%> 
								<%}} else {%>
									<%=ldt.toLocalDate()%>
								<%
							}%> </li>
						</ul>						
					</div>
					<hr>
				<%}
			}%> 
				
		</div>
		<!-- 게시글 하단 선택요소 -->
		<div class="row flex-row justify-content-between mt-4">
			<div class="col-8 ml-4" id="search">
				<input type="text" placeholder="게시글 검색">
				<button type="button" class="btn btn-primary" onclick="searchArticle()"> 검색 </button>
			</div>
			<div class="col-2">
				<select id="likes" class="form-select form-select-sm w-auto mr-4" onchange="searchArticle()">
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
<%@include file="/WEB-INF/views/common/footer.jsp" %>
