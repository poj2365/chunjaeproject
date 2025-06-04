<%@page import="com.niw.study.model.dto.StudyGroup, com.niw.board.model.dto.Article"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%
List<StudyGroup> studygroups = (List<StudyGroup>) request.getAttribute("studygroups");
List<Article> articles = (List<Article>) request.getAttribute("articles");
%>

<script>
	function getContextPath() {
		return "/" + window.location.pathname.split("/")[1];
	}
	
	function timeFormat(datetime) {
		const ldt = new Date(datetime);
		const now = new Date();
		if(!(ldt.toDateString() === now.toDateString())){
			return ldt.toISOString().split("T")[0];
		}
		const diffMs = now - ldt;
		const diffSec = Math.floor(diffMs / 1000);
		const diffMin = Math.floor(diffSec / 60);
		const diffHr = Math.floor(diffMin / 60);
		if (diffHr > 0) return diffHr + '시간전';
		if (diffMin > 0) return diffMin + '분전';
		return diffSec + '초전';
	}
</script>


<style>
.card-section {
	margin-bottom: 30px;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-section h3 {
	background-color: #007bff;
	color: white;
	padding: 10px 20px;
	border-top-left-radius: 8px;
	border-top-right-radius: 8px;
}

.card-section ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.card-section li {
	border-bottom: 1px solid #eee;
	padding: 15px 20px;
}
.board-header {
	padding: 20px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	position: relative;
	cursor: pointer;
}

.board-header.best {
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.board-header.resource {
	background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

#study {
	background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
	cursor: pointer;
}
.post-item {
	padding: 15px 20px;
	border-bottom: 1px solid #f0f0f0;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.post-item:last-child {
	border-bottom: none;
}

.post-item:hover {
	background: #f8f9fa;
	padding-left: 25px;
}

.post-title {
	color: #333;
	text-decoration: none;
	font-weight: 500;
	font-size: 0.95rem;
	display: block;
	margin-bottom: 5px;
}

.post-title:hover {
	color: #4ecdc4;
}
    .clickable-ul {
    cursor: pointer;
    transition: background-color 0.2s;
}
</style>
<section>

	<div class="container mt-5">
		<h2 class="mb-4 text-center">🔍 검색 결과</h2>

		<!-- 게시판 블록 컴포넌트 -->
		<div class="card mb-4 shadow-sm">
		<div class="board-header best">
				<h5 class="mb-0">자유 게시판</h5>
			</div>
			<div class="card-body">
				<%if(articles != null && !articles.isEmpty()) {
					for(Article article : articles) {%>
					<ul class="post-item clickable-ul row flex-row"
						onclick="boardDetail('<%=article.articleId()%>')">
					<li class="post-title overflow-hidden col-lg-6 d-flex align-items-center">
						<%if(article.articleCategory() == 1) {%>
							<span class="badge bg-secondary me-2"> 일반 </span>
						<%} else if(article.articleCategory() == 2) {%>
							<span class="badge bg-primary me-2"> 질문 </span>
						<%}%>
						<%= article.articleTitle() %>
					</li>
					<li class="post-title col-lg-2"><%= article.userId()%></li>
					<li class="post-title col-lg-2">
						<script>
						    document.write(timeFormat('<%= article.articleDateTime().toInstant().toString() %>'));
						</script>
					</li>
				</ul>
				<%}} else { %>
					<p class="text-muted">검색 결과가 없습니다.</p>
				<%} %>
			</div>
		<div class="board-header resource">
				<h5 class="mb-0">자료 게시판</h5>
			</div>
			<div class="card-body">
				<p class="text-muted">검색 결과가 없습니다.</p>
			</div>
		
			<div class="board-header" id="study">
				<h5 class="mb-0">스터디 게시판</h5>
			</div>
			<div class="card-body">
				<%
				if (studygroups == null || studygroups.isEmpty()) {
				%>
				<p class="text-muted">검색 결과가 없습니다.</p>
				<%
				} else if (studygroups != null && !studygroups.isEmpty()) {
				for (StudyGroup g : studygroups) {
				%>
				<ul class="post-item clickable-ul"
					onclick="goToGroup(<%=g.groupNumber()%>)">
					<li class="post-title">
						<%
						String status = g.status();
						if ("RECRUITING".equals(status)) {
						%> <span
						class="badge bg-primary">모집중</span> <%
 						} else if ("CLOSED".equals(status)) {
 						%>
						<span class="badge bg-secondary">모집 완료</span> 
						<%
 						}
 						%> <%=g.groupName()%>
					</li>
					<li class="post-title"><%=g.userId()%></li>
					<li class="post-title"><%=g.createDate()%></li>
				</ul>
				<%
				}
				}
				%>
			</div>
		</div>
	</div>

</section>
<%@include file="/WEB-INF/views/common/footer.jsp"%>
<script>
function goToGroup(groupNumber) {
    location.assign('<%=request.getContextPath()%>/study/groupview.do?no=' + groupNumber);
}

document.getElementById('study').addEventListener('click', () => {
	location.assign('<%=request.getContextPath()%>/study/grouplist.do');
});

function boardDetail(articleId) {
	location.assign(getContextPath() + '/board/boarddetail.do?articleId=' + articleId);
}

</script>