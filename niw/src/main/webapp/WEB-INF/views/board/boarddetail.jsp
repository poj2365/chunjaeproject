<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.niw.board.model.dto.Article, 
				com.niw.board.model.dto.Comment, 
				com.niw.board.model.dto.Notice,
				java.util.List,
				java.time.LocalDateTime,
				java.time.Duration"%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">

<% 
	Article article = (Article) request.getAttribute("article"); 
	List<Comment> comments = (List<Comment>) request.getAttribute("comments");
	int category = request.getParameter("category") == null? 0 : Integer.parseInt(request.getParameter("category"));
	
	int order = (int) request.getAttribute("order");
	int numPerPage = (int) request.getAttribute("numPerPage");
	int likes = (int) request.getAttribute("likes");
	int cPage = (int) request.getAttribute("cPage");
	String searchData = (String) request.getAttribute("searchData");
	List<Article> articles = (List<Article>) request.getAttribute("articles");
	User user = (User) session.getAttribute("loginUser");
	int bookmark = (int) request.getAttribute("bookmark");
	int report = (int) request.getAttribute("report");
	int likedArticle = (int) request.getAttribute("likedArticle");
	int dislikedArticle = (int) request.getAttribute("dislikedArticle");
	List<Integer> reportedComment = (List<Integer>) request.getAttribute("reportedComment");
	List<Integer> likedComment = (List<Integer>) request.getAttribute("likedComment");
	List<Integer> dislikedComment = (List<Integer>) request.getAttribute("dislikedComment");
	String queryUrl = request.getQueryString();
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
                	onclick="location.assign('<%=request.getContextPath() %>/board/boardentrance.do?category=0')" data-category="0">
                    전체글
                </li>
                <li class="menu-item cursor-pointer <%=category == 1? "active":"" %>" 
                	onclick="location.assign('<%=request.getContextPath() %>/board/boardentrance.do?category=1')" data-category="1">
                    일반글
                </li>
                <li class="menu-item cursor-pointer <%=category == 2? "active":"" %>" 
                	onclick="location.assign('<%=request.getContextPath() %>/board/boardentrance.do?category=2')" data-category="2">
                    질문글
                </li>
            </ul>
        </div>
    </aside>
	<!-- 메인보드 -->
	<article class="main-content col-lg-8">
		<div class="">
			<div class="d-flex flex-column">
			<%
				boolean timeFlag = false, mtimeFlag = false;
				long hours = 0, minutes = 0, seconds = 0;
				LocalDateTime ldt = article.articleDateTime().toLocalDateTime();
				LocalDateTime mldt = null;
				if(article.articleModifiedTime() != null){
					mldt = article.articleModifiedTime().toLocalDateTime();
				}
				LocalDateTime now = LocalDateTime.now();
				if(ldt.toLocalDate().equals(now.toLocalDate())){
					timeFlag = true;
					Duration duration = Duration.between(ldt, now);
					hours = duration.toHours();
					minutes = duration.toMinutes() % 60;
					seconds = duration.toSeconds() % 60;
				}
				long mhours = 0, mminutes = 0, mseconds = 0;
				if(mldt != null && mldt.toLocalDate().equals(now.toLocalDate())){
					mtimeFlag = true;
					Duration duration = Duration.between(mldt, now);
					mhours = duration.toHours();
					mminutes = duration.toMinutes() % 60;
					mseconds = duration.toSeconds() % 60;
				}
				
			%>
				<div class="mb-3">
					<span class="badge
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
				</div>
				<h2 class="mb-3">
					<%=article.articleTitle()%>
				</h2>
				<span class="mb-3">
					<%= article.userId()%>
				</span>
				<div class="row flex-row justify-content-between align-items-center">
					<div class="col-lg-6 row flex-row">
						<div class="col-lg-6">
							<i class="bi bi-clock">
								<span class="d-inline-block">
									<%if (timeFlag) {
									    if (hours > 0) {%>
									        <%= hours + "시간전" %>
									<%} else if (minutes > 0) {	%>
									        <%= minutes + "분전" %>
									<%} else {%>
									        <%= seconds + "초전" %>
									<%}
									} else {%>
									    <%= ldt.toString().split("T")[0] + " " + ldt.toString().split("T")[1].split(":")[0] + ":" + ldt.toString().split("T")[1].split(":")[1] %>
									<%}%> 
								</span>
								<span class="d-inline-block">
									<%if(mldt != null){ %>
										(
										<%if(mtimeFlag){ %>
											<% if(mhours > 0) {%>
										        <%= mhours + "시간전" %>
											<%} else if (mminutes > 0) {%>
										        <%= mminutes + "분전" %>
											<%} else {%>
										        <%= mseconds + "초전" %>
											<%} %>
										<%} else {%>
										    <%= mldt.toString().split("T")[0] + " " + mldt.toString().split("T")[1].split(":")[0] + ":" + mldt.toString().split("T")[1].split(":")[1] %>
										<%}%>
										 수정됨 )
									<% } %>
								</span>
							</i>
						</div>
						<div class="col-lg-2">
							<i class="bi-eye">
								<span class="d-inline-block">
									<%= article.articleViews() %>
								</span>
							</i>
						</div>
						<div class="col-lg-2">
							<i class="bi-chat">
								<span class="d-inline-block">
									<%= article.commentCount() %>
								</span>
							</i>
						</div>
					</div>
					<div class="col-lg-4 d-flex justify-content-end text-end">
						<%if(user != null && !user.userId().trim().equals("") && (user.userId().equals(article.userId()) || user.userRole().equals("ADMIN"))) {%>
							<button class="btn btn-danger me-1" onclick="deleteArticle('<%= article.articleId() %>', '/board/boardentrance.do?category=0')"> 삭제 </button>
							<button class="btn btn-primary me-1" onclick="location.assign('<%=request.getContextPath()%>/board/modifyarticle.do?articleId=<%=article.articleId() %>')"> 수정 </button>
						<%} %>
						<form action="" method="get">
	    	                <button type="button" class="btn btn-danger me-1" <%= report == 0? "" : "disabled" %> data-bs-toggle="modal" data-bs-target="#reportModal"
	    	                 data-user-id="<%=user == null? "" : user.userId()%>" data-target-id="<%= article.articleId()%>" data-target-type="ARTICLE">
	        	                신고
	   	        	        </button>
		               	</form>
						<button id="bookmark" class="btn btn-primary <%= bookmark == 0? "" : "btn-outline-warning" %>" 
							onclick="saveBookmark('<%=user == null? "" : user.userId()%>', '<%=article.articleId()%>')" data-flag="<%= bookmark %>">
							<i class="<%= bookmark == 0? "bi-bookmark":"bi-bookmark-fill" %>"></i>
						</button>
					</div>
				</div>
			</div>
			<hr>
			<div id="article-content" class="text-break">
				<div class="mb-5">
					<%= article.articleContent() %>	
				</div>
				<br><br>
				<div class="row flex-row  justify-content-center align-items-center">
					<span class="col-lg-1 border p-3 rounded text-center me-3"
						  onclick="insertRecommend(event, '1', 'ARTICLE', '<%= user == null? "" : user.userId()%>')" 
						  data-target-id="<%= article.articleId()%>">
						<i class="cursor-pointer <%= likedArticle == 0? "bi-hand-thumbs-up" : "bi-hand-thumbs-up-fill" %> cursor-pointer">
							<%= article.articleLikes() %>
						</i>
					</span>
					<span class="cursor-pointer col-lg-1  border p-3 rounded text-center" onclick="insertRecommend(event, '0', 'ARTICLE', '<%= user == null? "" : user.userId()%>')" data-target-id="<%= article.articleId()%>">
						<i class="<%= dislikedArticle == 0? "bi-hand-thumbs-down" : "bi-hand-thumbs-down-fill" %> cursor-pointer">
							<%= article.articleDislikes() %>
						</i>
					</span>
				</div>	
			</div>
			<hr>
			<div class="comment-header">
	            <div class="row flex-row justify-content-between align-items-center">
	                <div class="col-lg-3">
	                    <h5> 댓글 <span><%= article.commentCount() %></span></h5>
	                </div>
	                <div class="col-lg-1 text-end">
	                    <button class="btn btn-primary" data-target-id="<%=article.articleId() %>"
		                    onclick="writeComment(event, '0', '<%= user == null? "": user.userId()%>', '<%= queryUrl %>')"> 
		                    댓글
		                </button>
	                </div>
	            </div>
	            <hr>
	        </div>
	         <% for(int i = 0; i < comments.size(); i++) { 
	        	boolean cFlag = false;
				long chours = 0, cminutes = 0, cseconds = 0;
				LocalDateTime cldt = comments.get(i).commentDateTime().toLocalDateTime();
				if(cldt.toLocalDate().equals(now.toLocalDate())){
					cFlag = true;
					Duration duration = Duration.between(cldt, now);
					chours = duration.toHours();
					cminutes = duration.toMinutes() % 60;
					cseconds = duration.toSeconds() % 60;
				}
	        	if(comments.get(i).commentLevel() == 0) {%>
					<div class="comment level-0">
						<div>
			                <span><%= comments.get(i).userId() %></span>
			            </div>
			            <div class="text-break comment-content">
			            	<%= comments.get(i).commentContent()%>
			            </div>
			            <div class="d-flex justify-content-between align-items-center">
			                <div style="color: gray;">
			                    <span class="col-lg-2 me-3">
			                    	<%if (cFlag) {
									    if (chours > 0) {%>
									        <%= chours + "시간전" %>
									<%} else if (cminutes > 0) {	%>
									        <%= cminutes + "분전" %>
									<%} else {%>
									        <%= cseconds + "초전" %>
									<%}
									} else {%>
									    <%= cldt.toString().split("T")[0] + " " + cldt.toString().split("T")[1].split(":")[0] + ":" + cldt.toString().split("T")[1].split(":")[1] %>
									<%}%>
									<%if(comments.get(i).commentModified() == 0) {%>
										(수정됨)
									<%} %>
			                    </span>
			                    <span class="col-lg-1  me-3" 
			                    	  onclick="insertRecommend(event, '1', 'COMMENTS', '<%= user == null? "" : user.userId()%>')"
			                    	  data-target-id="<%= comments.get(i).commentId()%>">
			                    	<i class="cursor-pointer <%= likedComment.get(i) == 0? "bi-hand-thumbs-up" : "bi-hand-thumbs-up-fill" %> cursor-pointer">
										<%= comments.get(i).commentLikes() %>
									</i> 
			                    </span>
			                    <span class="col-lg-1 " 
			                    	  onclick="insertRecommend(event, '0', 'COMMENTS', '<%= user == null? "" : user.userId()%>')"
	               	               	  data-target-id="<%= comments.get(i).commentId()%>">		                    	  
			                    	<i class="cursor-pointer <%=dislikedComment.get(i) == 0? "bi-hand-thumbs-down" : "bi-hand-thumbs-down-fill" %> cursor-pointer">
										<%= comments.get(i).commentDislikes() %>
									</i>
			                    </span>
			                </div>
			                <div class="d-flex justify-content-between align-items-center">
				                <%if(user != null && !user.userId().trim().equals("") && (user.userId().equals(article.userId()) || user.userRole().equals("ADMIN"))) {%>
									<button class="btn btn-danger me-1" onclick="deleteComment('<%= comments.get(i).commentId() %>', '<%=article.articleId() %>')"> 삭제 </button>
									<button class="btn btn-primary me-1" onclick="updateComment(event, '<%= comments.get(i).commentId() %>', '<%= article.articleId() %>')"> 수정 </button>
								<%} %>
		                        <form action="" method="get">
			                        <button <%= reportedComment.get(i) == 0? "" : "disabled" %> type="button" class="btn btn-danger me-1" data-bs-toggle="modal"
			                         data-bs-target="#reportModal" data-user-id="<%=user == null? "" : user.userId()%>" data-target-id="<%= comments.get(i).commentId()%>" data-target-type="COMMENTS">
			                            신고
			                        </button>
			                	</form>
			                    <button class="btn btn-primary" data-target-id="<%=comments.get(i).commentId() %>"
			                    	onclick="writeComment(event, '1', '<%= user == null? "": user.userId() %>', '<%= queryUrl %>')"> 댓글 </button>
			                </div>
			            </div>
			            <hr>
					</div>
				<% } else { %>
					<div class="comment level-1">
						<div>
			                <span style="color:blue"> @<%=comments.get(i).userRef() %> </span> <span><%= comments.get(i).userId() %></span>
			            </div>
			            <div class="text-break comment-content">
			            	<%= comments.get(i).commentContent()%>
			            </div>
			            <div class="d-flex justify-content-between align-items-center">
			                <div style="color: gray;">
			                    <span class="col-lg-2 me-3">
			                    	<%if (cFlag) {
									    if (chours > 0) {%>
									        <%= chours + "시간전" %>
									<%} else if (cminutes > 0) {	%>
									        <%= cminutes + "분전" %>
									<%} else {%>
									        <%= cseconds + "초전" %>
									<%}
									} else {%>
									    <%= cldt.toString().split("T")[0] + " " + cldt.toString().split("T")[1].split(":")[0] + ":" + cldt.toString().split("T")[1].split(":")[1] %>
									<%}%>
									<%if(comments.get(i).commentModified() == 0) {%>
										(수정됨)
									<%} %>
			                    </span>
			                    <span class="col-lg-1  me-3" 
			                    	  onclick="insertRecommend(event, '1', 'COMMENTS', '<%= user == null? "" : user.userId()%>')"
			                    	  data-target-id="<%= comments.get(i).commentId()%>">
			                    	<i class="cursor-pointer <%= likedComment.get(i) == 0? "bi-hand-thumbs-up" : "bi-hand-thumbs-up-fill" %> cursor-pointer">
										<%= comments.get(i).commentLikes() %>
									</i> 
			                    </span>
			                    <span class="col-lg-1 " 
			                    	  onclick="insertRecommend(event, '0', 'COMMENTS', '<%= user == null? "" : user.userId()%>')"
	               	               	  data-target-id="<%= comments.get(i).commentId()%>">		                    	  
			                    	<i class="cursor-pointer <%=dislikedComment.get(i) == 0? "bi-hand-thumbs-down" : "bi-hand-thumbs-down-fill" %> cursor-pointer">
										<%= comments.get(i).commentDislikes() %>
									</i>
			                    </span>
			                </div>
			                <div class="d-flex justify-content-between align-items-center">
			                	<%if(user != null && !user.userId().trim().equals("") && (user.userId().equals(article.userId()) || user.userRole().equals("ADMIN"))) {%>
									<button class="btn btn-danger me-1" onclick="deleteComment('<%= comments.get(i).commentId()%>', '<%=article.articleId() %>')"> 삭제 </button>
									<button class="btn btn-primary me-1" onclick="updateComment(event, '<%= comments.get(i).commentId() %>', '<%= article.articleId() %>')"> 수정 </button>
								<%} %>
		                        <form action="" method="get">
			                        <button <%= reportedComment.get(i) == 0? "" : "disabled" %> type="button" class="btn btn-danger me-1" data-bs-toggle="modal" data-bs-target="#reportModal"
			                         data-user-id="<%=user == null? "" : user.userId()%>" data-target-id="<%= comments.get(i).commentId() %>" data-target-type="COMMENTS">
			                            신고
			                        </button>
			                	</form>
			                    <button class="btn btn-primary" data-target-id="<%=comments.get(i).commentId() %>"
			                    	onclick="writeComment(event, '1', '<%= user == null? "": user.userId() %>', '<%= queryUrl%>')"> 댓글 </button>
			                </div>
			            </div>
			            <hr>
					</div>
				<% } %>
			<%} %>
		</div>
		<div class=" mt-5 mb-5">
			<div class="d-flex justify-content-end align-items-end">
				<div>
					<select id="order" class="form-select form-select-sm" onchange="searchArticle('<%=cPage%>', '/board/underarticle.do')">
						<option value="0" <%= order == 0? "selected": "" %>>게시일순</option>
						<option value="1" <%= order == 1? "selected": "" %>>추천수순</option>
						<option value="2" <%= order == 2? "selected": "" %>>조회수순</option>
					</select>
				</div>
				<div>
					<select id="numPerPage" class="form-select form-select-sm" onchange="searchArticle('<%=cPage%>', '/board/underarticle.do')">
						<option value="10">게시글수</option>
						<option value="10" <%=numPerPage == 10? "selected" : "" %>>10</option>
						<option value="30" <%=numPerPage == 30? "selected" : "" %>>30</option>
						<option value="50" <%=numPerPage == 50? "selected" : "" %>>50</option>
					</select>
				</div>
				<div>
					<form action="<%=request.getContextPath()%>/board/articlewrite.do" onsubmit="return checkLogin(<%=user!=null%>)">
						<button type="submit" class="btn btn-primary" style="width:80px">글쓰기</button>
					</form>
				</div>
			</div>
			<hr>
			<!-- ajax article list -->
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
				<%for(Article a : articles){ 
					boolean tFlag = false;
					long h = 0, m = 0, s = 0;
					LocalDateTime uldt = a.articleDateTime().toLocalDateTime();
					if(uldt.toLocalDate().equals(now.toLocalDate())){
						tFlag = true;
						Duration duration = Duration.between(uldt, now);
						h = duration.toHours();
						m = duration.toMinutes() % 60;
						s = duration.toSeconds() % 60;
					}%>
					<div class="row flex-row justify-content-between align-items-center">
					<div class="col-lg-6 d-flex align-items-center">
						<span class="badge me-3
							<%switch(a.articleCategory()){
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
							<%switch(a.articleCategory()){
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
							<a href=
								"<%=request.getContextPath()%>
								/board/boarddetail.do?articleId=<%=a.articleId()%>
								&category=<%=category%>
								&searchData=<%=searchData%>
								&order=<%=order%>
								&numPerPage=<%=numPerPage%>
								&likes=<%=likes%>
								&cPage=<%=cPage%>" class="text-decoration-none text-black">
								<%= a.articleTitle() %>
							</a>
						</span>
					</div>
					<ul class="list-unstyled row flex-row g-1 col-lg-6">
						<li class="col-lg-2"><i class="bi-eye"><%= a.articleViews() %></i></li>
						<li class="col-lg-2"><i class="bi-hand-thumbs-up"><%= a.articleLikes() %></i></li>
						<li class="col-lg-2"><i class="bi-chat"><%= a.commentCount() %></i></li>
						<li class="col-lg-5"><%= a.userId()%> &middot; <%
							if(tFlag){
								if(h > 0){%><%=String.valueOf(h)+"시간전"%>
								<%} else if(m > 0){%> <%= String.valueOf(m)+"분전"%>
								<%} else{%><%=String.valueOf(s)+"초전"%> 
							<%}} else {%>
								<%=uldt.toLocalDate()%>
							<%
						}%> </li>
						<li class="col-lg-1">
							<%if(user != null && (user.userId().equals(a.userId()) || user.userRole().equals("ADMIN"))){%>
								<i class="bi bi-x fw-bold border rounded-2 d-flex justify-content-center align-items-center"
								   style="width: 24px; height: 24px; cursor: pointer; font-style: normal;"
								   onclick="deleteArticle('<%= a.articleId() %>', '/board/boardentrance.do?category=0')"></i>
							<%} %>
						</li>
					</ul>
					</div>
					<hr>
				<%}%>
					
				
			</div>
			<div class="row flex-row justify-content-between mt-4">
				<div class="col-8 ml-4" id="search">
					<input type="text" placeholder="게시글 검색" value="<%=searchData%>">
					<button type="button" class="btn btn-primary" onclick="searchFlag('<%=cPage%>', '/board/underarticle.do')"> 검색 </button>
				</div>
				<div class="col-2">
					<select id="likes" class="form-select form-select-sm w-auto mr-4" onchange="searchArticle('<%=cPage%>', '/board/underarticle.do')">
						<option value="0">추천수</option>
						<option value="0" <%=likes == 0? "selected" : "" %>>전체</option>
						<option value="5" <%=likes == 5? "selected" : "" %>>5개 이상</option>
						<option value="10" <%=likes == 10? "selected" : "" %>>10개 이상</option>
						<option value="50" <%=likes == 50? "selected" : "" %>>50개 이상</option>
					</select>
				</div>
			</div>
			<!-- ajax pagebar -->
			<div id="page-bar" class="col-12 text-center mt-4">
				<%= request.getAttribute("pageBar") %>
			</div>
		</div>
	</article>
	<!-- 신고 Modal -->
	<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
	            <!-- Header -->
	            <div class="modal-header">
	                <h5 class="modal-title" id="reportModalLabel">게시글/댓글 신고</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
	            </div>
				<!-- 신고 폼 시작 -->
				<form id="reportForm">
				    <div class="modal-body">
					    <div class="mb-3">
					        <label for="reportReason" class="form-label">신고 사유</label>
					        <select class="form-select" name="reason" id="reportReason" required>
						        <option value="">-- 선택하세요 --</option>
						        <option value="spam">스팸/홍보</option>
						        <option value="abuse">욕설/비방</option>
						        <option value="illegal">불법 정보</option>
						        <option value="etc">기타</option>
					        </select>
					        <input type="hidden" name="userId" id="reportUserId">
				   	    	<input type="hidden" name="targetId" id="reportTargetId">
					        <input type="hidden" name="targetType" id="reportTargetType">
					    </div>
					    <div class="mb-3">
					        <label for="reportDetails" class="form-label">상세 내용 (선택)</label>
					        <textarea class="form-control" name="details" id="reportDetails" rows="3" placeholder="상세 사유를 입력하세요"></textarea>
					    </div>
					</div>
				    <div class="modal-footer">
					    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					    <button type="button" onclick="saveReport()" class="btn btn-danger">신고하기</button>
				    </div>
				</form>
			</div>
		</div>
	</div>
	<!-- 신고 폼 끝 -->
	
</section>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="<%=request.getContextPath()%>/resources/js/board/board.js"></script>

<script>
	let $reportButton = null;
	$("#reportModal").on('show.bs.modal', (e) => {
		$reportButton = e.relatedTarget;
		$("#reportUserId").val($reportButton.getAttribute('data-user-id'));
		$("#reportTargetId").val($reportButton.getAttribute('data-target-id'));
		$("#reportTargetType").val($reportButton.getAttribute('data-target-type'));
	});
</script>

<%@include file="/WEB-INF/views/common/footer.jsp" %>