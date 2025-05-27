<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User" %>
<%
    User loginUser = (User)session.getAttribute("loginUser");
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
    
    .content-section {
        margin-bottom: 30px;
    }
    
    .section-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 15px;
        color: #444;
    }
    
    .section-title .badge {
        background-color: var(--bs-blind-dark);
        color: white;
        font-size: 14px;
        padding: 2px 10px;
        border-radius: 20px;
        margin-left: 10px;
    }
    
    .form-input {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.2s;
    }
    
    .form-input:focus {
        border-color: var(--bs-blind-dark);
        box-shadow: 0 0 0 3px rgba(36, 177, 181, 0.2);
        outline: none;
    }
    
    .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #444;
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
    
    .point-history {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
    }
    
    .point-history th,
    .point-history td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #eee;
    }
    
    .point-history th {
        background-color: var(--bs-primary-light);
        font-weight: bold;
        color: #444;
    }
    
    .point-plus {
        color: var(--bs-blind-dark);
        font-weight: bold;
    }
    
    .point-minus {
        color: #ff6b6b;
        font-weight: bold;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    
    .page-item {
        margin: 0 5px;
    }
    
    .page-link {
        display: block;
        padding: 8px 12px;
        border-radius: 6px;
        transition: all 0.2s;
        text-decoration: none;
        color: #333;
    }
    
    .page-link:hover {
        background-color: #f5f6f7;
    }
    
    .page-item.active .page-link {
        background-color: var(--bs-blind-dark);
        color: white;
    }
    
    .info-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
    }
    
    .info-table th,
    .info-table td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #eee;
    }
    
    .info-table th {
        width: 180px;
        background-color: var(--bs-primary-light);
        font-weight: normal;
        color: #444;
    }
    
    .point-large {
        font-size: 24px;
        font-weight: bold;
        color: var(--bs-blind-dark);
    }
</style>

<div class="content-header">
    <h2 class="content-title">포인트 내역 조회</h2>
</div>

<div class="content-section">
    <h3 class="section-title">잔여 포인트 <span class="badge"><%=loginUser.userPoint()%>P</span></h3>
    
    <!-- 포인트 검색 필터 -->
    <div class="content-section">
        <form id="point-filter-form">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <label class="form-label">시작일</label>
                    <input type="date" id="start-date" name="startDate" class="form-input">
                </div>
                <div class="col-md-3 mb-3">
                    <label class="form-label">종료일</label>
                    <input type="date" id="end-date" name="endDate" class="form-input">
                </div>
                <div class="col-md-3 mb-3">
                    <label class="form-label">구분</label>
                    <select id="point-type" name="pointType" class="form-input">
                        <option value="all">전체</option>
                        <option value="plus">적립(+)</option>
                        <option value="minus">사용(-)</option>
                    </select>
                </div>
                <div class="col-md-3 mb-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="bi bi-search me-1"></i>검색
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    <div class="tabs">
        <div class="tab-item active" data-type="all">전체</div>
        <div class="tab-item" data-type="plus">적립</div>
        <div class="tab-item" data-type="minus">사용</div>
    </div>
    
    <div id="point-history-content">
        <table class="point-history">
            <thead>
                <tr>
                    <th>날짜</th>
                    <th>내용</th>
                    <th>포인트</th>
                    <th>잔여 포인트</th>
                </tr>
            </thead>
            <tbody id="point-history-tbody">
                <tr>
                    <td colspan="4" style="text-align: center; padding: 50px;">
                        포인트 내역을 불러오는 중...
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div class="pagination" id="point-pagination">
            <!-- 페이지네이션은 동적으로 생성 -->
        </div>
    </div>
</div>

<!-- 환불 신청 섹션 -->
<div class="content-section">
    <h3 class="section-title">포인트 환불</h3>
    <table class="info-table">
        <tr>
            <th>잔여 포인트</th>
            <td>
                <span class="point-large"><%=loginUser.userPoint()%>P</span>
                <button id="refund-request-btn" class="btn btn-secondary" style="float: right;" 
                onclick="location.assign('<%=request.getContextPath()%>/point/refundpoint.do')">
                <!-- 실행 -->
                    <i class="bi bi-cash-coin me-1"></i>환불 신청
                </button>
            </td>
        </tr>
    </table>
    <p class="mt-3 text-muted">※ 환불 시 잔여 포인트의 10%가 수수료로 차감됩니다.</p>
</div>

