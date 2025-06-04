<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.niw.instructor.model.dto.InstructorApplication" %>
<%@ page import="com.niw.instructor.model.Enums.ApplicationStatus" %>

<%
    List<InstructorApplication> applications = (List<InstructorApplication>)request.getAttribute("applications");
    String pageBar = (String)request.getAttribute("pageBar");
    String selectedStatus = (String)request.getAttribute("selectedStatus");
    
    Integer totalCount = (Integer)request.getAttribute("totalCount");
    Integer pendingCount = (Integer)request.getAttribute("pendingCount");
    Integer approvedCount = (Integer)request.getAttribute("approvedCount");
    Integer rejectedCount = (Integer)request.getAttribute("rejectedCount");
    
    // null 체크
    if (totalCount == null) totalCount = 0;
    if (pendingCount == null) pendingCount = 0;
    if (approvedCount == null) approvedCount = 0;
    if (rejectedCount == null) rejectedCount = 0;
    if (selectedStatus == null) selectedStatus = "전체";
%>

<style>
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
    
    .stats-summary {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-item {
        background-color: var(--bs-primary-light);
        border-radius: 10px;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .stat-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    
    .stat-item.pending {
        background-color: #fff3cd;
        border-left: 4px solid #ffc107;
    }
    
    .stat-item.approved {
        background-color: #d1e7dd;
        border-left: 4px solid #198754;
    }
    
    .stat-item.rejected {
        background-color: #f8d7da;
        border-left: 4px solid #dc3545;
    }
    
    .stat-item.total {
        background-color: #e7f1ff;
        border-left: 4px solid var(--bs-blind-dark);
    }
    
    .stat-number {
        font-size: 24px;
        font-weight: bold;
        color: var(--bs-blind-dark);
        margin-bottom: 5px;
    }
    
    .stat-label {
        font-size: 14px;
        color: #666;
    }
    
    .filter-section {
        display: flex;
        gap: 10px;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .filter-btn {
        padding: 8px 16px;
        border: 1px solid #ddd;
        background-color: white;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.2s;
        font-size: 14px;
    }
    
    .filter-btn.active {
        background-color: var(--bs-blind-dark);
        color: white;
        border-color: var(--bs-blind-dark);
    }
    
    .filter-btn:hover {
        background-color: var(--bs-blind-light-gray);
        color: white;
        border-color: var(--bs-blind-light-gray);
    }
    
    .applications-table-container {
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }
    
    .applications-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
    }
    
    .applications-table th {
        background-color: var(--bs-blind-dark);
        color: white;
        padding: 15px 12px;
        text-align: left;
        font-weight: 600;
        border: none;
    }
    
    .applications-table th:first-child {
        width: 25%;
    }
    
    .applications-table th:nth-child(2) {
        width: 15%;
    }
    
    .applications-table th:nth-child(3) {
        width: 20%;
    }
    
    .applications-table th:nth-child(4) {
        width: 15%;
    }
    
    .applications-table th:nth-child(5) {
        width: 10%;
        text-align: center;
    }
    
    .applications-table th:last-child {
        width: 15%;
        text-align: center;
    }
    
    .applications-table td {
        padding: 15px 12px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }
    
    .applications-table tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    .applications-table tbody tr:last-child td {
        border-bottom: none;
    }
    
    .instructor-name {
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
    }
    
    .user-id {
        font-size: 12px;
        color: #888;
    }
    
    .bank-info {
        font-size: 14px;
        color: #555;
    }
    
    .account-info {
        font-size: 12px;
        color: #777;
        margin-top: 2px;
    }
    
    .application-date {
        font-size: 14px;
        color: #666;
    }
    
    .status-badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 500;
        text-align: center;
        display: inline-block;
        min-width: 60px;
    }
    
    .status-pending {
        background-color: #fff3cd;
        color: #856404;
        border: 1px solid #ffeaa7;
    }
    
    .status-approved {
        background-color: #d1e7dd;
        color: #0f5132;
        border: 1px solid #badbcc;
    }
    
    .status-rejected {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f1aeb5;
    }
    
    .action-buttons {
        display: flex;
        gap: 5px;
        justify-content: center;
        flex-wrap: wrap;
    }
    
    .btn-sm {
        padding: 6px 12px;
        font-size: 12px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        transition: all 0.2s;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }
    
    .btn-detail {
        background-color: var(--bs-blind-dark);
        color: white;
    }
    
    .btn-detail:hover {
        background-color: var(--bs-blind-gray);
        color: white;
    }
    
    .btn-approve {
        background-color: #198754;
        color: white;
    }
    
    .btn-approve:hover {
        background-color: #157347;
        color: white;
    }
    
    .btn-reject {
        background-color: #dc3545;
        color: white;
    }
    
    .btn-reject:hover {
        background-color: #bb2d3b;
        color: white;
    }
    
    .btn-approve:disabled,
    .btn-reject:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        color: #888;
    }
    
    .empty-state i {
        font-size: 64px;
        margin-bottom: 20px;
        color: #ddd;
    }
    
    .empty-state h3 {
        margin-bottom: 10px;
        color: #666;
    }
    
    .empty-state p {
        margin-bottom: 20px;
    }
    
    .results-info {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
        padding: 0 5px;
    }
    
    .results-count {
        font-size: 14px;
        color: #666;
    }
    
    .results-count strong {
        color: var(--bs-blind-dark);
    }
    
    /* 페이지네이션 스타일 */
    .pagination {
        margin: 0;
    }
    
    .pagination .page-link {
        color: var(--bs-blind-dark);
        border-color: #dee2e6;
        padding: 8px 12px;
    }
    
    .pagination .page-item.active .page-link {
        background-color: var(--bs-blind-dark);
        border-color: var(--bs-blind-dark);
        color: white;
    }
    
    .pagination .page-item:hover .page-link {
        background-color: var(--bs-blind-light-gray);
        color: white;
        border-color: var(--bs-blind-light-gray);
    }
    
    .pagination .page-item.disabled .page-link {
        color: #6c757d;
        background-color: #fff;
        border-color: #dee2e6;
    }
    
    @media (max-width: 992px) {
        .stats-summary {
            grid-template-columns: repeat(2, 1fr);
        }
        
        .applications-table-container {
            overflow-x: auto;
        }
        
        .applications-table {
            min-width: 800px;
        }
    }
    
    @media (max-width: 768px) {
        .action-buttons {
            flex-direction: column;
        }
        
        .btn-sm {
            font-size: 11px;
            padding: 4px 8px;
        }
    }
    
    @media (max-width: 480px) {
        .stats-summary {
            grid-template-columns: 1fr;
        }
        
        .content-title {
            font-size: 20px;
        }
    }
