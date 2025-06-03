<%@page import="com.niw.study.model.dto.GroupRequest"%>
<%@page import="com.niw.study.model.dto.GroupMember"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<%
int groupNumber = (int) request.getAttribute("groupNumber");
List<GroupRequest> groupRequests = (List<GroupRequest>) request.getAttribute("groupRequests");
List<GroupMember> members = (List<GroupMember>) request.getAttribute("members");
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

.content-card {
	position: relative;
	width: 100%;
	max-width: 1300px;
	padding: 30px;
	margin-top: 30px;
	margin-bottom: 30px;
}

.tabs {
	display: flex;
	border-bottom: 1px solid #eee;
	margin-bottom: 20px;
	overflow-x: auto;
}

.tab-item {
	padding: 15px 20px;
	cursor: pointer;
	transition: all 0.2s;
	white-space: nowrap;
}

.tab-item:hover {
	color: var(--bs-blind-dark);
}

.tab-item.active {
	font-weight: bold;
	color: var(--bs-blind-dark);
	border-bottom: 2px solid var(--bs-blind-dark);
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

/* 반응형 스타일 */
@media ( max-width : 768px) {
	.mypage-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
	}
}

    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

/* 모달 배경 */
.modal {
	display: none;
	position: fixed;
	z-index: 10;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

/* 모달 본문 */
.modal-content {
	background-color: #fff;
	margin: 10% auto;
	padding: 20px;
	border-radius: 10px;
	width: 400px;
	position: relative;
	box-shadow: 0 0 10px #333;
}

/* 닫기 버튼 */
.close {
	position: absolute;
	top: 10px;
	right: 15px;
	font-size: 24px;
	font-weight: bold;
	color: #aaa;
	cursor: pointer;
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
                <li class="menu-item " data-tab="grouplist">
                    <i class="bi bi-person-plus"></i>스터디 모집
                </li>
                <li class="menu-item active" data-tab="studygroup">
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
			<%
			if (loginUser == null) {
			%>
			<h5>조회된 데이터가 없습니다.</h5>
			<%
			} else {
			%>
			<div class="tabs">
				<div class="tab-item active" data-tab="request">그룹 신청 내역</div>
				<div class="tab-item" data-tab="member">그룹 멤버 관리</div>
			</div>
			<!-- 상세 정보 -->
			<div class="content-card">
			<div class="container mt-4" id="requestSection">
			<% int index = 0;
				for(GroupMember gm : members){ 
			if(gm.userId().equals(loginUser.userId()) && gm.role().equals("OWNER")) {
				index++;
			%>
					<h3 class="mb-4 text-center">신청자 목록</h3>
					<h6 class="mb-4 text-center">신청자를 클릭하면 해당 신청자를 그룹 멤버에 추가할 수
						있습니다.</h6>
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover align-middle text-center shadow-sm">
							<thead class="table-success">
								<tr>
									<th>그룹 번호</th>
									<th>이름</th>
									<th>주소</th>
									<th>연락처</th>
									<th>신청한 이유</th>
									<th>신청일</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<% if(groupRequests==null || groupRequests.isEmpty()){ %>
								<tr>
									<td colspan="7"><h5 class="mb-4 text-center">신청한 사용자가
											없습니다.</h5></td>
								</tr>
								<%}else{ %>
								<% for(GroupRequest gr : groupRequests){ %>
								<tr style="cursor: pointer;"
									onclick="insertGroup('<%=gr.userId()%>')">
									<td><%=gr.groupNumber() %></td>
									<td><%=gr.userName() %></td>
									<td><%=gr.userAddress() %></td>
									<td><%=gr.userPhone()%></td>
									<td><%=gr.reason() %></td>
									<td><%=gr.requestDate() %></td>
									<%if(gr.status().equals("APPROVED")) {%>
									<td>승인</td>
									<%}else if(gr.status().equals("WAIT")){ %>
									<td>대기</td>
									<%}else if(gr.status().equals("REJECT")){ %>
									<td>거절</td>
									<%}else{ %>
									<td></td>
									<%} %>
								</tr>
								<%}
        						 }%>
							</tbody>
						</table>
					</div>
				
				<%}
				}
				if(index==0){
				%>
					<h5 class="mb-4 text-center">열람할 권한이 없습니다.</h5>
				<% }
				%>
				</div>
				<div class="container mt-4" id="memberSection" style="display:none;">
					<h3 class="mb-4 text-center">그룹 멤버 목록</h3>
					<h6 class="mb-4 text-center">그룹장일 경우 멤버를 클릭하면 해당 멤버를 추방할 수 있습니다.</h6>
					<div class="table-responsive">
						<table
							class="table table-bordered table-hover align-middle text-center shadow-sm">
							<thead class="table-success">
								<tr>
									<th>아이디</th>
									<th>직책</th>
									<th>상태</th>
									<th>가입일</th>
								</tr>
							</thead>
							<tbody>
								<% if(members==null || members.isEmpty()){ %>
								<tr>
									<td colspan="4"><h5 class="mb-4 text-center">그룹 멤버가
											없습니다.</h5></td>
								</tr>
								<%}else{
								 for(GroupMember gm : members){
									 if(gm.userId().equals(loginUser.userId()) && gm.role().equals("OWNER")) {
									 %>
								<tr style="cursor: pointer;"
									onclick="groupManage('<%=gm.userId() %>')">
									<%}else { %>
									<tr>
									<%} %>
									<td><%=gm.userId() %></td>
									<%if(gm.role().equals("OWNER")) {%>
									<td>그룹장</td>
									<%}else{ %>
									<td>회원</td>
									<%} %>
									<%if(gm.status().equals("APPROVED")) {%>
									<td>승인</td>
									<%}else if(gm.status().equals("WAIT")){ %>
									<td>대기</td>
									<%} %>
									<td><%=gm.joinDate() %></td>
								</tr>
								<% } 
         						 }%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<% } %>
		</div>
	</div>
	<!-- 모달 창 -->
	<div id="groupInsertModal" class="modal">
		<div class="modal-content">
			<h4 style="text-align: center">해당 사용자를 그룹에 추가하시겠습니까?</h4>
			<br>
			<button type="button" onclick="updateGroupMember()"
				class="btn btn-success">승인</button>
			<br>
			<button type="button" onclick="rejectMember()" class="btn btn-danger">
				거절</button>
			<br>
			<button type="button" onclick="closeModal()"
				class="btn btn-outline-danger">취소</button>
		</div>
	</div>

	<!-- 모달 창 -->
	<div id="groupModal" class="modal">
		<div class="modal-content">
			<h5 style="text-align: center">멤버를 추방하면 되돌릴 수 없습니다.</h5>
			<h4 style="text-align: center">정말로 추방하시겠습니까?</h4>
			<br>
			<button type="button" onclick="deleteGroupMember()"
				class="btn btn-danger">추방</button>
			<br>
			<button type="button" onclick="closeModal()"
				class="btn btn-outline-danger">취소</button>
		</div>
	</div>
	<script>
	document.addEventListener('DOMContentLoaded', function() {
	$('.tab-item').on('click', function() {
	    var tab = $(this).data('tab');

	    $('.tab-item').removeClass('active');
	    $(this).addClass('active');

	    if (tab === 'request') {
	        $('#requestSection').show();
	        $('#memberSection').hide();
	    } else {
	        $('#requestSection').hide();
	        $('#memberSection').show();
	    }
	});

// 사이드바 메뉴 클릭 이벤트
$('.menu-item').on('click', function() {
    var $this = $(this);
    var tabId = $this.data('tab');
    console.log(tabId);
    if(tabId=="calendar"){
    	location.assign("<%=request.getContextPath()%>/study/calender.do");
    }else if(tabId=="rank"){
    	location.assign("<%=request.getContextPath()%>/study/timerecord.do");
    }else if(tabId=="studygroup"){
    	location.assign("<%=request.getContextPath()%>/study/groupdetail.do");
    }else if(tabId=="grouplist"){
    	location.assign("<%=request.getContextPath()%>/study/grouplist.do");
    }
});
	});

	 let selectedUserId = null;

	  function groupManage(userId){
		  selectedUserId = userId;
		  <% if (loginUser != null) { %>
		  const loginUser = "<%=loginUser.userId()%>";
		  <% } else { %>
		  const loginUser = null;
		  <% } %>
		  if(loginUser!=userId){
			  document.getElementById('groupModal').style.display = 'block';
		  }
	  }
	  
		function deleteGroupMember(){
			if (!selectedUserId) return;
				const groupNumber = "<%=groupNumber%>";
		    fetch("<%=request.getContextPath()%>/study/deletegroupmember.do?userId=" + selectedUserId + "&groupNumber=" + groupNumber)
			.then(response=>{
		    	if(!response.ok){
		    		throw new Error("에러가 발생하였습니다.");
		    		return;
		    	}
		    	alert("삭제가 완료되었습니다");
		        closeModal();
		        location.replace(location.href);
		    }).catch(error=>{
		    	alert(error.message);
		        closeModal();
		    });
		}
		
		function insertGroup(userId){
			selectedUserId = userId;
			document.getElementById('groupInsertModal').style.display = 'block';
		}
		
		function rejectMember(){
			if (!selectedUserId) return;
			const groupNumber = "<%=groupNumber%>";
		    fetch("<%=request.getContextPath()%>/study/rejectmember.do?userId=" + selectedUserId + "&groupNumber=" + groupNumber)
			.then(response=>{
		    	if(!response.ok){
		    		throw new Error("에러가 발생하였습니다.");
		    		return;
		    	}
		    	alert("해당 사용자를 거절 처리하였습니다");
		        closeModal();
		        location.replace(location.href);
		    }).catch(error=>{
		    	alert(error.message);
		        closeModal();
		    });
		}
		
		function updateGroupMember(){
			if (!selectedUserId) return;
			const groupNumber = "<%=groupNumber%>";
			fetch("<%=request.getContextPath()%>/study/updategroupmember.do?userId=" + selectedUserId + "&groupNumber=" + groupNumber)
		    .then(response=>{
		    	if(!response.ok){
		    		throw new Error("에러가 발생하였습니다.");
		    		return;
		    	}
		    	alert("승인이 완료되었습니다");
		        closeModal();
		        location.replace(location.href);
		    }).catch(error=>{
		    	alert(error.message);
		        closeModal();
		    });
		}

		function closeModal() {
			  document.getElementById('groupModal').style.display = 'none';
			  document.getElementById('groupInsertModal').style.display = 'none';
			}

		window.onclick = function(event) {
			  const modal = document.getElementById('groupModal');
			  const modal2 = document.getElementById('groupInsertModal');
			  if (event.target === modal || event.target === modal2) {
			    modal.style.display = 'none';
			    modal2.style.display = 'none';
			  }
			}
</script>
</section>
<%@include file="/WEB-INF/views/common/footer.jsp"%>