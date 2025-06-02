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

.timer-container {
	max-width: 700px;
	min-width: 300px;
	margin: 0 auto 30px;
	margin-top: 20px;
	background: white;
	padding: 20px;
	text-align: center;
	background-color: white;
	width: 100%;
}

.timer-display {
	font-size: 3rem;
	margin: 1rem 0;
	font-weight: bold;
}

.buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 1.5rem;
}

.timer-btn {
	flex: 1;
	margin: 0 0.5rem;
	padding: 0.75rem 0;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 1rem;
	font-weight: bold;
	transition: background-color 0.3s;
}

.start-btn {
	background-color: #4CAF50;
	color: white;
}

.pause-btn {
	background-color: #FF9800;
	color: white;
}

.stop-btn {
	background-color: #F44336;
	color: white;
}

.timer-btn:hover {
	opacity: 0.9;
}

.timer-btn:disabled {
	background-color: #cccccc;
	cursor: not-allowed;
}

.status {
	margin-top: 1rem;
	color: #555;
	font-size: 0.9rem;
	height: 20px;
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
            	<li class="menu-item active" data-tab="record">
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
    <h2 class="content-title">공부 시간 기록</h2>
</div>
		<div class="timer-container">
			<h2>타이머</h2>
			<div class="timer-display" id="timer">00:00:00</div>
			<div class="buttons">
				<button class="timer-btn start-btn" id="startBtn">시작</button>
				<button class="timer-btn pause-btn" id="pauseBtn" disabled>일시정지</button>
				<button class="timer-btn stop-btn" id="stopBtn" disabled>정지</button>
			</div>
			<div class="status" >
			<br>
			<h4 id="status"></h4><br>
			<%if(trList != null){%>
				<h3>내 공부 시간</h3><br>
				<%if(trList.isEmpty()){ %>
				<h5>조회된 데이터가 없습니다.</h5>
				<%} %>
				<%for(TimeRecord tr : trList){
				%>
				
				<h4><%=tr.userId() %> - <%=tr.totalTime() %></h4>
			<% }
				}%>
			</div>
		</div>
	</div>
		
</div>

</section>
<script>
        document.addEventListener('DOMContentLoaded', function() {
            // 요소 선택
            const timer = document.getElementById('timer');
            const startBtn = document.getElementById('startBtn');
            const pauseBtn = document.getElementById('pauseBtn');
            const stopBtn = document.getElementById('stopBtn');
            const status = document.getElementById('status');
            
            // 타이머 변수
            let startTime = 0;
            let elapsedTime = 0;
            let timerInterval;
            let isRunning = false;
            let isPaused = false;
            let recordedStartTime = null;
            
            // 타이머 업데이트 함수
            function updateTimer() {
                const currentTime = Date.now();
                elapsedTime = currentTime - startTime;
                timer.textContent = formattedTime(elapsedTime);
            }
            
            // 시간 표시 함수
            function formattedTime(time) {
                const hours = Math.floor(time / 3600000);
                const minutes = Math.floor((time % 3600000) / 60000);
                const seconds = Math.floor((time % 60000) / 1000);
                
                const formattedHours = String(hours).padStart(2, '0');
                const formattedMinutes = String(minutes).padStart(2, '0');
                const formattedSeconds = String(seconds).padStart(2, '0');
                
                return `\${formattedHours}:\${formattedMinutes}:\${formattedSeconds}`;
            }
            
            // 시작 버튼 클릭 이벤트
            startBtn.addEventListener('click', function() {
                if (!isRunning) {
                    if (!isPaused) {
                        startTime = Date.now();
                        recordedStartTime = new Date();
                    } else {
                        startTime = Date.now() - elapsedTime;
                        isPaused = false;
                    }
                    
                    timerInterval = setInterval(updateTimer, 100); // 100ms 간격으로 변경 (더 안정적)
                    isRunning = true;
                    
                    startBtn.disabled = true;
                    pauseBtn.disabled = false;
                    stopBtn.disabled = false;
                    
                    status.textContent = '타이머가 실행 중입니다...';
                }
            });
            
            // 일시정지 버튼 클릭 이벤트
            pauseBtn.addEventListener('click', function() {
                if (isRunning) {
                    clearInterval(timerInterval);
                    isRunning = false;
                    isPaused = true;
                    
                    startBtn.disabled = false;
                    pauseBtn.disabled = true;
                    
                    status.textContent = '타이머가 일시정지되었습니다.';
                }
            });
            
            // 정지 버튼 클릭 이벤트
            stopBtn.addEventListener('click', function() {
                // 타이머 정지
                clearInterval(timerInterval);
                
                // 최종 시간 저장
                const finalTime = elapsedTime;
                const recordedEndTime = new Date();
                
                // 타이머 초기화
                isRunning = false;
                isPaused = false;
                elapsedTime = 0;
                timer.textContent = formattedTime(0);
                
                // 버튼 상태 초기화
                startBtn.disabled = false;
                pauseBtn.disabled = true;
                stopBtn.disabled = true;
                
                saveTime(finalTime, recordedStartTime, recordedEndTime);
            });
            
            function saveTime(time, startTimeObj, endTimeObj) {
            	status.textContent = '데이터 저장 중...';
                <%if(loginUser==null){%>
                alert("데이터 저장에 실패하였습니다. 로그인 후 사용 가능한 기능입니다.");
                status.textContent = '';
                <% }else {%>
                const totalTime = formattedTime(time);
                const category = "test";
                const userId = '<%=loginUser.userId()%>';

                const timeData = {
					category : category,
                	startTime: startTimeObj,
                    endTime: endTimeObj,
                    totalTime: totalTime,
                    userId : userId
                };
                
                fetch("<%=request.getContextPath()%>/study/timesave.do", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(timeData)
                })
                .then(response => {
                    if (response.ok) {
                        return response.json();
                    }
                    throw new Error('네트워크 응답이 올바르지 않습니다.');
                })
                .then(data => {
                    alert('타이머 데이터가 성공적으로 저장되었습니다!');
                    console.log('저장된 데이터:', data);
					location.replace(location.href);
                })
                .catch(error => {
                    status.textContent = '데이터 저장 실패: ' + error.message;
                    console.error('저장 오류:', error);
                });
                <% }%>
            }

            // 페이지 떠날 때 경고
            window.addEventListener('beforeunload', function(e) {
                if (isRunning) {
                    e.preventDefault();
                    e.returnValue = ''; // 경고창 띄움
                }
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
    	        	location.assign("<%=request.getContextPath() %>/study/timeranking.do");
    	        }else if(tabId=="studygroup"){
    	        	location.assign("<%=request.getContextPath() %>/study/groupdetail.do");
    	        }else if(tabId=="grouplist"){
    	        	location.assign("<%=request.getContextPath() %>/study/grouplist.do");
    	        }
    	    });
        });
        


    </script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>