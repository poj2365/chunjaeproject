<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.niw.board.model.dto.Article, 
				com.niw.board.model.dto.Comment, 
				java.util.List,
				java.time.LocalDateTime,
				java.time.Duration"%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/board.css">
<script src="<%=request.getContextPath()%>/resources/js/board/board.js"></script>

<% 
	Article article = (Article) request.getAttribute("article"); 
	List<Comment> comments = (List<Comment>) request.getAttribute("comments");
%>
<section class="row justify-content-between mt-4">
	<aside class="card col-lg-2 ms-3 me-3">
		<div class="card-header">
			<h5 class="section-title">
				카테고리
			</h5><br>
			<ul id="category" class="list-group list-group-flush">
				<li class="list-group-item">
					<a href="<%=request.getContextPath() %>/board/boardentrance.do?category=0">전체글</a>
				</li>
				<li class="list-group-item">
					<a href="<%=request.getContextPath() %>/board/boardentrance.do?category=1">일반글</a>
				</li>
				<li class="list-group-item">
					<a href="<%=request.getContextPath() %>/board/boardentrance.do?category=2">질문글</a>
				</li>
			</ul>
		</div>			
	</aside>
	<article class="col-lg-9 ms-3 me-3">
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
					<div class="col-lg-3">
						<i class="bi-eye">
							<span class="d-inline-block">
								<%= article.articleViews() %>
							</span>
						</i>
					</div>
					<div class="col-lg-3">
						<i class="bi-chat">
							<span class="d-inline-block">
								<%= article.commentCount() %>
							</span>
						</i>
					</div>
				</div>
				<div class="col-lg-2 justify-content-end text-end">
					<button class="btn btn-danger"> 신고 </button>
					<button class="btn btn-primary"> 북마크 </button>	
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
				<span class="col-lg-1 border p-3 rounded text-center me-3" onclick="alert('1')">
					<i class="bi-hand-thumbs-up cursor-pointer">
						<%= article.articleLikes() %>
					</i>
				</span>
				<span class="col-lg-1  border p-3 rounded text-center" onclick="alert('2')">
					<i class="bi-hand-thumbs-down cursor-pointer">
						<%= article.articleDislikes() %>
					</i>
				</span>
			</div>	
		</div>
		<hr>
		<div class="comment-header">
            <div class="row flex-row justify-content-between align-items-center">
                <div class="col-lg-3">
                    <h5> 댓글 <%= article.commentCount() %></h5>                
                </div>
                <div class="col-lg-1 text-end">
                    <button class="btn btn-primary" onclick="writeComment(event, 0)"> 댓글 </button>
                </div>
            </div>
            <hr>
        </div>
        <% for(Comment comment : comments) { 
        	if(comment.commentLevel() == 0) {%>
				<div class="comment level-0">
					<div>
		                <span><%= comment.userId() %></span>
		            </div>
		            <div class="text-break">
		            	<%= comment.commentContent()%>
		            </div>
		            <div class="d-flex justify-content-between align-items-center">
		                <div style="color: gray;">
		                    <span class="col-lg-2 me-3">
		                    	<%= comment.commentDateTime() %>
		                    </span>
		                    <span class="col-lg-1  me-3" onclick="">
		                    	<i class="bi-hand-thumbs-up cursor-pointer">
									<%= comment.commentLikes() %>
								</i> 
		                    </span>
		                    <span class="col-lg-1 " onclick=""> 
		                    	<i class="bi-hand-thumbs-down cursor-pointer">
									<%= comment.commentDislikes() %>
								</i>
		                    </span>
		                </div>
		                <div class="d-flex justify-content-between align-items-center">
	                        <form action="" method="get">
		                        <button type="button" class="btn btn-danger me-1" data-bs-toggle="modal" data-bs-target="#reportModal">
		                            신고
		                        </button>
		                	</form>
		                    <button class="btn btn-primary" onclick="writeComment(event, 1)"> 댓글 </button>
		                </div>
		            </div>
		            <hr>
				</div>
			<% } else { %>
				<div class="comment level-1">
					<div>
		                <span><%= comment.userId() %></span>
		            </div>
		            <div class="text-break">
		            	<%= comment.commentContent()%>
		            </div>
		            <div class="d-flex justify-content-between align-items-center">
		                <div style="color: gray;">
		                    <span class="col-lg-2 me-3">
		                    	<%= comment.commentDateTime() %>
		                    </span>
		                    <span class="col-1  me-3" onclick="">
		                    	<i class="bi-hand-thumbs-up cursor-pointer">
									<%= comment.commentLikes() %>
								</i> 
		                    </span>
		                    <span class="col-1 " onclick=""> 
		                    	<i class="bi-hand-thumbs-down cursor-pointer">
									<%= comment.commentDislikes() %>
								</i>
		                    </span>
		                </div>
		                <div class="d-flex justify-content-between align-items-center">
	                        <form action="" method="get">
		                        <button type="button" class="btn btn-danger me-1" data-bs-toggle="modal" data-bs-target="#reportModal">
		                            신고
		                        </button>
		                	</form>
		                    <button class="btn btn-primary" onclick="writeComment(event, 1)"> 댓글 </button>
		                </div>
		            </div>
		            <hr>
				</div>
			<% } %>
		<%} %>
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
				<!-- 여기 신고 삽입 서블릿 추가 필요 -->
				<form method="get" action="">
				    <div class="modal-body">
						<!-- session userId  필요  -->
					    <input type="hidden" name="" value=""> 
					    <div class="mb-3">
					        <label for="reportReason" class="form-label">신고 사유</label>
					        <select class="form-select" name="reason" id="reportReason" required>
						        <option value="">-- 선택하세요 --</option>
						        <option value="spam">스팸/홍보</option>
						        <option value="abuse">욕설/비방</option>
						        <option value="illegal">불법 정보</option>
						        <option value="etc">기타</option>
					        </select>
					    </div>
					    <div class="mb-3">
					        <label for="reportDetails" class="form-label">상세 내용 (선택)</label>
					        <textarea class="form-control" name="details" id="reportDetails" rows="3" placeholder="상세 사유를 입력하세요"></textarea>
					    </div>
					</div>
				    <div class="modal-footer">
					    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					    <button type="submit" class="btn btn-danger">신고하기</button>
				    </div>
				</form>
			</div>
		</div>
	</div>
	<!-- 신고 폼 끝 -->
	
</section>

<%@include file="/WEB-INF/views/common/footer.jsp" %>