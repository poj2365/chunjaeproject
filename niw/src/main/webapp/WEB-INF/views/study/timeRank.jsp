<%@page import="com.niw.study.model.dto.TimeRecord"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%
List<TimeRecord> trList = (List<TimeRecord>) request.getAttribute("trList");
%>
<style>
/*  */
.chart-container {
	max-width: 700px;
	margin: 0 auto 30px;
	background: white;
	padding: 20px;
}

.ranking-list {
	max-width: 700px;
	margin: 0 auto;
	background: white;
	padding: 20px;
	margin-bottom: 20px
}

}
.ranking-item {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	
}

.ranking-item:last-child {
	border-bottom: none;
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
                <li class="menu-item " data-tab="grouplist">
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
                <li class="menu-item active" data-tab="rank">
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
				<h2 class="content-title">랭킹</h2>
			</div>
			<div class="ranking-list">
				<h3>오늘의 공부 시간 랭킹(시간:분:초)</h3>
				<div class="ranking-item"></div>
			</div>
			<div class="chart-container">
				<h3>오늘의 공부 시간 랭킹 그래프</h3>
				<canvas id="studyChart"></canvas>
			</div>

			
		</div>
	</div>
</section>
<script>
	document.addEventListener('DOMContentLoaded', function() {
        
        function totalMinute(timeStr) {
            const [hours, minutes] = timeStr.split(':').map((v, i) => i < 2 ? Number(v) : null); 
            return hours * 60 + minutes;
        }
		
            // 그래프
    	fetch("<%=request.getContextPath()%>/study/timerank.do")
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
            
    	    // 사이드바 메뉴 클릭 이벤트
    	    $('.menu-item').on('click', function() {
    	        var $this = $(this);
    	        var tabId = $this.data('tab');
    	        if(tabId=="calendar"){
    	        	location.assign("<%=request.getContextPath() %>/study/calender.do");
    	        }else if(tabId=="record"){
    	        	location.assign("<%=request.getContextPath() %>/study/timerecord.do");
    	        }else if(tabId=="rank"){
    	        	location.assign("<%=request.getContextPath() %>/study/timerank.do");
    	        }else if(tabId=="studygroup"){
    	        	location.assign("<%=request.getContextPath() %>/study/groupdetail.do");
    	        }else if(tabId=="grouplist"){
    	        	location.assign("<%=request.getContextPath() %>/study/grouplist.do");
    	        }
    	    });
        });
    </script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>