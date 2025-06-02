<%@page import="com.niw.study.model.dto.GroupMember"%>
<%@page import="java.util.List"%>
<%@page import="com.niw.study.model.dto.StudyGroup"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="/WEB-INF/views/common/header.jsp" %>
   <%
   	StudyGroup group = (StudyGroup)request.getAttribute("group");
   List<GroupMember> members = (List<GroupMember>)request.getAttribute("members");
   int groupCnt = (int)request.getAttribute("groupCnt");
   int groupLimit = (int)request.getAttribute("groupLimit");
	%>
   <style>
    .detail-header {
      border-bottom: 1px solid #ddd;
      padding-bottom: 10px;
      margin-bottom: 20px;
    }

    .title {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .meta {
      color: gray;
      font-size: 14px;
    }


    .organizer {
      display: flex;
      align-items: center;
      margin: 20px 0;
    }

    .organizer img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      margin-right: 10px;
    }

    .members {
      display: flex;
      align-items: center;
      margin-top:10px;
      margin-bottom: 10px;
    }

    .members span {
      font-size: 16px;
      color: green;
      margin-right: 10px;
    }

    .avatars {
      display: flex;
      gap: 10px;
    }

    .avatar {
      width: 40px;
      height: 40px;
      background-color: #eee;
      border-radius: 50%;
      display: inline-block;
      line-height: 40px;
      text-align: center;
      color: #aaa;
      overflow: hidden;
    }

    .info {
      margin: 20px 0;
    }

    .info-item {
      margin-bottom: 10px;
      font-size: 14px;
    }

    .info-item span {
      font-weight: bold;
      margin-right: 8px;
    }

    .description {
      font-size: 14px;
      line-height: 1.6;
      white-space: pre-wrap;
    }

    .apply-button {
      margin-top: 30px;
      text-align: center;
    }

    .apply-button button {
      background-color: #76c043;
      border: none;
      padding: 12px 30px;
      font-size: 16px;
      color: white;
      border-radius: 25px;
      cursor: pointer;
    }

    .apply-button button:hover {
      background-color: #65a83c;
    }

   /* modal */
  .modal {
    display: none;
    position: fixed;
    z-index: 999;
    padding-top: 40px;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.5);
  }

  .modal-content {
    background-color: #fff;
    margin: auto;
    padding: 30px;
    border-radius: 10px;
    width: 90%;
    max-width: 500px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  }

  .close {
    float: right;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
  }

  form input, form textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    box-sizing: border-box;
    border-radius: 5px;
    border: 1px solid #ccc;
  }

  form button[type="submit"] {
    background-color: #76c043;
    border: none;
    color: white;
    padding: 12px 20px;
    margin-top: 10px;
    border-radius: 25px;
    cursor: pointer;
  }

  form button[type="submit"]:hover {
    background-color: #5ea137;
  }
  /* modal end */
   
   
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
    <div class="detail-container">
    <div class="detail-header">
    <%if(group.status().equals("RECRUITING")) {%>
      <span class="badge bg-primary">모집중</span>
      <%}else if(group.status().equals("CLOSED")) { %>
      <span class="badge bg-secondary">모집 완료</span>
      <%}else{ %>
      <%} %>
      <div class="title"><%=group.groupName() %></div>
      <div class="meta">번호 : <%=group.groupNumber() %> </div>
      <div class="meta">작성자 : <%=group.userId() %></div>
      <div class="meta">개설일자 : <%=group.createDate() %></div>
            <%if(group.joinType().equals("AUTO")) {%>
		<div class="meta">가입 방식 : 자동</div>
	<%}else if(group.joinType().equals("MANUAL")){ %>
		<div class="meta">가입 방식 : 그룹장 승인 필요</div>
		<%} %>
    </div>
	<span><strong>그룹 멤버</strong></span>
	<br>
    <div class="members">
      <div class="avatars">
      	<%for(int i=0;i<group.groupLimit();i++){
      		if(i==0){ %>
      		<div class="avatar"><%=group.userId() %></div>
      <% }else{ %> 
    	 	<div class="avatar">user</div>
      <% }
      		}%>
        <span>그룹인원 : <%=groupCnt %>명  / <%=group.groupLimit()%>명</span>
      </div>
    </div><br>
    <div class="description">
		<%=group.description() %>
    </div>
<% if (group.status().equals("RECRUITING") && loginUser != null) {
     boolean isAlreadyMember = false;
         for (GroupMember m : members) {
             if (m.userId().equals(loginUser.userId())) {
                 isAlreadyMember = true;
                 break;
             }
         }
     if(group.userId().equals(loginUser.userId())){
    	 isAlreadyMember = true;
     }
     if (!isAlreadyMember) { %>
    <div class="apply-button">
        <button onclick="openModal()">참여하기</button>
    </div>
<%   }
}
%>
</div>
  </div>
	<%if(loginUser!=null ) {%>
  <div id="applyModal" class="modal">
  <div class="modal-content">
    <span class="close" onclick="closeModal()">&times;</span>
    <h2>스터디 신청</h2>
    <form id="applyForm">
      <label>이름 <input type="text" name="name" value="<%=loginUser.userName() %>" disabled/></label><br><br>
      <label>거주지<input type="text" name="location" placeholder="예: 가산동동" value="<%=loginUser.userAddress()%>" disabled/></label><br><br>
      <label>연락처<input type="text" name="contact" value="<%=loginUser.userPhone() %>" disabled/></label><br><br>
      <label>신청하는 이유<textarea name="reason" id="reason" rows="4" required></textarea></label><br><br>
      <button type="submit">신청하기</button>
    </form>
  </div>
</div>
<%} %>
    </div>
   </section>
   

<script>
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

  function openModal() {
	  const groupLimit = <%=groupLimit%>;
	  <% if(groupLimit >=3 ){%>
	  		alert("그룹은 3개 이상 참여할 수 없습니다.");
	  		return;
	  <%} %>
    document.getElementById("applyModal").style.display = "block";
	
  }

  function closeModal() {
    document.getElementById("applyModal").style.display = "none";
  }

  // ESC 키로도 닫히게
  window.addEventListener("keydown", function (e) {
    if (e.key === "Escape") closeModal();
  });

  document.getElementById("applyForm").addEventListener("submit", function (e) {
    e.preventDefault();
    const reason = document.getElementById('reason').value;
    <%if(loginUser!=null){ %>
    	const userId = "<%=loginUser.userId() %>";
    	const userName = "<%=loginUser.userName() %>";
    	const userAddress = "<%=loginUser.userAddress()%>";
    	const userPhone = "<%=loginUser.userPhone() %>";
    	const groupNumber = "<%=group.groupNumber() %>";
    	const joinType = "<%=group.joinType()%>";
    	let status = "";
    	const role = "MEMBER";
    	if(joinType=="AUTO"){
    		status = "APPROVED";
    	}else if(joinType=="MANUAL"){
    		status = "WAIT";
    	}
    <%} %>
	const jsonData = {
			userId,
			userName,
			userAddress,
			userPhone,
			reason,
			groupNumber,
			status,
			role
	}    
    fetch("<%=request.getContextPath()%>/study/insertgrouprequest.do",{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(jsonData)
    })
    .then(response=>{
    	if(!response.ok){
    		throw new Error(error);
    		return;
    	}
    	alert("신청이 완료되었습니다!");
        closeModal();
        location.replace("<%=request.getContextPath()%>/study/grouplist.do");
    }).catch(error=>{
    	alert("이미 신청한 스터디 그룹입니다.");
        closeModal();
    });
  });
</script>
   <%@include file="/WEB-INF/views/common/footer.jsp" %>