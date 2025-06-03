<%@page import="com.niw.study.model.dto.StudyGroup"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    List<StudyGroup> studygroups = (List<StudyGroup>)request.getAttribute("studygroups");
    %>
    <style>
    .clickable-ul {
    cursor: pointer;
    transition: background-color 0.2s;
}
    </style>
 <!-- 게시글 리스트 -->
        <% if (studygroups != null && !studygroups.isEmpty()) {
            for (StudyGroup g : studygroups) { %>
                <ul class="post-item clickable-ul"
            onclick="goToGroup(<%=g.groupNumber()%>)">
                    <li class="post-title">
                   		<% String status = g.status(); 
  					 	if ("RECRUITING".equals(status)) { %>
  					 	<span class="badge bg-primary">모집중</span>
						<% } else if ("CLOSED".equals(status)) { %>
  						 <span class="badge bg-secondary">모집 완료</span>
						<% } %>
                            <%=g.groupName()%>
                    </li>
                    <li class="post-title"><%=g.userId()%></li>
                    <li class="post-title"><%=g.createDate()%></li>
                </ul>
        <%  }
           } else { %>
            <ul class="board-row no-data">
                <li>등록된 스터디 그룹이 없습니다.</li>
            </ul>
        <% } %>
<script>
function goToGroup(groupNumber) {
    location.href = '<%=request.getContextPath()%>/study/groupview.do?no=' + groupNumber;
}
</script>