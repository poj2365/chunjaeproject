<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<style>
.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
	color: #444;
}

.form-input {
	width: 100%;
	padding: 15px 18px; /* 12px 15px → 15px 18px로 증가 */
	border: 1px solid #ddd;
	border-radius: 8px;
	font-size: 16px;
	transition: all 0.2s;
	min-height: 50px; /* 최소 높이 지정 */
	box-sizing: border-box;
}

.form-input:focus {
	border-color: var(--bs-blind-dark);
	box-shadow: 0 0 0 3px rgba(36, 177, 181, 0.2);
	outline: none;
}

.form-input::placeholder {
	color: #ccc;
}

.form-input:disabled {
	background-color: #f5f6f7;
	cursor: not-allowed;
}

.content-section {
	margin-bottom: 30px;
}

.section-title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 15px;
	color: #444;
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

@
keyframes spin { 0% {
	transform: rotate(0deg);
}

100
%
{
transform
:
rotate(
360deg
);
}
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
					<i class="bi bi-person-circle"
						style="font-size: 60px; color: #ccc;"></i>
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
					<li class="menu-item " data-tab="grouplist"><i
						class="bi bi-person-plus"></i>스터디 모집</li>
					<li class="menu-item active" data-tab="studygroup"><i
						class="bi bi-people"></i>내 스터디 그룹</li>
				</ul>
			</div>
			<div class="menu-section">
				<div class="menu-title">타이머</div>
				<ul>
					<li class="menu-item" data-tab="rank"><i class="bi bi-trophy"></i>랭킹
					</li>
					<li class="menu-item" data-tab="calendar"><i
						class="bi bi-calendar-check"></i>스터디 플래너</li>
				</ul>
			</div>
		</div>

		<!-- 메인 컨텐츠 영역 -->
		<div class="main-content">
			<div class="content-header">
				<h2 class="content-title">스터디 게시판</h2>
			</div>
			<div class="content-section">
				<h3 class="section-title">스터디 그룹 생성</h3>
				<p class="form-label">스터디 그룹은 총 3개까지 생성 가능합니다</p> 
				<div class="form-group">
					<label class="form-label">그룹 이름</label> 
					<input type="text" class="form-input" name="groupName" id="groupName"
						placeholder="그룹 이름은 모집글의 제목으로 자동 등록됩니다." required />
				</div>
				<div class="div-group">
					<label class="form-label">그룹 종류</label> <select name="groupType"
						class="form-input">
						<option value="PUBLIC">공개</option>
						<option value="PRIVATE">비공개</option>
					</select>
				</div>
				<br>

				<div class="form-group">
					<label class="form-label">가입 방식</label> <select name="joinType"
						class="form-input">
						<option value="AUTO">자동 가입</option>
						<option value="MANUAL">수동 가입(그룹장 승인 필요)</option>
					</select>
				</div>

				<div class="form-group">
					<label class="form-label">그룹 인원</label> <select name="groupLimit"
						class="form-input" id="groupLimit">
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
						<option value="9">9</option>
					</select>
				</div>

				<div class="form-group">
					<label class="form-label">그룹 소개글</label>
					<textarea name="description" id="description" rows="8" class="form-input" required>

시작: ex)매주 토요일 오후 5시
종료: ex)매주 토요일 오후 7시
장소: ex)가산디지털단지역 근처 카페
</textarea>
				</div>
				<div style="text-align: right;">
					<button id="createBtn" class="btn btn-primary">
						<i class="bi bi-person-plus"></i>그룹 생성하기
					</button>
				</div>
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
	
	document.getElementById('createBtn').addEventListener('click', () => {
		<%if(loginUser==null){%>
			alert("로그인 후 이용 가능한 메뉴입니다.");
			location.replace("<%=request.getContextPath()%>");
		<%}else{ %>
		const userId = '<%=loginUser.userId()%>';
		const groupName = document.getElementById('groupName').value;
		const groupType = document.querySelector('select[name="groupType"]').value;
		const joinType = document.querySelector('select[name="joinType"]').value;
		const description = document.getElementById('description').value;
		const groupLimit = document.getElementById('groupLimit').value;
		const jsonData = {
			    groupName: groupName,
			    userId: userId,
			    groupType: groupType,
			    joinType: joinType,
			    description: description,
			    groupLimit: groupLimit
			}
		
	fetch("<%=request.getContextPath()%>/study/groupcreate.do",{
		method: 'POST',
      headers: {
          'Content-Type': 'application/json'
      },
      body: JSON.stringify(jsonData)
  }).then(response => {
    if (response.ok) {
        console.log("그룹이 정상적으로 생성되었습니다.");
        return response.json();
    }else{
    throw new Error('네트워크 응답이 올바르지 않습니다.');
    }
  }).then(data=>{
	  
		const jsonMemberData = {
			    groupNumber: data.groupNumber,
			    userId: userId,
			    role: "OWNER",
			    status: "APPROVED"
			}
		
	   return fetch("<%=request.getContextPath()%>/study/groupmembercreate.do",{
			method: 'POST',
	      headers: {
	          'Content-Type': 'application/json'
	      },
	      body: JSON.stringify(jsonMemberData)
	  }).then(response => {
	    if (response.ok) {
	        alert("정상적으로 생성되었습니다.");
	    }else{
	    throw new Error('네트워크 응답이 올바르지 않습니다.');
	    }
	     location.replace("<%=request.getContextPath() %>/study/grouplist.do");
	  }).catch(error => {
	      alert("에러 발생: " + error.message);
	  });
  });
	

	
	});
});
<%} %>
</script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>