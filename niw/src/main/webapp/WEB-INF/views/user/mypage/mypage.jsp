<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
if (loginUser == null) {
	response.sendRedirect(request.getContextPath() + "/user/loginview.do");
	return;
}
%>

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

<!-- 메인 컨테이너 -->
<div class="mypage-container">
    <!-- 사이드바 영역 -->
    <div class="sidebar">
        <div class="profile-section">
            <div class="profile-pic">
                <i class="bi bi-person-circle" style="font-size: 60px; color: #ccc;"></i>
            </div>
            <div class="user-id"><%=loginUser.userId()%></div>
            <div class="user-name"><%=loginUser.userName()%></div>
            <div class="point-info">포인트: <%=loginUser.userPoint()%>P</div>
        </div>
        <div class="menu-section">
            <div class="menu-title">내 계정</div>
            <ul>
                <li class="menu-item active" data-tab="info">
                    <i class="bi bi-person"></i>회원정보 조회/수정
                </li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">내 활동</div>
            <ul>
                <li class="menu-item" data-tab="activity">
                    <i class="bi bi-clock-history"></i>활동 내역
                </li>
                <li class="menu-item" data-tab="point">
                    <i class="bi bi-coin"></i>포인트 내역
                </li>
                <li class="menu-item" data-tab="materials">
                    <i class="bi bi-file-earmark-text"></i>구매한 학습자료
                </li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">판매 관리</div>
            <ul>
                <li class="menu-item" data-tab="sales">
                    <i class="bi bi-shop"></i>학습자료 판매 관리
                </li>
            </ul>
        </div>
    </div>
    
    <!-- 메인 컨텐츠 영역 -->
    <div class="main-content">
        <!-- 초기 로딩 시 회원정보 표시 -->
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <p>페이지를 불러오는 중입니다...</p>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 페이지 로드 시 기본 탭(회원정보) 로드
    loadTabContent('info');
    
    // 사이드바 메뉴 클릭 이벤트
    $('.menu-item').on('click', function() {
        var $this = $(this);
        var tabId = $this.data('tab');
        
        // 메뉴 활성화 표시
        $('.menu-item').removeClass('active');
        $this.addClass('active');
        
        // 해당 탭 콘텐츠 로드
        loadTabContent(tabId);
    });
});

// 탭 콘텐츠 로드 함수
function loadTabContent(tabId) {
    // 로딩 표시
    $('.main-content').html(`
        <div class="loading-content">
            <div class="loading-spinner"></div>
            <p>페이지를 불러오는 중입니다...</p>
        </div>
    `);
    
    // AJAX로 해당 탭 페이지 로드
    $.ajax({
        url: '<%=request.getContextPath()%>/user/mypage/' + tabId + '.do',
        type: 'GET',
        success: function(data) {
            $('.main-content').html(data);
        },
        error: function(xhr, status, error) {
            $('.main-content').html(`
                <div class="loading-content">
                    <i class="bi bi-exclamation-triangle" style="font-size: 48px; color: #dc3545; margin-bottom: 20px;"></i>
                    <p>페이지를 불러오는데 실패했습니다.</p>
                    <button class="btn btn-primary" onclick="loadTabContent('` + tabId + `')">다시 시도</button>
                </div>
            `);
        }
    });
}


</script>





<%@ include file="/WEB-INF/views/common/footer.jsp" %>