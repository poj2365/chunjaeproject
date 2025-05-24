<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    
    .tabs {
        display: flex;
        border-bottom: 1px solid #eee;
        margin-bottom: 30px;
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
    
    .sales-content {
        display: none;
    }
    
    .sales-content.active {
        display: block;
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
    
    .sales-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
    }
    
    .sales-table th,
    .sales-table td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #eee;
    }
    
    .sales-table th {
        background-color: var(--bs-primary-light);
        font-weight: bold;
        color: #444;
    }
    
    .sales-table td:nth-child(2) {
        text-align: left;
        max-width: 250px;
    }
    
    .status-badge {
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 12px;
        font-weight: bold;
        white-space: nowrap;
    }
    
    .status-pending {
        background-color: #fff8e1;
        color: #ffc107;
    }
    
    .status-processing {
        background-color: #e3f2fd;  
        color: #2196f3;
    }
    
    .status-completed {
        background-color: #e8f5e9;
        color: #4caf50;
    }
    
    .status-selling {
        background-color: #e8f5e9;
        color: #4caf50;
    }
    
    .status-stopped {
        background-color: #ffebee;
        color: #f44336;
    }
    
    .status-rejected {
        background-color: #ffebee;
        color: #f44336;
    }
    
    .settlement-summary {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
        margin-top: 20px;
        border: 1px solid #e9ecef;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .settlement-amount {
        font-size: 20px;
        font-weight: bold;
    }
    
    .settlement-amount span {
        color: var(--bs-blind-dark);
        font-size: 24px;
    }
    
    .custom-checkbox {
        width: 18px;
        height: 18px;
        cursor: pointer;
        accent-color: var(--bs-blind-dark);
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 30px;
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
    
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        justify-content: center;
        align-items: center;
    }
    
    .modal-container {
        background-color: white;
        border-radius: 12px;
        width: 90%;
        max-width: 600px;
        max-height: 80vh;
        overflow-y: auto;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
    }
    
    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
        border-bottom: 1px solid #eee;
    }
    
    .modal-title {
        font-size: 20px;
        font-weight: bold;
        color: #333;
    }
    
    .modal-close {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        color: #888;
    }
    
    .modal-body {
        padding: 20px;
        color: #333;
        line-height: 1.6;
    }
    
    .modal-body h4 {
        margin-top: 20px;
        margin-bottom: 10px;
        color: var(--bs-blind-dark);
    }
    
    .modal-body h4:first-child {
        margin-top: 0;
    }
    
    .modal-footer {
        padding: 20px;
        border-top: 1px solid #eee;
        text-align: right;
    }
    
    .btn-action {
        padding: 6px 12px;
        font-size: 14px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        transition: all 0.2s;
        min-width: 80px;
    }
    
    .btn-danger {
        background-color: #dc3545;
        color: white;
    }
    
    .btn-danger:hover {
        background-color: #c82333;
    }
    
    .btn-success {
        background-color: #28a745;
        color: white;
    }
    
    .btn-success:hover {
        background-color: #218838;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #888;
    }
    
    .empty-state i {
        font-size: 48px;
        margin-bottom: 20px;
        color: #ddd;
    }
    
    @media (max-width: 768px) {
        .sales-table {
            font-size: 14px;
        }
        
        .sales-table th,
        .sales-table td {
            padding: 10px;
        }
        
        .settlement-summary {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
    }
</style>

<div class="content-header">
    <h2 class="content-title">학습자료 판매 관리</h2>
    <a href="<%=request.getContextPath()%>/material/uploadForm.do" class="btn btn-primary">
        <i class="bi bi-plus-circle me-1"></i>새 자료 등록
    </a>
</div>

<!-- 탭 메뉴 -->
<div class="tabs">
    <div class="tab-item active" data-sales-tab="settlement">정산 확인</div>
    <div class="tab-item" data-sales-tab="status">판매 현황</div>
</div>

<!-- 정산 확인 탭 -->
<div class="sales-content active" id="settlement-content">
    <!-- 검색 필터 -->
    <form id="settlement-search-form">
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <label class="form-label">시작일</label>
                <input type="date" name="startDate" class="form-input">
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">종료일</label>
                <input type="date" name="endDate" class="form-input">
            </div>
            <div class="col-md-4 mb-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-search me-1"></i>검색
                </button>
            </div>
        </div>
    </form>
    
    <div style="display: flex; justify-content: space-between; margin-bottom: 15px;">
        <button class="btn btn-secondary btn-sm" id="show-policy-btn">
            <i class="bi bi-file-text me-1"></i>정산/판매 관련 규정 보기
        </button>
        <div>
            <label class="me-2">
                <input type="checkbox" id="select-all-settlements">
                전체선택
            </label>
        </div>
    </div>
    
    <div id="settlement-table-container">
        <table class="sales-table">
            <thead>
                <tr>
                    <th style="width: 5%;">선택</th>
                    <th style="width: 15%;">정산상태</th>
                    <th style="width: 20%;">판매일</th>
                    <th style="width: 40%;">자료명</th>
                    <th style="width: 20%;">가격</th>
                </tr>
            </thead>
            <tbody id="settlement-tbody">
                <tr>
                    <td colspan="5" style="padding: 50px;">
                        정산 내역을 불러오는 중...
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div class="settlement-summary">
            <div class="settlement-amount">
                정산 요청 금액: <span id="total-settlement-amount">0원</span>
            </div>
            <button class="btn btn-primary" id="request-settlement-btn">
                <i class="bi bi-cash-coin me-1"></i>정산 요청하기
            </button>
        </div>
    </div>
    
    <div class="pagination" id="settlement-pagination"></div>
</div>

<!-- 판매 현황 탭 -->
<div class="sales-content" id="status-content">
    <!-- 검색 필터 -->
    <form id="sales-search-form">
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <label class="form-label">판매상태</label>
                <select name="status" class="form-input">
                    <option value="">전체</option>
                    <option value="selling">판매중</option>
                    <option value="stopped">판매중지</option>
                    <option value="pending">승인대기</option>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">자료명</label>
                <input type="text" name="keyword" class="form-input" placeholder="자료명 검색">
            </div>
            <div class="col-md-3 mb-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-search me-1"></i>검색
                </button>
            </div>
        </div>
    </form>
    
    <div id="sales-table-container">
        <table class="sales-table">
            <thead>
                <tr>
                    <th style="width: 15%;">판매상태</th>
                    <th style="width: 30%;">자료명</th>
                    <th style="width: 15%;">등록일</th>
                    <th style="width: 10%;">구매자수</th>
                    <th style="width: 15%;">가격</th>
                    <th style="width: 15%;">관리</th>
                </tr>
            </thead>
            <tbody id="sales-tbody">
                <tr>
                    <td colspan="6" style="padding: 50px;">
                        판매 현황을 불러오는 중...
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div class="pagination" id="sales-pagination"></div>
</div>

<!-- 정산/판매 관련 규정 모달 -->
<div class="modal-overlay" id="policy-modal">
    <div class="modal-container">
        <div class="modal-header">
            <h3 class="modal-title">정산/판매 관련 규정</h3>
            <button class="modal-close">&times;</button>
        </div>
        <div class="modal-body">
            <h4>1. 정산 규정</h4>
            <p>1.1 판매 수수료는 판매 금액의 20%입니다.</p>
            <p>1.2 정산 요청은 판매 금액이 10,000원 이상일 때 가능합니다.</p>
            <p>1.3 정산 요청 후 처리 기간은 3-5영업일입니다.</p>
            <p>1.4 정산 금액은 등록된 계좌로 입금됩니다.</p>
            
            <h4>2. 판매 규정</h4>
            <p>2.1 모든 학습자료는 심사를 거쳐 승인된 후 판매가 가능합니다.</p>
            <p>2.2 심사 기간은 2-3영업일이 소요됩니다.</p>
            <p>2.3 저작권에 문제가 있는 자료는 판매가 불가합니다.</p>
            <p>2.4 판매자는 등록한 자료에 대한 모든 법적 책임을 가집니다.</p>
            
            <h4>3. 환불 규정</h4>
            <p>3.1 구매자가 자료를 다운로드하기 전에는 100% 환불 가능합니다.</p>
            <p>3.2 자료 다운로드 후에는 원칙적으로 환불이 불가능합니다.</p>
            <p>3.3 자료에 심각한 오류가 있을 경우, 구매일로부터 7일 이내에 환불 요청이 가능합니다.</p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary close-modal-btn">확인</button>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    var currentSettlementPage = 1;
    var currentSalesPage = 1;
    
    // 첫 번째 탭 로드
    loadSettlementData();
    
    // 탭 전환
    $('.tab-item').on('click', function() {
        var $this = $(this);
        var tabId = $this.data('sales-tab');
        
        $('.tab-item').removeClass('active');
        $this.addClass('active');
        
        $('.sales-content').removeClass('active');
        $('#' + tabId + '-content').addClass('active');
        
        // 해당 탭 데이터 로드
        if(tabId === 'settlement') {
            if(!$('#settlement-tbody').data('loaded')) {
                loadSettlementData();
            }
        } else if(tabId === 'status') {
            if(!$('#sales-tbody').data('loaded')) {
                loadSalesStatusData();
            }
        }
    });
    
    // 검색 폼 제출
    $('#settlement-search-form').on('submit', function(e) {
        e.preventDefault();
        currentSettlementPage = 1;
        loadSettlementData();
    });
    
    $('#sales-search-form').on('submit', function(e) {
        e.preventDefault();
        currentSalesPage = 1;
        loadSalesStatusData();
    });
    
    // 페이지네이션 클릭
    $(document).on('click', '#settlement-pagination .page-link', function(e) {
        e.preventDefault();
        currentSettlementPage = parseInt($(this).data('page'));
        loadSettlementData();
    });
    
    $(document).on('click', '#sales-pagination .page-link', function(e) {
        e.preventDefault();
        currentSalesPage = parseInt($(this).data('page'));
        loadSalesStatusData();
    });
    
    // 체크박스 이벤트
    $(document).on('change', '#select-all-settlements', function() {
        $('.settlement-checkbox:not(:disabled)').prop('checked', $(this).prop('checked'));
        updateTotalAmount();
    });
    
    $(document).on('change', '.settlement-checkbox', function() {
        updateTotalAmount();
    });
    
    // 정산 요청 버튼
    $('#request-settlement-btn').on('click', function() {
        var selectedCount = $('.settlement-checkbox:checked').length;
        
        if(selectedCount === 0) {
            alert('정산 요청할 항목을 선택해주세요.');
            return;
        }
        
        var selectedIds = [];
        $('.settlement-checkbox:checked').each(function() {
            selectedIds.push($(this).data('settlement-id'));
        });
        
        if(confirm('선택한 ' + selectedCount + '개 항목에 대해 정산을 요청하시겠습니까?')) {
            $.ajax({
                url: '<%=request.getContextPath()%>/user/processSettlement.do',
                type: 'POST',
                data: { settlementIds: selectedIds },
                success: function(response) {
                    if(response.success) {
                        alert('정산 요청이 완료되었습니다.\n처리까지 3-5영업일이 소요됩니다.');
                        loadSettlementData(); // 데이터 새로고침
                    } else {
                        alert('정산 요청에 실패했습니다: ' + response.message);
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        }
    });
    
    // 판매 상태 변경 버튼
    $(document).on('click', '.btn-toggle-sales', function() {
        var materialId = $(this).data('material-id');
        var currentStatus = $(this).data('current-status');
        var newStatus = currentStatus === 'selling' ? 'stopped' : 'selling';
        var actionText = newStatus === 'selling' ? '판매 재개' : '판매 중지';
        
        if(confirm(actionText + '하시겠습니까?')) {
            $.ajax({
                url: '<%=request.getContextPath()%>/material/toggleStatus.do',
                type: 'POST',
                data: { 
                    materialId: materialId,
                    status: newStatus 
                },
                success: function(response) {
                    if(response.success) {
                        alert(actionText + '되었습니다.');
                        loadSalesStatusData(); // 데이터 새로고침
                    } else {
                        alert(actionText + '에 실패했습니다: ' + response.message);
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        }
    });
    
    // 모달 이벤트
    $('#show-policy-btn').on('click', function() {
        $('#policy-modal').css('display', 'flex');
    });
    
    $('.close-modal-btn, .modal-close').on('click', function() {
        $('#policy-modal').css('display', 'none');
    });
    
    $('#policy-modal').on('click', function(e) {
        if(e.target === this) {
            $(this).css('display', 'none');
        }
    });
});

// 정산 데이터 로드
function loadSettlementData() {
    var formData = $('#settlement-search-form').serialize();
    formData += '&page=' + currentSettlementPage;
    
    $('#settlement-tbody').html(`
        <tr>
            <td colspan="5" style="padding: 50px;">
                <div style="display: inline-block; width: 20px; height: 20px; border: 2px solid #f3f3f3; border-top: 2px solid var(--bs-blind-dark); border-radius: 50%; animation: spin 1s linear infinite; margin-right: 10px;"></div>
                정산 내역을 불러오는 중...
            </td>
        </tr>
    `);
    
    $.ajax({
        url: '<%=request.getContextPath()%>/user/settlementData.do',
        type: 'GET',
        data: formData,
        success: function(response) {
            if(response.success && response.data.length > 0) {
                var tbody = '';
                $.each(response.data, function(index, item) {
                    var disabled = item.status !== 'pending' ? 'disabled' : '';
                    var statusClass = 'status-' + item.status;
                    var statusText = getStatusText(item.status);
                    
                    tbody += `
                        <tr>
                            <td><input type="checkbox" class="custom-checkbox settlement-checkbox" 
                                      data-settlement-id="${item.id}" 
                                      data-amount="${item.amount}" ${disabled}></td>
                            <td><span class="status-badge ${statusClass}">${statusText}</span></td>
                            <td>${item.saleDate}</td>
                            <td style="text-align: left;">${item.materialTitle}</td>
                            <td>${item.amount.toLocaleString()}원</td>
                        </tr>
                    `;
                });
                $('#settlement-tbody').html(tbody);
                createPagination(response.totalPages, currentSettlementPage, '#settlement-pagination');
            } else {
                showEmptySettlement();
            }
            $('#settlement-tbody').data('loaded', true);
        },
        error: function() {
            $('#settlement-tbody').html(`
                <tr>
                    <td colspan="5" style="padding: 50px; color: #dc3545;">
                        정산 내역을 불러오는데 실패했습니다.
                        <br><button class="btn btn-sm btn-primary mt-2" onclick="loadSettlementData()">다시 시도</button>
                    </td>
                </tr>
            `);
        }
    });
}

// 판매 현황 데이터 로드
function loadSalesStatusData() {
    var formData = $('#sales-search-form').serialize();
    formData += '&page=' + currentSalesPage;
    
    $('#sales-tbody').html(`
        <tr>
            <td colspan="6" style="padding: 50px;">
                <div style="display: inline-block; width: 20px; height: 20px; border: 2px solid #f3f3f3; border-top: 2px solid var(--bs-blind-dark); border-radius: 50%; animation: spin 1s linear infinite; margin-right: 10px;"></div>
                판매 현황을 불러오는 중...
            </td>
        </tr>
    `);
    
    $.ajax({
        url: '<%=request.getContextPath()%>/user/salesStatusData.do',
        type: 'GET',
        data: formData,
        success: function(response) {
            if(response.success && response.data.length > 0) {
                var tbody = '';
                $.each(response.data, function(index, item) {
                    var statusClass = 'status-' + item.status;
                    var statusText = getStatusText(item.status);
                    var btnClass = item.status === 'selling' ? 'btn-danger' : 'btn-success';
                    var btnText = item.status === 'selling' ? '판매중지' : '판매재개';
                    
                    tbody += `
                        <tr>
                            <td><span class="status-badge ${statusClass}">${statusText}</span></td>
                            <td style="text-align: left;">${item.title}</td>
                            <td>${item.registerDate}</td>
                            <td>${item.buyerCount}명</td>
                            <td>${item.price.toLocaleString()}원</td>
                            <td>
                                <button class="btn-action ${btnClass} btn-toggle-sales" 
                                        data-material-id="${item.id}" 
                                        data-current-status="${item.status}">
                                    ${btnText}
                                </button>
                            </td>
                        </tr>
                    `;
                });
                $('#sales-tbody').html(tbody);
                createPagination(response.totalPages, currentSalesPage, '#sales-pagination');
            } else {
                showEmptySales();
            }
            $('#sales-tbody').data('loaded', true);
        },
        error: function() {
            $('#sales-tbody').html(`
                <tr>
                    <td colspan="6" style="padding: 50px; color: #dc3545;">
                        판매 현황을 불러오는데 실패했습니다.
                        <br><button class="btn btn-sm btn-primary mt-2" onclick="loadSalesStatusData()">다시 시도</button>
                    </td>
                </tr>
            `);
        }
    });
}

// 정산 금액 업데이트
function updateTotalAmount() {
    var total = 0;
    $('.settlement-checkbox:checked').each(function() {
        total += parseInt($(this).data('amount')) || 0;
    });
    $('#total-settlement-amount').text(total.toLocaleString() + '원');
}

// 상태 텍스트 반환
function getStatusText(status) {
    var statusMap = {
        'pending': '정산대기',
        'processing': '처리중',
        'completed': '정산완료',
        'rejected': '반려',
        'selling': '판매중',
        'stopped': '판매중지'
    };
    return statusMap[status] || status;
}

// 빈 정산 내역 표시
function showEmptySettlement() {
    $('#settlement-tbody').html(`
        <tr>
            <td colspan="5">
                <div class="empty-state">
                    <i class="bi bi-receipt"></i>
                    <h4>정산 내역이 없습니다</h4>
                    <p>아직 정산할 판매 내역이 없습니다.</p>
                </div>
            </td>
        </tr>
    `);
    $('#settlement-pagination').html('');
}

// 빈 판매 현황 표시
function showEmptySales() {
    $('#sales-tbody').html(`
        <tr>
            <td colspan="6">
                <div class="empty-state">
                    <i class="bi bi-shop"></i>
                    <h4>판매 중인 자료가 없습니다</h4>
                    <p>새로운 학습자료를 등록해보세요!</p>
                    <a href="<%=request.getContextPath()%>/material/uploadForm.do" class="btn btn-primary mt-2">
                        <i class="bi bi-plus-circle me-1"></i>자료 등록하기
                    </a>
                </div>
            </td>
        </tr>
    `);
    $('#sales-pagination').html('');
}

// 페이지네이션 생성
function createPagination(totalPages, currentPage, selector) {
    if(totalPages <= 1) {
        $(selector).html('');
        return;
    }
    
    var pagination = '';
    var startPage = Math.max(1, currentPage - 2);
    var endPage = Math.min(totalPages, currentPage + 2);
    
    if(currentPage > 1) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="${currentPage - 1}">‹</a></div>`;
    }
    
    for(var i = startPage; i <= endPage; i++) {
        var activeClass = i === currentPage ? 'active' : '';
        pagination += `<div class="page-item ${activeClass}"><a href="#" class="page-link" data-page="${i}">${i}</a></div>`;
    }
    
    if(currentPage < totalPages) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="${currentPage + 1}">›</a></div>`;
    }
    
    $(selector).html(pagination);
}
</script>