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
    
    .filter-section {
        background-color: #f8f9fa;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 30px;
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
    
    .material-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .material-card {
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s, box-shadow 0.2s;
    }
    
    .material-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
    }
    
    .material-img {
        height: 160px;
        background-color: #f0f0f0;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }
    
    .material-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .material-img .placeholder-icon {
        font-size: 48px;
        color: #ccc;
    }
    
    .download-badge {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: rgba(0, 0, 0, 0.7);
        color: white;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
    }
    
    .material-info {
        padding: 20px;
    }
    
    .material-title {
        font-weight: bold;
        margin-bottom: 8px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        height: 3em;
        line-height: 1.5;
    }
    
    .material-meta {
        font-size: 14px;
        color: #888;
        margin-bottom: 8px;
    }
    
    .material-price {
        font-weight: bold;
        color: var(--bs-blind-dark);
        font-size: 16px;
        margin-bottom: 15px;
    }
    
    .material-date {
        font-size: 12px;
        color: #aaa;
        margin-bottom: 10px;
    }
    
    .material-actions {
        display: flex;
        gap: 8px;
    }
    
    .material-actions .btn {
        flex: 1;
        padding: 8px 12px;
        font-size: 14px;
        border-radius: 6px;
        text-align: center;
        transition: all 0.2s;
    }
    
    .btn-download {
        background-color: var(--bs-blind-dark);
        color: white;
        border: none;
    }
    
    .btn-download:hover {
        background-color: var(--bs-blind-gray);
    }
    
    .btn-download:disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    
    .btn-review {
        background-color: #f8f9fa;
        color: #333;
        border: 1px solid #ddd;
    }
    
    .btn-review:hover {
        background-color: #e9ecef;
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
    
    @media (max-width: 768px) {
        .material-grid {
            grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        }
        
        .stats-summary {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 480px) {
        .material-grid {
            grid-template-columns: 1fr;
        }
        
        .stats-summary {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="content-header">
    <h2 class="content-title">구매한 학습자료</h2>
</div>

<!-- 통계 요약 -->
<div class="stats-summary" id="material-stats">
    <div class="stat-item">
        <div class="stat-number">0</div>
        <div class="stat-label">총 구매 자료</div>
    </div>
    <div class="stat-item">
        <div class="stat-number">0원</div>
        <div class="stat-label">총 구매 금액</div>
    </div>
    <div class="stat-item">
        <div class="stat-number">0</div>
        <div class="stat-label">다운로드 횟수</div>
    </div>
    <div class="stat-item">
        <div class="stat-number">0</div>
        <div class="stat-label">작성한 리뷰</div>
    </div>
</div>

<!-- 필터 섹션 -->
<div class="filter-section">
    <form id="material-filter-form">
        <div class="row">
            <div class="col-md-3 mb-3">
                <label class="form-label">카테고리</label>
                <select name="category" class="form-input">
                    <option value="">전체</option>
                    <option value="math">수학</option>
                    <option value="english">영어</option>
                    <option value="korean">국어</option>
                    <option value="science">과학</option>
                    <option value="social">사회</option>
                    <option value="etc">기타</option>
                </select>
            </div>
            <div class="col-md-3 mb-3">
                <label class="form-label">학습 단계</label>
                <select name="level" class="form-input">
                    <option value="">전체</option>
                    <option value="elementary">초등</option>
                    <option value="middle">중등</option>
                    <option value="high">고등</option>
                    <option value="general">일반</option>
                </select>
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">자료명 검색</label>
                <input type="text" name="keyword" class="form-input" placeholder="자료명을 검색하세요">
            </div>
            <div class="col-md-2 mb-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-search me-1"></i>검색
                </button>
            </div>
        </div>
    </form>
</div>

<!-- 자료 목록 -->
<div class="material-grid" id="material-list">
    <div style="grid-column: 1 / -1;">
        <div class="empty-state">
            <div style="display: inline-block; width: 40px; height: 40px; border: 4px solid #f3f3f3; border-top: 4px solid var(--bs-blind-dark); border-radius: 50%; animation: spin 1s linear infinite;"></div>
            <p style="margin-top: 20px;">구매한 학습자료를 불러오는 중...</p>
        </div>
    </div>
</div>

<!-- 페이지네이션 -->
<div class="pagination" id="material-pagination"></div>

<script>
$(document).ready(function() {
    var currentPage = 1;
    
    // 페이지 로드 시 데이터 불러오기
    loadMaterials();
    loadStats();
    
    // 필터 폼 제출
    $('#material-filter-form').on('submit', function(e) {
        e.preventDefault();
        currentPage = 1;
        loadMaterials();
    });
    
    // 페이지네이션 클릭
    $(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        currentPage = parseInt($(this).data('page'));
        loadMaterials();
    });
    
    // 다운로드 버튼 클릭
    $(document).on('click', '.btn-download', function(e) {
        e.preventDefault();
        var materialId = $(this).data('material-id');
        var $btn = $(this);
        
        if(confirm('이 자료를 다운로드하시겠습니까?')) {
            $btn.prop('disabled', true).text('다운로드 중...');
            
            $.ajax({
                url: '<%=request.getContextPath()%>/material/download.do',
                type: 'POST',
                data: { materialId: materialId },
                success: function(response) {
                    if(response.success) {
                        // 파일 다운로드 처리
                        window.location.href = response.downloadUrl;
                        
                        // 다운로드 횟수 업데이트
                        var currentCount = parseInt($btn.closest('.material-card').find('.download-badge').text().replace('다운로드 ', '').replace('회', ''));
                        $btn.closest('.material-card').find('.download-badge').text('다운로드 ' + (currentCount + 1) + '회');
                        
                        // 통계 업데이트
                        loadStats();
                    } else {
                        alert('다운로드에 실패했습니다: ' + response.message);
                    }
                },
                error: function() {
                    alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
                },
                complete: function() {
                    $btn.prop('disabled', false).text('다운로드');
                }
            });
        }
    });
    
    // 리뷰 작성 버튼 클릭
    $(document).on('click', '.btn-review', function(e) {
        e.preventDefault();
        var materialId = $(this).data('material-id');
        var materialTitle = $(this).data('material-title');
        
        // 리뷰 모달 또는 페이지로 이동
        openReviewModal(materialId, materialTitle);
    });
});

// 구매한 자료 목록 로드
function loadMaterials() {
    var formData = $('#material-filter-form').serialize();
    formData += '&page=' + currentPage;
    
    $('#material-list').html(`
        <div style="grid-column: 1 / -1;">
            <div class="empty-state">
                <div style="display: inline-block; width: 40px; height: 40px; border: 4px solid #f3f3f3; border-top: 4px solid var(--bs-blind-dark); border-radius: 50%; animation: spin 1s linear infinite;"></div>
                <p style="margin-top: 20px;">구매한 학습자료를 불러오는 중...</p>
            </div>
        </div>
    `);
    
    $.ajax({
        url: '<%=request.getContextPath()%>/user/purchasedMaterialsData.do',
        type: 'GET',
        data: formData,
        success: function(response) {
            if(response.success && response.data.length > 0) {
                var materials = '';
                
                $.each(response.data, function(index, material) {
                    materials += createMaterialCard(material);
                });
                
                $('#material-list').html(materials);
                createPagination(response.totalPages, currentPage);
            } else {
                showEmptyState();
            }
        },
        error: function() {
            $('#material-list').html(`
                <div style="grid-column: 1 / -1;">
                    <div class="empty-state">
                        <i class="bi bi-exclamation-triangle"></i>
                        <h3>오류 발생</h3>
                        <p>데이터를 불러오는데 실패했습니다.</p>
                        <button class="btn btn-primary" onclick="loadMaterials()">다시 시도</button>
                    </div>
                </div>
            `);
        }
    });
}

// 통계 데이터 로드
function loadStats() {
    $.ajax({
        url: '<%=request.getContextPath()%>/user/purchasedMaterialsStats.do',
        type: 'GET',
        success: function(response) {
            if(response.success) {
                $('#material-stats .stat-item').eq(0).find('.stat-number').text(response.totalCount || 0);
                $('#material-stats .stat-item').eq(1).find('.stat-number').text((response.totalAmount || 0).toLocaleString() + '원');
                $('#material-stats .stat-item').eq(2).find('.stat-number').text(response.totalDownloads || 0);
                $('#material-stats .stat-item').eq(3).find('.stat-number').text(response.totalReviews || 0);
            }
        }
    });
}

// 자료 카드 생성
function createMaterialCard(material) {
    var imageContent = material.thumbnail ? 
        `<img src="\${material.thumbnail}" alt="\${material.title}">` : 
        `<i class="bi bi-file-earmark-text placeholder-icon"></i>`;
    
    var downloadBtnClass = material.downloadCount >= material.maxDownload ? 'disabled' : '';
    var downloadBtnText = material.downloadCount >= material.maxDownload ? '다운로드 완료' : '다운로드';
    
    return `
        <div class="material-card">
            <div class="material-img">
                \${imageContent}
                <div class="download-badge">다운로드 \${material.downloadCount}회</div>
            </div>
            <div class="material-info">
                <div class="material-title">\${material.title}</div>
                <div class="material-meta">\${material.category} > \${material.level} | \${material.author}</div>
                <div class="material-price">\${material.price.toLocaleString()}원</div>
                <div class="material-date">구매일: \${material.purchaseDate}</div>
                <div class="material-actions">
                    <button class="btn btn-download \${downloadBtnClass}" 
                            data-material-id="\${material.id}" 
                            ${material.downloadCount >= material.maxDownload ? 'disabled' : ''}>
                        <i class="bi bi-download me-1"></i>${downloadBtnText}
                    </button>
                    <button class="btn btn-review" 
                            data-material-id="\${material.id}" 
                            data-material-title="\${material.title}">
                        <i class="bi bi-star me-1"></i>리뷰작성
                    </button>
                </div>
            </div>
        </div>
    `;
}

// 빈 상태 표시
function showEmptyState() {
    $('#material-list').html(`
        <div style="grid-column: 1 / -1;">
            <div class="empty-state">
                <i class="bi bi-folder-x"></i>
                <h3>구매한 학습자료가 없습니다</h3>
                <p>아직 구매한 학습자료가 없습니다.<br>다양한 학습자료를 둘러보세요!</p>
                <a href="<%=request.getContextPath()%>/material/list.do" class="btn btn-primary">
                    <i class="bi bi-search me-1"></i>학습자료 둘러보기
                </a>
            </div>
        </div>
    `);
    $('#material-pagination').html('');
}

// 페이지네이션 생성
function createPagination(totalPages, currentPage) {
    if(totalPages <= 1) {
        $('#material-pagination').html('');
        return;
    }
    
    var pagination = '';
    var startPage = Math.max(1, currentPage - 2);
    var endPage = Math.min(totalPages, currentPage + 2);
    
    if(currentPage > 1) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="\${currentPage - 1}">‹</a></div>`;
    }
    
    for(var i = startPage; i <= endPage; i++) {
        var activeClass = i === currentPage ? 'active' : '';
        pagination += `<div class="page-item \${activeClass}"><a href="#" class="page-link" data-page="\${i}">${i}</a></div>`;
    }
    
    if(currentPage < totalPages) {
        pagination += `<div class="page-item"><a href="#" class="page-link" data-page="\${currentPage + 1}">›</a></div>`;
    }
    
    $('#material-pagination').html(pagination);
}

// 리뷰 모달 열기
function openReviewModal(materialId, materialTitle) {
    // 실제 구현시에는 모달을 만들거나 별도 페이지로 이동
    alert('리뷰 작성 기능은 준비 중입니다.\n자료: ' + materialTitle);
}
</script>