<script>
$(document).ready(function() {
    var currentPage = 1;
    var currentType = 'all';
    
    // 페이지 로드 시 포인트 내역 불러오기
    loadPointHistory();
    
    // 포인트 내역 탭 전환
    $('.tab-item').on('click', function() {
        $('.tab-item').removeClass('active');
        $(this).addClass('active');
        
        currentType = $(this).data('type');
        currentPage = 1;
        loadPointHistory();
    });
    
    // 검색 폼 제출
    $('#point-filter-form').on('submit', function(e) {
        e.preventDefault();
        currentPage = 1;
        loadPointHistory();
    });
    
    // 페이지네이션 클릭 이벤트 (동적 요소)
    $(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        currentPage = parseInt($(this).data('page'));
        loadPointHistory();
    });
    
    // 환불 신청 버튼
    $('#refund-request-btn').on('click', function() {
        var currentPoints = <%=loginUser.userPoint()%>;
        var refundAmount = Math.floor(currentPoints * 0.9); // 10% 수수료 차감
        
        if(currentPoints < 1000) {
            alert('환불 가능한 최소 포인트는 1,000P입니다.');
            return;
        }
        
        if(confirm('포인트 환불을 신청하시겠습니까?\n환불 예상 금액: ' + refundAmount + 'P (수수료 10% 차감)')) {
            $.ajax({
                url: '<%=request.getContextPath()%>/user/refundRequest.do',
                type: 'POST',
                data: {
                    requestAmount: currentPoints,
                    refundAmount: refundAmount
                },
                success: function(response) {
                    if(response.success) {
                        alert('환불 신청이 접수되었습니다.\n처리까지 최대 14일이 소요될 수 있습니다.');
                    } else {
                        alert('환불 신청에 실패했습니다: ' + response.message);
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        }
    });
});

// 포인트 내역 로드 함수
function loadPointHistory() {
    var formData = $('#point-filter-form').serialize();
    formData += '&pointType=' + currentType + '&page=' + currentPage;
    
    $('#point-history-tbody').html(`
        <tr>
            <td colspan="4" style="text-align: center; padding: 50px;">
                <div style="display: inline-block; width: 20px; height: 20px; border: 2px solid #f3f3f3; border-top: 2px solid var(--bs-blind-dark); border-radius: 50%; animation: spin 1s linear infinite; margin-right: 10px;"></div>
                불러오는 중...
            </td>
        </tr>
    `);
    
    $.ajax({
        url: '<%=request.getContextPath()%>/user/pointHistoryData.do',
        type: 'GET',
        data: formData,
        success: function(response) {
            if(response.success && response.data.length > 0) {
                var tbody = '';
                $.each(response.data, function(index, item) {
                    var pointClass = item.pointChange > 0 ? 'point-plus' : 'point-minus';
                    var pointText = item.pointChange > 0 ? '+' + item.pointChange + 'P' : item.pointChange + 'P';
                    
                    tbody += `
                        <tr>
                            <td>${item.createDate}</td>
                            <td style="text-align: left;">${item.content}</td>
                            <td class="${pointClass}">${pointText}</td>
                            <td>${item.remainingPoints}P</td>
                        </tr>
                    `;
                });
                $('#point-history-tbody').html(tbody);
                
                // 페이지네이션 생성
                createPagination(response.totalPages, currentPage);
            } else {
                $('#point-history-tbody').html(`
                    <tr>
                        <td colspan="4" style="text-align: center; padding: 50px; color: #888;">
                            포인트 내역이 없습니다.
                        </td>
                    </tr>
                `);
                $('#point-pagination').html('');
            }
        },
        error: function() {
            $('#point-history-tbody').html(`
                <tr>
                    <td colspan="4" style="text-align: center; padding: 50px; color: #dc3545;">
                        포인트 내역을 불러오는데 실패했습니다.
                        <br><button class="btn btn-sm btn-primary mt-2" onclick="loadPointHistory()">다시 시도</button>
                    </td>
                </tr>
            `);
        }
    });
}

// 페이지네이션 생성 함수
function createPagination(totalPages, currentPage) {
    if (totalPages <= 1) {
        $('#point-pagination').html('');
        return;
    }
    
    var pagination = '';
    var startPage = Math.max(1, currentPage - 2);
    var endPage = Math.min(totalPages, currentPage + 2);
    
    // 이전 페이지
    if (currentPage > 1) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="${currentPage - 1}">‹</a></div>`;
    }
    
    // 페이지 번호들
    for (var i = startPage; i <= endPage; i++) {
        var activeClass = i === currentPage ? 'active' : '';
        pagination += `<div class="page-item ${activeClass}"><a href="#" class="page-link" data-page="${i}">${i}</a></div>`;
    }
    
    // 다음 페이지
    if (currentPage < totalPages) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="${currentPage + 1}">›</a></div>`;
    }
    
    $('#point-pagination').html(pagination);
}
</script>