</style>

<div class="container mt-4">
    <div class="content-header">
        <h2 class="content-title">권한 요청 목록</h2>
    </div>

    <!-- 통계 요약 -->
    <div class="stats-summary">
        <div class="stat-item total" onclick="filterByStatus('전체')">
            <div class="stat-number"><%=totalCount%></div>
            <div class="stat-label">전체 신청</div>
        </div>
        <div class="stat-item pending" onclick="filterByStatus('PENDING')">
            <div class="stat-number"><%=pendingCount%></div>
            <div class="stat-label">대기 중</div>
        </div>
        <div class="stat-item approved" onclick="filterByStatus('APPROVED')">
            <div class="stat-number"><%=approvedCount%></div>
            <div class="stat-label">승인됨</div>
        </div>
        <div class="stat-item rejected" onclick="filterByStatus('REJECTED')">
            <div class="stat-number"><%=rejectedCount%></div>
            <div class="stat-label">반려됨</div>
        </div>
    </div>

    <!-- 필터 섹션 -->
    <div class="filter-section">
        <span>상태별 필터:</span>
        <button class="filter-btn <%="전체".equals(selectedStatus) ? "active" : ""%>" onclick="filterByStatus('전체')">전체</button>
        <button class="filter-btn <%="PENDING".equals(selectedStatus) ? "active" : ""%>" onclick="filterByStatus('PENDING')">대기 중</button>
        <button class="filter-btn <%="APPROVED".equals(selectedStatus) ? "active" : ""%>" onclick="filterByStatus('APPROVED')">승인됨</button>
        <button class="filter-btn <%="REJECTED".equals(selectedStatus) ? "active" : ""%>" onclick="filterByStatus('REJECTED')">반려됨</button>
    </div>

    <!-- 검색 결과 정보 -->
    <div class="results-info">
        <div class="results-count">
            총 <strong><%=totalCount%></strong>개의 권한 요청이 있습니다.
        </div>
    </div>

    <!-- 신청서 목록 테이블 -->
    <div class="applications-table-container">
        <%
        if (applications != null && !applications.isEmpty()) {
        %>
            <table class="applications-table">
                <thead>
                    <tr>
                        <th>신청자</th>
                        <th>강사명</th>
                        <th>계좌 정보</th>
                        <th>신청일</th>
                        <th>상태</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for (InstructorApplication app : applications) {
                    %>
                        <tr>
                            <td>
                                <div class="instructor-name"><%=app.instructorName()%></div>
                                <div class="user-id">ID: <%=app.userId()%></div>
                            </td>
                            <td>
                                <div class="instructor-name"><%=app.instructorName()%></div>
                            </td>
                            <td>
                                <div class="bank-info"><%=app.bankName()%></div>
                                <div class="account-info"><%=app.accountHolder()%> (<%=app.accountNumber()%>)</div>
                            </td>
                            <td>
                                <div class="application-date"><%=app.applicationDate()%></div>
                            </td>
                            <td>
                                <%
                                String statusClass = "";
                                String statusText = "";
                                switch(app.applicationStatus()) {
                                    case WATING:
                                        statusClass = "status-pending";
                                        statusText = "대기 중";
                                        break;
                                    case APPROVED:
                                        statusClass = "status-approved";
                                        statusText = "승인됨";
                                        break;
                                    case REJECTED:
                                        statusClass = "status-rejected";
                                        statusText = "반려됨";
                                        break;
                                }
                                %>
                                <span class="status-badge <%=statusClass%>"><%=statusText%></span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-sm btn-detail" 
                                            onclick="viewDetail(<%=app.applicationId()%>)">
                                        <i class="bi bi-eye"></i>상세보기
                                    </button>
                                    <%
                                    if (app.applicationStatus() == ApplicationStatus.WATING) {
                                    %>
                                        <button class="btn-sm btn-approve" 
                                                onclick="approveApplication(<%=app.applicationId()%>, '<%=app.instructorName()%>')">
                                            <i class="bi bi-check-circle"></i>승인
                                        </button>
                                        <button class="btn-sm btn-reject" 
                                                onclick="rejectApplication(<%=app.applicationId()%>, '<%=app.instructorName()%>')">
                                            <i class="bi bi-x-circle"></i>반려
                                        </button>
                                    <%
                                    }
                                    %>
                                </div>
                            </td>
                        </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        <%
        } else {
        %>
            <div class="empty-state">
                <i class="bi bi-folder-x"></i>
                <h3>권한 요청이 없습니다</h3>
                <p>현재 조건에 맞는 권한 요청이 없습니다.</p>
            </div>
        <%
        }
        %>
    </div>

    <!-- 페이지네이션 -->
    <%
    if (pageBar != null && !pageBar.isEmpty()) {
    %>
        <div class="d-flex justify-content-center mt-4">
            <%=pageBar%>
        </div>
    <%
    }
    %>
</div>

<script>
// 현재 페이지 및 필터 정보
var currentPage = <%=request.getAttribute("currentPage") != null ? request.getAttribute("currentPage") : 1%>;
var currentStatus = '<%=selectedStatus%>';

// 상태별 필터링
function filterByStatus(status) {
    currentStatus = status;
    loadInstructorPage(1); // 첫 페이지로 이동
}

// 상세보기
function viewDetail(applicationId) {
    window.open('<%=request.getContextPath()%>/admin/instructor/detail.do?id=' + applicationId, 
                'instructorDetail', 'width=1000,height=800,scrollbars=yes');
}

// 승인 처리
function approveApplication(applicationId, instructorName) {
    var reviewComment = prompt(instructorName + ' 강사의 권한 요청을 승인하시겠습니까?\n\n승인 사유를 입력해주세요:', '자격 요건을 충족하여 승인합니다.');
    
    if (reviewComment !== null && reviewComment.trim() !== '') {
        processApplication(applicationId, 'approve', reviewComment);
    }
}

// 반려 처리
function rejectApplication(applicationId, instructorName) {
    var reviewComment = prompt(instructorName + ' 강사의 권한 요청을 반려하시겠습니까?\n\n반려 사유를 입력해주세요:', '');
    
    if (reviewComment !== null && reviewComment.trim() !== '') {
        processApplication(applicationId, 'reject', reviewComment);
    }
}

// 승인/반려 처리 공통 함수
function processApplication(applicationId, action, reviewComment) {
    $.ajax({
        url: '<%=request.getContextPath()%>/admin/instructor/approval.do',
        type: 'POST',
        data: {
            applicationId: applicationId,
            action: action,
            reviewComment: reviewComment
        },
        success: function(response) {
            if (response.success) {
                alert(response.message);
                loadInstructorPage(currentPage); // 현재 페이지 새로고침
            } else {
                alert('오류: ' + response.message);
            }
        },
        error: function() {
            alert('서버 오류가 발생했습니다.');
        }
    });
}

// 페이지 로드 함수
function loadInstructorPage(page) {
    // 로딩 표시
    $('.applications-table-container').html(`
        <div style="padding: 60px 0; text-align: center; color: #888;">
            <div style="border: 4px solid #f3f3f3; border-top: 4px solid var(--bs-blind-dark); border-radius: 50%; width: 40px; height: 40px; animation: spin 1s linear infinite; margin: 0 auto 20px;"></div>
            <p>데이터를 불러오는 중입니다...</p>
        </div>
    `);
    
    $.ajax({
        url: '<%=request.getContextPath()%>/admin/adminpage/instructor.do',
        type: 'GET',
        data: { 
            cPage: page,
            status: currentStatus
        },
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
        },
        success: function(data) {
            // 전체 콘텐츠 교체
            $('.main-content').html(data);
            currentPage = page;
        },
        error: function() {
            $('.applications-table-container').html(`
                <div style="padding: 60px 0; text-align: center; color: #dc3545;">
                    <i class="bi bi-exclamation-triangle" style="font-size: 48px; margin-bottom: 20px;"></i>
                    <p>데이터를 불러오는데 실패했습니다.</p>
                    <button class="btn btn-primary" onclick="loadInstructorPage(` + page + `)">다시 시도</button>
                </div>
            `);
        }
    });
}

// 페이지 로드 완료시 초기화
$(document).ready(function() {
    // 페이지네이션 클릭 이벤트
    $(document).on('click', '.instructor-page-link', function(e) {
        e.preventDefault();
        var page = $(this).data('page');
        loadInstructorPage(page);
    });
});

// CSS 애니메이션 추가
$('<style>').prop('type', 'text/css').html(`
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
`).appendTo('head');
</script>