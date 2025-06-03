<%@page import="com.niw.study.model.dto.StudyGroup"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%
List<StudyGroup> studygroups = (List<StudyGroup>) request.getAttribute("studygroups");
%>
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

				<p class="text-muted">검색 결과가 없습니다.</p>

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
</script>