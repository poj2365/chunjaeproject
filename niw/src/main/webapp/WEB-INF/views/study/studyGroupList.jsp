<%@page import="com.niw.study.model.dto.StudyGroup"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="/WEB-INF/views/common/header.jsp" %>
   <%
   List<StudyGroup> studygroups = (List<StudyGroup>)request.getAttribute("studygroups");
   int groupLimit = (int)request.getAttribute("groupLimit");
   %>
   <style>
.board-wrapper {
    width: 100%;
    border-top: 2px solid #444;
}
.board-header, .board-row {
    display: flex;
    list-style: none;
    padding: 8px 12px;
    border-bottom: 1px solid #ccc;
}
.board-header {
    font-weight: bold;
    background: #f0f0f0;
}
.board-row a {
    text-decoration: none;
    color: #007acc;
}
.col-no { width: 10%; text-align: center; }
.col-title { width: 60%; }
.col-writer { width: 15%; text-align: center; }
.col-date { width: 15%; text-align: center; }
.col-type { width: 15%; text-align: center; }
.col-join { width: 15%; text-align: center; }
.no-data li {
    width: 100%;
    text-align: center;
    color: gray;
}

.search-div {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 8px;
}
.search-select,
.search-input,
.search-btn {
  padding: 10px;
  font-size: 16px;
  border-radius: 6px;
  border: 1px solid #ccc;
}
.search-select {
  min-width: 130px;
}
.search-input {
  flex: 1 1 200px;
  min-width: 200px;
}

@media (max-width: 600px) {
  .search-div {
    flex-direction: column;
    align-items: stretch;
  }
}

    /* 마이페이지 전용 스타일 */
    .mypage-container {
        max-width: 1400px; /* 1200px → 1400px로 증가 */
        margin: 30px auto;
        display: flex;
        gap: 30px; /* 20px → 30px로 증가 */
        flex: 1;
        padding: 0 20px; /* 15px → 20px로 증가 */
    }
    
    /* 사이드바 스타일 */
    .sidebar {
        width: 260px; /* 240px → 220px로 축소 */
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px 0;
        flex-shrink: 0; /* 사이드바 크기 고정 */
    }
    
    .profile-section {
        padding: 0 20px 20px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }
    
    .profile-pic {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: #f0f0f0;
        margin: 0 auto 15px;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 3px solid var(--bs-primary-light);
    }
    
    .profile-pic img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .user-id {
        font-weight: bold;
        margin-bottom: 5px;
        font-size: 18px;
        color: #333;
    }
    
    .user-name {
        color: #666;
        margin-bottom: 10px;
    }
    
    .point-info {
        font-size: 16px;
        color: var(--bs-blind-dark);
        margin-top: 10px;
        font-weight: bold;
    }
    
    .menu-section {
        padding: 20px 0;
    }
    
    .menu-title {
        padding: 0 20px;
        margin-bottom: 10px;
        font-size: 14px;
        color: #888;
        font-weight: bold;
    }
    
    .menu-item {
        padding: 12px 20px;
        transition: all 0.2s;
        display: flex;
        align-items: center;
        cursor: pointer;
    }
    
    .menu-item i {
        margin-right: 10px;
        font-size: 18px;
    }
    
    .menu-item:hover {
        background-color: var(--bs-primary-light);
        color: var(--bs-blind-dark);
    }
    
    .menu-item.active {
        background-color: var(--bs-primary-light);
        color: var(--bs-blind-dark);
        border-left: 3px solid var(--bs-blind-dark);
        font-weight: bold;
    }
    
    /* 메인 컨텐츠 스타일 */
    .main-content {
        flex: 1;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 30px;
        min-height: 450px;
    }
    
    .loading-content {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 400px;
        flex-direction: column;
        color: #888;
    }
    
    .loading-spinner {
        border: 4px solid #f3f3f3;
        border-top: 4px solid var(--bs-blind-dark);
        border-radius: 50%;
        width: 40px;
        height: 40px;
        animation: spin 1s linear infinite;
        margin-bottom: 20px;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .mypage-container {
            flex-direction: column;
        }
        
        .sidebar {
            width: 100%;
        }
    }
    
        .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    
    .content-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
    }
