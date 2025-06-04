<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.niw.market.model.dto.PurchasedMaterial" %>

<%
    List<PurchasedMaterial> materials = (List<PurchasedMaterial>)request.getAttribute("materials");
    String pageBar = (String)request.getAttribute("pageBar");
    
    Integer totalCount = (Integer)request.getAttribute("totalCount");
    Integer totalAmount = (Integer)request.getAttribute("totalAmount");
    Integer totalDownloads = (Integer)request.getAttribute("totalDownloads");
    Integer totalReviews = (Integer)request.getAttribute("totalReviews");
    
    // null 체크
    if (totalCount == null) totalCount = 0;
    if (totalAmount == null) totalAmount = 0;
    if (totalDownloads == null) totalDownloads = 0;
    if (totalReviews == null) totalReviews = 0;
%>

<style>
.container {
    max-width: calc(1140px + 200px); /* Bootstrap container 기본보다 10px 넓게 */
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
    
    .materials-table-container {
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }
    
    .materials-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
        min-width:1000px;
    }
    
    .materials-table th {
        background-color: var(--bs-blind-dark);
        color: white;
        padding: 15px 12px;
        text-align: left;
        font-weight: 600;
        border: none;
    }
    
    .materials-table th:first-child {
        width: 30%;
    }
    
    .materials-table th:nth-child(2) {
        width: 15%;
    }
    
    .materials-table th:nth-child(3) {
        width: 12%;
    }
    
    .materials-table th:nth-child(4) {
        width: 12%;
    }
    
    .materials-table th:nth-child(5) {
        width: 18%;
    }
    
 /*    .materials-table th:nth-child(6) {
        width: 25%;
        text-align: center;
    } */
    
    .materials-table th:last-child {
        width: 23%;
        text-align: center;
    }
    
    .materials-table td {
        padding: 15px 12px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }
    
    .materials-table tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    .materials-table tbody tr:last-child td {
        border-bottom: none;
    }
    
    .material-title {
        font-weight: 600;
        color: #333;
        margin-bottom: 4px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        line-height: 1.4;
        max-height: 2.8em;
    }
    
    .material-description {
        font-size: 12px;
        color: #888;
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    
    .category-badge {
        background-color: var(--bs-blind-light-gray);
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        display: inline-block;
        margin-bottom: 2px;
    }
    
    .grade-badge {
        background-color: #6c757d;
        color: white;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 11px;
        display: inline-block;
        margin-right: 4px;
    }
    
    .subject-badge {
        background-color: #17a2b8;
        color: white;
        padding: 2px 6px;
        border-radius: 3px;
        font-size: 11px;
        display: inline-block;
    }
    
    .instructor-name {
        font-weight: 500;
        color: #555;
    }
    
    .material-price {
        font-weight: bold;
        color: var(--bs-blind-dark);
        font-size: 16px;
    }
    
    .purchase-date {
        font-size: 14px;
        color: #666;
    }
    
    .download-count {
        text-align: center;
        font-weight: 600;
        color: #333;
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
    
    .btn-download {
        background-color: var(--bs-blind-dark);
        color: white;
    }
    
    .btn-download:hover {
        background-color: var(--bs-blind-gray);
        color: white;
    }
    
    .btn-download:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    
    .btn-review {
        background-color: #ffc107;
        color: #333;
    }
    
    .btn-review:hover {
        background-color: #e0a800;
        color: #333;
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
    
    /* 페이지네이션 스타일 커스터마이징 */
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
        
        .materials-table-container {
            overflow-x: auto;
        }
        
        .materials-table {
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
        <h2 class="content-title">구매한 학습자료</h2>
    </div>

    <!-- 통계 요약 -->
    <div class="stats-summary">
        <div class="stat-item">
            <div class="stat-number"><%=totalCount%></div>
            <div class="stat-label">총 구매 자료</div>
        </div>
        <div class="stat-item">
            <div class="stat-number"><%=String.format("%,d", totalAmount)%>원</div>
            <div class="stat-label">총 구매 금액</div>
        </div>
      <%--   <div class="stat-item">
            <div class="stat-number"><%=totalDownloads%></div>
            <div class="stat-label">다운로드 횟수</div>
        </div> --%>
        <div class="stat-item">
            <div class="stat-number"><%=totalReviews%></div>
            <div class="stat-label">작성한 리뷰</div>
        </div>
    </div>

    <!-- 검색 결과 정보 -->
    <div class="results-info">
        <div class="results-count">
            총 <strong><%=totalCount%></strong>개의 구매한 자료가 있습니다.
        </div>
    </div>

    <!-- 자료 목록 테이블 -->
    <div class="materials-table-container">
        <%
        if (materials != null && !materials.isEmpty()) {
        %>
            <table class="materials-table">
                <thead>
                    <tr>
                        <th>자료명</th>
                        <th>카테고리</th>
                        <th>강사명</th>
                        <th>구매가격</th>
                        <th>구매일</th>
                        <!-- <th>다운로드</th> -->
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    for (PurchasedMaterial material : materials) {
                    %>
                        <tr>
                            <td>
                                <div class="material-title"><%=material.materialTitle()%></div>
                                <%
                                if (material.materialDiscription() != null && !material.materialDiscription().trim().isEmpty()) {
                                %>
                                    <div class="material-description"><%=material.materialDiscription()%></div>
                                <%
                                }
                                %>
                            </td>
                            <td>
                                <div class="category-badge"><%=material.materialCategory()%></div>
                                <br>
                                <%
                                if (material.materialGrade() != null && !material.materialGrade().trim().isEmpty()) {
                                %>
                                    <span class="grade-badge"><%=material.materialGrade()%></span>
                                <%
                                }
                                if (material.materialSubject() != null && !material.materialSubject().trim().isEmpty()) {
                                %>
                                    <span class="subject-badge"><%=material.materialSubject()%></span>
                                <%
                                }
                                %>
                            </td>
                            <td>
                                <div class="instructor-name"><%=material.instructorName()%></div>
                            </td>
                            <td>
                                <div class="material-price"><%=String.format("%,d", material.purchasePrice())%>원</div>
                            </td>
                            <td>
                                <div class="purchase-date"><%=material.purchaseDate()%></div>
                            </td>
                            <%-- <td>
                                <div class="download-count"><%=material.materialDownloadCount()%>회</div>
                            </td> --%>
                            <td>
                                <div class="action-buttons">
                                    <button class="btn-sm btn-download" 
                                            data-material-id="<%=material.materialId()%>" 
                                            onclick="downloadMaterial(<%=material.materialId()%>)">
                                        <i class="bi bi-download"></i>다운로드
                                    </button>
                                    <button class="btn-sm btn-review" 
                                            data-material-id="<%=material.materialId()%>" 
                                            data-material-title="<%=material.materialTitle()%>"
                                            onclick="openReviewModal(<%=material.materialId()%>, '<%=material.materialTitle()%>')">
                                        <i class="bi bi-star"></i>리뷰
                                    </button>
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
                <h3>구매한 학습자료가 없습니다</h3>
                <p>아직 구매한 학습자료가 없습니다.<br>다양한 학습자료를 둘러보세요!</p>
                <a href="<%=request.getContextPath()%>/market/list.do" class="btn btn-primary">
                    <i class="bi bi-search me-1"></i>학습자료 둘러보기
                </a>
            </div>
        <%
        }
        %>
    </div>

    <!-- 페이지네이션 (서블릿에서 생성된 pageBar 사용) -->
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
// 현재 페이지 번호를 저장 
var currentPage = <%=request.getAttribute("currentPage") != null ? request.getAttribute("currentPage") : 1%>;

// 페이지가 마이페이지 내부에서 로드되었는지 확인
var isInMypage = <%=request.getParameter("fromMypage") != null ? "true" : "false"%>;

// 다운로드 함수
function downloadMaterial(materialId) {
    if (confirm('이 자료를 다운로드하시겠습니까?')) {
        // 새 창에서 다운로드
        window.open('<%= request.getContextPath() %>/market/download.do?id=' + materialId, '_blank');
    }
}

// 리뷰 모달 함수
function openReviewModal(materialId, materialTitle) {
    if(confirm('리뷰 작성 페이지로 이동하시겠습니까?\n자료: ' + materialTitle)) {
        window.location.href = '<%=request.getContextPath()%>/review/write.do?materialId=' + materialId;
    }
}

// 🔥 핵심: 자체 AJAX로 페이지 로드 (마이페이지 코드 건드리지 않음)
function loadMaterialPage(page) {
    // 로딩 표시 (기존 테이블 영역만)
    $('.materials-table-container').html(`
        <div style="padding: 60px 0; text-align: center; color: #888;">
            <div style="border: 4px solid #f3f3f3; border-top: 4px solid var(--bs-blind-dark); border-radius: 50%; width: 40px; height: 40px; animation: spin 1s linear infinite; margin: 0 auto 20px;"></div>
            <p>데이터를 불러오는 중입니다...</p>
        </div>
    `);
    
    // 페이지네이션도 숨기기
    $('.pagination').parent().hide();
    
    $.ajax({
        url: '<%=request.getContextPath()%>/user/mypage/materials.do',
        type: 'GET',
        data: { cPage: page,
        		fromMypage: 'true'	
        },
        headers: {
            'X-Requested-With': 'XMLHttpRequest' 
        },
        success: function(data) {
            // 임시 컨테이너에 받은 HTML 넣기
            var $temp = $('<div>').html(data);
            
            // 필요한 부분만 추출해서 교체
            var newTableHtml = $temp.find('.materials-table-container').html();
            var newStatsHtml = $temp.find('.stats-summary').html();
            var newResultsHtml = $temp.find('.results-info').html();
            var newPaginationHtml = $temp.find('.pagination').parent().html();
            
            // 기존 요소들 업데이트
            if (newTableHtml) $('.materials-table-container').html(newTableHtml);
            if (newStatsHtml) $('.stats-summary').html(newStatsHtml);
            if (newResultsHtml) $('.results-info').html(newResultsHtml);
            if (newPaginationHtml) {
                $('.pagination').parent().html(newPaginationHtml).show();
            }
            
            // 현재 페이지 업데이트
            currentPage = page;
            
            // 스크롤을 맨 위로
            if (isInMypage) {
                $('.main-content').scrollTop(0);
            } else {
                $('html, body').scrollTop(0);
            }
        },
        error: function(xhr, status, error) {
            $('.materials-table-container').html(`
                <div style="padding: 60px 0; text-align: center; color: #dc3545;">
                    <i class="bi bi-exclamation-triangle" style="font-size: 48px; margin-bottom: 20px;"></i>
                    <p>데이터를 불러오는데 실패했습니다.</p>
                    <button class="btn btn-primary" onclick="loadMaterialPage(` + page + `)">다시 시도</button>
                </div>
            `);
        }
    });
}

// 페이지 로드 완료시 초기화
$(document).ready(function() {
    // 🔥 핵심: 페이지네이션 클릭 이벤트 (자체 처리)
    $(document).on('click', '.material-page-link', function(e) {
        e.preventDefault(); // 기본 링크 동작 방지
        
        var page = $(this).data('page');
        
        // 마이페이지 내부에서만 AJAX 처리
        if (isInMypage) {
            loadMaterialPage(page);
        } else {
            // 직접 접근시에는 일반적인 페이지 이동
            window.location.href = '<%=request.getContextPath()%>/user/mypage/materials.do?cPage=' + page;
        }
    });
    
    // 페이지네이션 링크에 호버 효과 추가
    $(document).on('mouseenter', '.pagination .page-link', function() {
        if (!$(this).closest('.page-item').hasClass('active') && !$(this).closest('.page-item').hasClass('disabled')) {
            $(this).css('background-color', 'var(--bs-blind-light-gray)');
            $(this).css('color', 'white');
        }
    }).on('mouseleave', '.pagination .page-link', function() {
        if (!$(this).closest('.page-item').hasClass('active')) {
            $(this).css('background-color', '');
            $(this).css('color', 'var(--bs-blind-dark)');
        }
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

