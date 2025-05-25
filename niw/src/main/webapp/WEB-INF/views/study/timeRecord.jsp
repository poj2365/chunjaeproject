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
.contianer {
	font-family: 'Arial', sans-serif;
	display: flex;
	justify-content: center;
	s align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #f5f5f5;
}

.timer-container {
	max-width: 700px;
	min-width: 300px;
	margin: 0 auto 30px;
	margin-top: 20px;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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

/*  */
.chart-container {
	max-width: 700px;
	margin: 0 auto 30px;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.ranking-list {
	max-width: 700px;
	margin: 0 auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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
</style>
<section>
	<div class="container">
		<div class="timer-container">
			<h2>공부 시간 타이머</h2>
			<div class="timer-display" id="timer">00:00:00</div>
			<div class="buttons">
				<button class="timer-btn start-btn" id="startBtn">시작</button>
				<button class="timer-btn pause-btn" id="pauseBtn" disabled>일시정지</button>
				<button class="timer-btn stop-btn" id="stopBtn" disabled>정지</button>
			</div>
			<div class="status" id="status"></div>
		</div>
		<div class="chart-container">
			<h3>오늘의 공부 시간 그래프</h3>
			<canvas id="studyChart"></canvas>
		</div>

		<div class="ranking-list">
			<h3>오늘의 공부 시간 랭킹(시간:분:초)</h3>
			<div class="ranking-item"></div>

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
                
                const totalTime = formattedTime(time);
                const category = "test";
                const userId = "user_0001";

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
            }
            
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
         console.log(labels);
		 console.log(totalTime);
		 
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
        });
        
        // 페이지 떠날 때 경고
           window.addEventListener('beforeunload', function(e) {
               if (isRunning) {
                   e.preventDefault();
                   e.returnValue = ''; // 경고창 띄움
               }
           });
        
       
/*             const ctx = document.getElementById('studyChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['홍길동', '이영희', '김민수', '사용자1', '사용자2'],
                    datasets: [{
                        label: '공부 시간 (분)',
                        data: [120, 95, 80, 65, 50],
                        backgroundColor: [
                            '#FFD700', '#C0C0C0', '#CD7F32', '#4A90E2', '#4A90E2'
                        ]
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
            }); */
    </script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>