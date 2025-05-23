<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.timer-section {
	max-width: 700px;
	margin: 0 auto;
	padding: 20px;
	text-align: center;
	margin-bottom: 40px;
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.timer-display {
	font-size: 36px;
	margin: 20px 0;
}

.timer-buttons button {
	padding: 10px 20px;
	margin: 0 5px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.start {
	background-color: #4CAF50;
	color: white;
}

.pause {
	background-color: #FFA500;
	color: white;
}

.stop {
	background-color: #F44336;
	color: white;
}
        .status {
            margin-top: 1rem;
            color: #555;
            font-size: 0.9rem;
            height: 20px;
        }

/* */
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
		<div class="timer-section">
			<h2>공부 타이머</h2>
			<div class="timer-display" id="timer">00:00:00</div>
			<div class="timer-buttons">
				<button class="start" onclick="startTimer()">시작</button>
				<button class="pause" onclick="pauseTimer()">일시정지</button>
				<button class="stop" onclick="stopTimer()">정지</button>
			</div>
			        <div class="status" id="status"></div>
		</div>

		<div class="chart-container">
			<h3>공부 시간 그래프 (단위: 분)</h3>
			<canvas id="studyChart"></canvas>
		</div>

		<div class="ranking-list">
			<h3>공부 시간 랭킹</h3>
			<div class="ranking-item">🥇 홍길동 - 120분</div>
			<div class="ranking-item">🥈 이영희 - 95분</div>
			<div class="ranking-item">🥉 김민수 - 80분</div>
			<div class="ranking-item">4위 - 사용자1 - 65분</div>
			<div class="ranking-item">5위 - 사용자2 - 50분</div>
		</div>
	</div>

</section>
	<script>
    // 타이머 상태 변수들
    let startTime = 0;
    let endTime = 0;
    let timerInterval = null;

    // 시간 포맷팅 함수 (HH:mm:ss)
    function formatTime(ms) {
        const totalSeconds = Math.floor(ms / 1000);
        const h = String(Math.floor(totalSeconds / 3600)).padStart(2, '0');
        const m = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, '0');
        const s = String(totalSeconds % 60).padStart(2, '0');
        return `${h}:${m}:${s}`;
    }

    // 시작 버튼 클릭 시
    function startTimer() {
        if (!timerInterval) {
            startTime = Date.now() - endTime; // 재시작 가능하게
            timerInterval = setInterval(() => {
                elapsedTime = Date.now() - startTime;
                console.log(formatTime(endTime));
                document.getElementById('timer').textContent = formatTime(endTime);
            }, 1000);
        }
    }

    // 일시정지 버튼 클릭 시
    function pauseTimer() {
        clearInterval(timerInterval);
        timerInterval = null;
    }

    // 정지 버튼 클릭 시
    function stopTimer() {
        clearInterval(timerInterval);
        timerInterval = null;
        
        const timeData = {
        		
        }
        
        // 서버에 시간 저장 요청
        fetch("<%=request.getContextPath()%>/study/timesave.do", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: JSON.stringify(timeData)
        }).then(response => {
            if (response.ok) {
                alert("시간 저장이 완료되었습니다.");
            } else {
                alert("시간 저장이 실패하였습니다. 관리자에게 문의해주세요.");
            }
        });

        // 타이머 초기화
        endTime = 0;
        document.getElementById('timer').textContent = formatTime(endTime);
    }

            // 그래프 그리기
            const ctx = document.getElementById('studyChart').getContext('2d');
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
            });
        </script>
<%@include file="/WEB-INF/views/common/footer.jsp"%>