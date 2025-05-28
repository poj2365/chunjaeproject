<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/header.jsp" %>
<style>
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
                <li class="menu-item active" data-tab="recruit">
                    <i class="bi bi-person-plus"></i>스터디 모집
                </li>
                <li class="menu-item" data-tab="studygroup">
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
  <!-- 메인 콘텐츠 -->
    <div class="container mt-4">
        <div class="row">

            <!-- 왼쪽 컬럼 -->
            <div class="col-md-12 board-menu">
                <h5 class="border-bottom pb-2 mt-3 mb-3">
                    <a href="<%=request.getContextPath()%>/study/studymain.do">스터디 게시판 </a>
                </h5>
                <ul class="list-group">
                    <a href="<%=request.getContextPath()%>/study/studygroupdetail.do">
                    <li class="list-group-item"><span class="badge bg-secondary" style="top: 30%; right: 59%;">모집완료</span> [Kotlin + Spring] 코프링 스터디원 모집 <span class="float-end text-muted">77</span></li></a>
                    <a href="./groupdetail.html">
                    <li class="list-group-item"><span class="badge bg-secondary" style="top: 30%; right: 41%;">모집완료</span> 팀네이버 신입공채 Tech 최종면접 스터디원 모집 (Data 분야) <span class="float-end text-muted">81</span>
                    </li></a>
                    <a href="./groupdetail.html">
                    <li class="list-group-item"><span class="badge bg-secondary" style="top: 30%; right: 50%;">모집완료</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge bg-secondary" style="top: 30%; right: 50%;">모집완료</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge2" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge-recruiting" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge-recruiting" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge-recruiting" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                    <li class="list-group-item"><span class="badge-recruiting" style="top: 30%; right: 50%;">모집중</span> 같이 성장할 백엔드 스터디원 모집!(JAVA / Spring)<span class="float-end text-muted">81</span>
                    </li></a>
                </ul>
            </div>
            <p style="text-align: center; margin: 10px; font-size: 18px;">1 2 3 4 5 6 7 8 9</p>
            <button class="btn btn-secondary" onclick="createGroup();">그룹 생성</button>
            <!-- 로그인 체크 해야되고 회원 id 값 가져가야함 -->
        </div>
    </div>
    </div>
</div>
</section>
<script>
	const createGroup = ()=>{
		const userId = "test";
		location.assign("<%=request.getContextPath()%>/study/groupcreate.do?userId="+userId);
	}
</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>