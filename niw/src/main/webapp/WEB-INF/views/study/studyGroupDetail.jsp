<%@page import="com.niw.study.model.dto.GroupMember"%>
<%@page import="java.util.List"%>
<%@page import="com.niw.study.model.dto.StudyGroup"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%
List<StudyGroup> groups = (List<StudyGroup>) request.getAttribute("groups");
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

.arrow-button {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	width: 40px;
	height: 40px;
	background-color: white;
	font-size: 20px;
	cursor: pointer;
	z-index: 10;
	border: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
	border-radius: 50%;
}

/* 왼쪽 화살표 */
.arrow-left {
	left: -50px; /* content-card 기준 */
}

/* 오른쪽 화살표 */
.arrow-right {
	right: -50px;
}

/* 반응형 대응 */
@media ( max-width : 768px) {
	.arrow-left, .arrow-right {
		display: none;
	}
}

.content-card {
	position: relative;
	width: 100%;
	max-width: 1300px;
	padding: 30px;
	margin-top: 30px;
	margin-bottom: 30px;
}

#chartSection {
	display: none;
}

.chart-container {
	width: 100%;
	height: 400px;
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

.members {
	display: flex;
	align-items: center;
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
@media ( max-width : 768px) {
	.mypage-container {
		flex-direction: column;
	}
	.sidebar {
		width: 100%;
	}
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
				<div class="user-id"></div>
				<div class="user-name"></div>
				<div class="point-info">포인트:P</div>
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
			<%
			if (loginUser == null) {
			%>
			<h5>조회된 데이터가 없습니다.</h5>
			<%
			} else {
			%>
			<div class="tabs">
				<%
				if (groups != null) {
					int index = 0;
					for (StudyGroup g : groups) {
				%>
				<div class="tab-item <%=index == 0 ? "active" : ""%>"
					data-index="<%=index%>">
					<%=g.groupName()%>
				</div>
				<%
				index++;
				}
				}
				%>

			</div>
			<!-- 상세 정보 -->
			<div class="content-card" id="detailSection">
				<!-- 화살표 버튼 -->
				<button class="arrow-button arrow-left btn btn-outline-secondary">
				<i class="bi bi-arrow-left"></i>
				</button>
				<button class="arrow-button arrow-right btn btn-outline-secondary">
				<i class="bi bi-arrow-right"></i>
				</button>
				<%
				if (groups != null) {
					int index = 0;
					for (StudyGroup g : groups) {
				%>
				<div class="group-content" id="group-<%=index%>"
					style="<%=index == 0 ? "" : "display:none;"%>">
					<div class="detail-header">
					<%if(g.status().equals("RECRUITING")) {%>
                    <span class="badge bg-primary">모집중</span>
                    <%}else if(g.status().equals("CLOSED")) { %>
                    <span class="badge bg-secondary">모집 완료</span>
                    <%}else{ %>
                    <%} %>
					<div class="title"><%=g.groupName()%></div>
					<div class="meta">
						개설자:
						<%=g.userId()%></div>
					<div class="meta">
						개설일자:
						<%=g.createDate()%></div>
					</div>
					<% 
					if(members!=null){
						int i = 0;
					for(GroupMember m : members){
						if(m.groupNumber()==g.groupNumber()){ 
							i++;
						}
					} %>
					<span>그룹인원 : <%=i%>명 / <%=g.groupLimit()%>명
					</span><br>
					<%}%>
					<%if(g.groupType().equals("PUBLIC")) {%>
					<span>공개 여부 : 공개</span><br>
					<%}else if(g.groupType().equals("PRIVATE")){ %>
					<span>공개 여부 : 비공개</span><br>
					<%} %>
					<%if(g.joinType().equals("AUTO")) {%>
					<span>가입 방식 : 자동</span><br>
					<%}else if(g.joinType().equals("MANUAL")){ %>
					<span>가입 방식 : 그룹장 승인 필요</span><br>
					<%} %>
					<div class="description"><%=g.description()%></div><br>
					<button type="button" onclick="updateGroup(<%=g.groupNumber()%>)" class="btn btn-outline-danger">
						<i class="bi bi-person-vcard"></i> 그룹 수정하기
					</button>
					<button type="button" onclick="deleteGroup(<%=g.groupNumber()%>)" class="btn btn-danger">
						<i class="bi bi-person-slash"></i> 그룹 삭제하기
					</button>
					<button type="button" onclick="updateGroupMember(<%=g.groupNumber()%>)" class="btn btn-success">
						<i class="bi bi-gear"></i> 그룹원 관리
					</button>
					<button type="button" onclick="groupChat(<%=g.groupNumber()%>)" class="btn btn-primary">
						<i class="bi bi-chat-right-text"></i> 그룹 채팅
					</button>
				</div>
				<%
				index++;
				}
				}
				%>
			</div>
			
			<!-- 차트 섹션 -->
			<div class="content-card" id="chartSection">
				<!-- 화살표 버튼 -->
				<button class="arrow-button arrow-left btn btn-outline-secondary">
				<i class="bi bi-arrow-left"></i>
				</button>
				<button class="arrow-button arrow-right btn btn-outline-secondary">
				<i class="bi bi-arrow-right"></i>
				</button>
			<div class="ranking-list">
				<h3>오늘의 공부 시간 랭킹(시간:분:초)</h3>
				<div class="ranking-item"></div>
			</div>
				<div class="chart-container">
				<h3>스터디그룹별 공부 시간</h3>
					<canvas id="studyChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>
	<script>
	document.addEventListener('DOMContentLoaded', function() {

	$('.tab-item').on('click', function() {
	    var index = $(this).data('index');

	    $('.tab-item').removeClass('active');
	    $(this).addClass('active');

	    $('.group-content').hide();
	    $('#group-' + index).show();

	    // 탭 전환 시 차트는 숨김, 상세는 보임
	    showingDetail = true;
	    document.getElementById("detailSection").style.display = "block";
	    document.getElementById("chartSection").style.display = "none";
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
let showingDetail = true;

document.querySelectorAll('.arrow-button').forEach(button => {
    button.addEventListener('click', () => {
        showingDetail = !showingDetail;

        document.getElementById("detailSection").style.display = showingDetail ? "block" : "none";
        document.getElementById("chartSection").style.display = showingDetail ? "none" : "block";

        if (!showingDetail) {
            // 현재 선택된 그룹 인덱스 가져오기
            const activeTab = $('.tab-item.active').data('index');

            // 이 인덱스를 기반으로 서버에서 차트 데이터를 동적으로 구성할 수 있음 (지금은 샘플 데이터)
            drawChart(activeTab);
        }
    });
});

function updateGroup(groupNumber){
  location.assign("<%=request.getContextPath()%>/study/updategroupview.do?no="+groupNumber);
}
function deleteGroup(groupNumber){
	console.log(groupNumber);
}
function updateGroupMember(groupNumber){
	console.log(groupNumber);
}
function groupChat(groupNumber){
	console.log(groupNumber);
}

function totalMinute(timeStr) {
    const [hours, minutes] = timeStr.split(':').map((v, i) => i < 2 ? Number(v) : null); 
    return hours * 60 + minutes;
}

let chartInstance = null;

    // 그래프
function drawChart(groupIndex) {
    if (chartInstance) {
        chartInstance.destroy(); // 기존 차트 제거
    }
	fetch("<%=request.getContextPath()%>/study/timerank.do?no="+groupIndex)
 	.then(response => response.json())
 	.then(data => {
     	const labels = data.map(item => item.userId);
	 	const totalTime = data.map(item => totalMinute(item.totalTime));
     // Chart 생성
     new Chart(document.getElementById('studyChart').getContext('2d'), {
         type: 'bar',
         data: {
             labels: labels,
             datasets: [{
                 label: '공부 시간 (분)',
                 data: totalTime,
                 backgroundColor: ['#FFD700', '#C0C0C0', '#CD7F32', '#4A90E2', '#4A90E2']
             }]
         },
         options: {
             responsive: true,
             scales: {
                 y: {
                     beginAtZero: true,
                     ticks: {
                         stepSize: 10
                     }
                 }
             }
         }
     });

     // 랭킹 표시
     const rankingList = document.querySelector('.ranking-list');

     data.forEach((item, index) => {
    	 if(index<5){
         const medals = ['🥇', '🥈', '🥉'];
         const rank = medals[index] || `\${index + 1}위`;
         const div = document.createElement('div');
         div.className = 'ranking-item';
         
         div.textContent = `\${rank} [\${item.userId}] - \${item.totalTime}`;
         rankingList.appendChild(div);
    	 }
     });
 })
 .catch(error => {
     console.error("랭킹 데이터 불러오기 실패:", error);
 });
};

        
    
</script>
</section>
<%@include file="/WEB-INF/views/common/footer.jsp"%>