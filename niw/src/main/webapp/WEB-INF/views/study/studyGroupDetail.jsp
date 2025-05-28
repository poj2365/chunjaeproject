<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@include file="/WEB-INF/views/common/header.jsp" %>
   <!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
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
@media (max-width: 768px) {
  .arrow-left, .arrow-right {
    display: none;
  }
}
    .content-card {
    position: relative;
    width: 100%;
    max-width: 1300px
    background-color: white;
    padding: 30px;
    margin-top: 30px;
    margin-bottom: 30px
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
            <div class="user-id"></div>
            <div class="user-name"></div>
            <div class="point-info">포인트:P</div>
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
            <div class="menu-title">타이머</div>
            <ul>
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
<div class="tabs">
    <div class="tab-item active" data-tab="posts">b</div>
    <div class="tab-item" data-tab="comments">작성한 댓글</div>
    <div class="tab-item" data-tab="current-studies">참여중인 스터디</div>
</div>

  <!-- 상세 정보 -->
  <div class="content-card" id="detailSection">
    <!-- 화살표 버튼 -->
  <button class="arrow-button arrow-left btn btn-outline-secondary" onclick="toggleSection()">
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M15 8a.5.5 0 0 0-.5-.5H2.707l3.147-3.146a.5.5 0 1 0-.708-.708l-4 4a.5.5 0 0 0 0 .708l4 4a.5.5 0 0 0 .708-.708L2.707 8.5H14.5A.5.5 0 0 0 15 8"/>
</svg>
</button>
  <button class="arrow-button arrow-right btn btn-outline-secondary" onclick="toggleSection()">
  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8"/>
</svg>
  </button>
    <h2>같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)</h2>
    <p><strong>NullisWell</strong> · 개설일자: 2025년 4월 24일</p>
    <hr/>
    <p>👥 4명 남음 / 5명</p>
    <p><strong>시작:</strong> 2025년 5월 11일 오후 5:00</p>
    <p><strong>종료:</strong> 2025년 5월 11일 오후 7:00</p>
    <p><strong>장소:</strong> 연산역 근처 커피숍</p>
    <p><strong>비용:</strong> 개별 비용</p>
    <br/>
    <p>같이 성장할 백엔드 스터디원 모집합니다<br/>
    매주 자바 스프링을 토론하고 배우는 모임입니다.<br/>
    스터디장소 : 가디역 근처 커피숍<br/>
    인원 : 5명<br/>
    시간 : 일요일 오후 5시~7시 (2시간 이내)<br/>
    대상 : 자바 기반 스프링 관련 백엔드 직장인 스터디 참여<br/>
    필수사항 : 꼭 시간개념이 있는분만 신청해주세요.</p>
  </div>

  <!-- 차트 섹션 -->
  <div class="content-card" id="chartSection">
    <h3>스터디그룹별 공부 시간</h3>
    <div class="chart-container">
      <canvas id="studyChart"></canvas>
    </div>
  </div>
</div>
		
    </div>
<script>

$(document).ready(function() {

    // 탭 전환 이벤트
    $('.tab-item').on('click', function() {
        var $this = $(this);
        var tabId = $this.data('tab');
        
        // 탭 활성화
        $('.tab-item').removeClass('active');
        $this.addClass('active');
    });

// 사이드바 메뉴 클릭 이벤트
$('.menu-item').on('click', function() {
    var $this = $(this);
    var tabId = $this.data('tab');
    console.log(tabId);
    if(tabId=="calendar"){
    	location.assign("<%=request.getContextPath() %>/study/calender.do");
    }else if(tabId=="rank"){
    	location.assign("<%=request.getContextPath() %>/study/timerecord.do");
    }else if(tabId=="studygroup"){
    	location.assign("<%=request.getContextPath() %>/study/groupdetail.do");
    }else if(tabId=="grouplist"){
    	location.assign("<%=request.getContextPath() %>/study/grouplist.do");
    }
});

  let showingDetail = true;

  function toggleSection() {
    showingDetail = !showingDetail;
    document.getElementById("detailSection").style.display = showingDetail ? "block" : "none";
    document.getElementById("chartSection").style.display = showingDetail ? "none" : "block";

    if (!showingDetail) {
      drawChart();
    }
  }

  const studyData = [
    { name: "홍길동", time: 120 },
    { name: "김민지", time: 95 },
    { name: "이영희", time: 75 },
    { name: "사용자1", time: 60 },
    { name: "사용자2", time: 50 }
  ];

  function drawChart() {
    const ctx = document.getElementById('studyChart').getContext('2d');

    if (window.studyChartInstance) {
      window.studyChartInstance.destroy();
    }

    window.studyChartInstance = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: studyData.map(item => item.name),
        datasets: [{
          label: '공부 시간 (분)',
          data: studyData.map(item => item.time),
          backgroundColor: '#74b9ff'
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              stepSize: 30
            }
          }
        }
      }
    });
  }
</script>
</section>
   <%@include file="/WEB-INF/views/common/footer.jsp" %>