</style>
<section>
<!-- 메인 컨테이너 -->
<div class="mypage-container">
    <!-- 사이드바 영역 -->
    <div class="sidebar">
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
           <%  }%>

        </div>
        <div class="menu-section">
            <div class="menu-title">스터디 그룹</div>
            <ul>
                <li class="menu-item active" data-tab="grouplist">
                    <i class="bi bi-person-plus"></i>스터디 모집
                </li>
                <li class="menu-item" data-tab="studygroup">
                    <i class="bi bi-people"></i>내 스터디 그룹
                </li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">공부</div>
            <ul>
            	<li class="menu-item" data-tab="record">
                    <i class="bi bi-clock"></i>공부 시간 기록
                </li>
                <li class="menu-item" data-tab="rank">
                    <i class="bi bi-trophy"></i>랭킹
                </li>
                <li class="menu-item" data-tab="calendar">
                    <i class="bi bi-calendar-check"></i>스터디 플래너
                </li>
            </ul>
        </div>
    </div>
 
    <!-- 메인 컨텐츠 영역 -->
    <div class="main-content">
		<div class="content-header">
    <h2 class="content-title">스터디 게시판</h2>
</div>
	<div class="search-div">
    <select name="searchType" class="search-select">
      <option value="groupName">제목</option>
      <option value="groupNumber">번호</option>
    </select>
    <input type="text" name="keyword" placeholder="검색어를 입력하세요" class="search-input " required />
    <button id="searchBtn" class="search-btn btn btn-secondary">검색</button>
    </div>
  <br>
    <div class="board-wrapper">
        <!-- 게시판 헤더 -->
        <ul class="board-header">
            <li class="col-no">번호</li>
            <li class="col-title">제목</li>
            <li class="col-writer">작성자</li>
            <li class="col-date">작성일</li>
           	<!-- <li class="col-type">공개 여부</li> -->
            <!-- <li class="col-join">가입 방식</li> -->
        </ul>

        <!-- 게시글 리스트 -->
        <% if (studygroups != null && !studygroups.isEmpty()) {
            for (StudyGroup g : studygroups) { %>
                <ul class="board-row">
                    <li class="col-no"><%=g.groupNumber()%></li>
                    <li class="col-title">
                   		<% String status = g.status(); 
  					 	if ("RECRUITING".equals(status)) { %>
  					 	<span class="badge bg-primary">모집중</span>
						<% } else if ("CLOSED".equals(status)) { %>
  						 <span class="badge bg-secondary">모집 완료</span>
						<% } %>
                        <a href="<%=request.getContextPath()%>/study/groupview.do?no=<%=g.groupNumber()%>">
                            <%=g.groupName()%>
                        </a>
                    </li>
                    <li class="col-writer"><%=g.userId()%></li>
                    <li class="col-date"><%=g.createDate()%></li>
                    <%-- <li class="col-type"><%=g.groupType()%></li> --%>
                    <%-- <li class="col-join"><%=g.joinType()%></li> --%>
                </ul>
        <%  }
           } else { %>
            <ul class="board-row no-data">
                <li>등록된 스터디 그룹이 없습니다.</li>
            </ul>
        <% } %>
    </div>
    <% if(loginUser!=null && groupLimit<=3){ %>
    <button class="btn btn-secondary" onclick="location.assign('<%=request.getContextPath() %>/study/groupcreateview.do');">그룹 생성</button>
   	<%} %>
   		<div id="pagebar">
			<%=request.getAttribute("pageBar") %>
		</div>
		   </div>
		</div>
   </section>
   <script>
   document.addEventListener('DOMContentLoaded', () => {
	    // 사이드바 메뉴 클릭 이벤트
	    $('.menu-item').on('click', function() {
	        var $this = $(this);
	        var tabId = $this.data('tab');
	        if(tabId=="calendar"){
	        	location.assign("<%=request.getContextPath() %>/study/calender.do");
	        }else if(tabId=="record"){
	        	location.assign("<%=request.getContextPath() %>/study/timerecord.do");
	        }else if(tabId=="rank"){
	        	location.assign("<%=request.getContextPath() %>/study/timeranking.do");
	        }else if(tabId=="studygroup"){
	        	location.assign("<%=request.getContextPath() %>/study/groupdetail.do");
	        }else if(tabId=="grouplist"){
	        	location.assign("<%=request.getContextPath() %>/study/grouplist.do");
	        }
	    });
   });
   
   document.getElementById('searchBtn').addEventListener('click', () => {
	   const type = document.querySelector('select[name="searchType"]').value;
	   const keyword = document.querySelector('input[name="keyword"]').value;

	   fetch(`<%=request.getContextPath()%>/study/grouplist.do?searchType=\${type}&keyword=\${encodeURIComponent(keyword)}`)
	     .then(res => res.text())
	     .then(html => {
	       const parser = new DOMParser();
	       const doc = parser.parseFromString(html, 'text/html');
	       const newContent = doc.querySelector('.board-wrapper').innerHTML;
	       const newPagebar = doc.querySelector('#pagebar').innerHTML;
	    	console.log(newContent);
	       document.querySelector('.board-wrapper').innerHTML = newContent;
	       document.querySelector('#pagebar').innerHTML = newPagebar;
	     });
	 });
   </script>
   <%@include file="/WEB-INF/views/common/footer.jsp" %>