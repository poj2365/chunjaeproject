<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User"%>

<%
User loginUser= (User)session.getAttribute("loginUser");
if (loginUser == null) {
	response.sendRedirect(request.getContextPath() + "/user/loginview.do");
	return;
}
%>

<style>
    .mypage-container {
        max-width: 1400px;
        margin: 30px auto;
        display: flex;
        gap: 30px;
        padding: 0 20px;
    }

    .sidebar {
        width: 260px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px 0;
        flex-shrink: 0;
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
        display: flex;
        justify-content: center;
        align-items: center;
        border: 3px solid var(--bs-primary-light);
    }

    .user-id {
        font-weight: bold;
        margin-bottom: 5px;
        font-size: 18px;
        color: #333;
    }

    .user-name, .point-info {
        color: #666;
        margin-bottom: 10px;
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
        transition: 0.2s;
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .menu-item:hover,
    .menu-item.active {
        background-color: var(--bs-primary-light);
        color: var(--bs-blind-dark);
    }

    .menu-item.active {
        border-left: 3px solid var(--bs-blind-dark);
        font-weight: bold;
    }

    .main-content {
        flex: 1;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 30px;
        min-height: 450px;
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

    .content-section {
        margin-bottom: 30px;
    }

    .section-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 15px;
        color: #444;
    }

    .info-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
        table-layout: fixed;
    }

    .info-table th,
    .info-table td {
        padding: 20px;
        text-align: left;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }

    .info-table th {
        width: 200px;
        background-color: var(--bs-primary-light);
        font-weight: 600;
        color: #444;
    }

    .form-input {
        width: 100%;
        padding: 15px 18px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        transition: 0.2s;
        box-sizing: border-box;
    }

    .form-input:focus {
        border-color: var(--bs-blind-dark);
        box-shadow: 0 0 0 3px rgba(36, 177, 181, 0.2);
        outline: none;
    }

    .form-input::placeholder {
        color: #ccc;
    }

    .form-input:disabled {
        background-color: #f5f6f7;
        cursor: not-allowed;
    }

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
    td {
	  color: #222 !important;
	  background: #fff !important;
	  font-size: 18px !important;
	}
</style>

 <h2 class="content-title">포인트 내역 조회</h2>

<div class="content-section">
    <h3 class="section-title">보유 포인트 <span class="badge"><%=loginUser.userPoint()%>P</span></h3>
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
                    <button type="submit" class="btn btn-primary w-100" >
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
               <i class="bi bi-cash-coin me-1"></i>환불 신청
                </button>
            </td>
        </tr>
    </table>
    <p class="mt-3 text-muted">※ 환불 시 잔여 포인트의 10%가 수수료로 차감됩니다.</p>
	</div>

<script>
$(document).ready(() => {
    let allPointHistory = []; // 배열을 생성
    $.get("<%=request.getContextPath()%>/point/pointhistory.do?userId=<%=loginUser.userId()%>")
    .done(data => {
        console.log(data);
        allPointHistory = data; // 가지고 온 리스트를 저장 
        displayPointHistory(allPointHistory); // 처음엔 전체 보여줌
    })
    .fail(error => {
        $('#point-history-tbody').html(`<tr>
            <td colspan="4" style="text-align: center; padding: 50px;">데이터를 불러올 수 없습니다.</td>
        </tr>`);
        console.log(error);
    });
      
    
    $('.tab-item').on('click', function() {
        $('.tab-item').removeClass('active');
        $(this).addClass('active');
        const type = $(this).data('type'); 
        filterPointHistory(type);
    });

    // 필터링 함수
    function filterPointHistory(type) {
        let filteredData = [];
        if (type === 'all') {
            filteredData = allPointHistory;
        } else if (type === 'plus') {
            filteredData = allPointHistory.filter(row => (parseInt(row.changePoint) || 0) > 0);
        } else if (type === 'minus') {
            filteredData = allPointHistory.filter(row => (parseInt(row.changePoint) || 0) < 0);
        }
        displayPointHistory(filteredData);
    }

    // 표 그리기 함수
    function displayPointHistory(data) {
        const pointHistory = document.getElementById('point-history-tbody');
        pointHistory.innerHTML = '';
        if (data.length === 0) {
            pointHistory.innerHTML = `<tr><td colspan="4" style="text-align: center; padding: 50px;">데이터가 없습니다.</td></tr>`;
        } else {
            data.forEach(row => {
                const tr = document.createElement('tr');
                const tdDate = document.createElement('td');
                tdDate.textContent = row["date"];
                const tdContent = document.createElement('td');
                tdContent.textContent = row["content"];
                const tdChangePoint = document.createElement('td');
                tdChangePoint.style.textAlign = 'right';
                
                const changePoint = parseInt(row["changePoint"]) || 0;
                if (changePoint > 0) {
                    tdChangePoint.style.color = '#28a745'; 
                    tdChangePoint.textContent = '+' + changePoint + 'P';
                } else if (changePoint < 0) {
                    tdChangePoint.style.color = '#dc3545'; 
                    tdChangePoint.textContent = changePoint + 'P';
                } else {
                    tdChangePoint.textContent = changePoint + 'P';
                }
                
                const tdMyPoint = document.createElement('td');
                tdMyPoint.style.textAlign = 'right';
                tdMyPoint.textContent = row["myPoint"] + 'P';
                tr.appendChild(tdDate);
                tr.appendChild(tdContent);
                tr.appendChild(tdChangePoint);
                tr.appendChild(tdMyPoint);
                pointHistory.appendChild(tr); 
            });
        }
    }

    // 날짜 필터링 기능 - 수정된 부분
    $('#point-filter-form').on('submit', function(e) {
        e.preventDefault();
        const startDate = $('#start-date').val();
        const endDate = $('#end-date').val();
        const pointType = $('#point-type').val();
        
        let filteredData = allPointHistory;
        
        // 날짜 필터링
        if (startDate || endDate) {
            filteredData = filteredData.filter(row => {
                const rowDate = new Date(row.date);
                let isInRange = true;
                
                if (startDate) {
                    const start = new Date(startDate);
                    isInRange = isInRange && rowDate >= start;
                }
                
                if (endDate) {
                    const end = new Date(endDate);
                    end.setHours(23, 59, 59, 999); // 종료일 하루 끝까지 포함
                    isInRange = isInRange && rowDate <= end;
                }
                
                return isInRange;
            });
        }
        
        // 포인트 타입 필터링
        if (pointType !== 'all') {
            if (pointType === 'plus') {
                filteredData = filteredData.filter(row => (parseInt(row.changePoint) || 0) > 0);
            } else if (pointType === 'minus') {
                filteredData = filteredData.filter(row => (parseInt(row.changePoint) || 0) < 0);
            }
        }
        
        // 탭 상태 업데이트
        $('.tab-item').removeClass('active');
        $(`.tab-item[data-type="${pointType}"]`).addClass('active');
        
        displayPointHistory(filteredData);
    });
    
    // 날짜 필터 초기화 기능 (선택사항)
    function resetDateFilter() {
        $('#start-date').val('');
        $('#end-date').val('');
        $('#point-type').val('all');
        $('.tab-item').removeClass('active');
        $('.tab-item[data-type="all"]').addClass('active');
        displayPointHistory(allPointHistory);
    }
    
    // 초기화 버튼이 있다면 이벤트 연결 (HTML에 버튼이 있을 경우)
    $('#reset-filter-btn').on('click', function() {
        resetDateFilter();
    });
});
</script>