<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.niw.user.model.dto.User" %>
<%@ page import="com.niw.market.model.dto.Material" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
    // 초기 필터 파라미터들
    String schoolLevel = request.getParameter("schoolLevel");
    String grade = request.getParameter("grade");
    String subject = request.getParameter("subject");
    String sortBy = request.getParameter("sortBy");
    String keyword = request.getParameter("keyword");
    
    // null 처리
    schoolLevel = (schoolLevel != null) ? schoolLevel : "";
    grade = (grade != null) ? grade : "";
    subject = (subject != null) ? subject : "";
    sortBy = (sortBy != null) ? sortBy : "popular";
    keyword = (keyword != null) ? keyword : "";
%>



<style>
    /* 기존 CSS 스타일들 유지 */
    .main-content {
        flex: 1;
        padding: 2rem 0;
    }

    .page-header {
        background: linear-gradient(135deg, var(--bs-blind-dark), var(--bs-blind-light-gray));
        color: white;
        padding: 3rem 0;
        margin-bottom: 2rem;
    }

    .page-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
    }

    .page-subtitle {
        font-size: 1.1rem;
        opacity: 0.9;
    }

    /* 필터 및 정렬 */
    .filter-section {
        background: white;
        padding: 1.5rem;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 2rem;
    }

    .filter-section .form-label {
        color: #495057;
        font-size: 0.85rem;
        margin-bottom: 0.3rem;
    }

    .filter-section .form-select {
        border: 1px solid #dee2e6;
        border-radius: 6px;
        font-size: 0.9rem;
        transition: all 0.2s;
    }

    .filter-section .form-select:focus {
        border-color: var(--bs-blind-dark);
        box-shadow: 0 0 0 0.2rem rgba(36, 177, 181, 0.25);
    }

    /* 탭 버튼 스타일 */
    .tab-btn {
        background-color: #f8f9fa;
        border: 2px solid #dee2e6;
        color: #495057;
        border-radius: 25px;
        padding: 0.6rem 1.2rem;
        font-weight: 500;
        font-size: 0.9rem;
        transition: all 0.3s;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }

    .tab-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        border-color: var(--bs-blind-dark);
        color: white;
        background: linear-gradient(45deg, var(--bs-blind-dark), var(--bs-blind-light-gray));
        text-decoration: none;
    }

    .tab-btn.active {
        background: linear-gradient(45deg, var(--bs-blind-dark), var(--bs-blind-light-gray));
        border-color: var(--bs-blind-dark);
        color: white;
        transform: translateY(-1px);
        box-shadow: 0 4px 15px rgba(36, 177, 181, 0.3);
    }

    /* 필터 버튼 스타일 */
    .filter-btn {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        color: #495057;
        border-radius: 20px;
        padding: 0.5rem 1rem;
        font-size: 0.85rem;
        font-weight: 500;
        transition: all 0.2s;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }

    .filter-btn:hover {
        background-color: var(--bs-blind-light-gray);
        border-color: var(--bs-blind-light-gray);
        color: white;
        transform: translateY(-1px);
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        text-decoration: none;
    }

    .filter-btn.active {
        background-color: var(--bs-blind-dark);
        border-color: var(--bs-blind-dark);
        color: white;
        box-shadow: 0 2px 8px rgba(36, 177, 181, 0.2);
    }

    /* 학년 버튼 스타일 */
    .grade-btn {
        background-color: #fff3e0;
        border: 1px solid #ffb74d;
        color: #ef6c00;
        border-radius: 50%;
        width: 50px;
        height: 50px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 0.9rem;
        transition: all 0.2s;
        cursor: pointer;
        text-decoration: none;
    }

    .grade-btn:hover {
        background-color: #ffb74d;
        color: white;
        transform: scale(1.05);
        box-shadow: 0 3px 10px rgba(255, 183, 77, 0.3);
        text-decoration: none;
    }

    .grade-btn.active {
        background-color: var(--bs-accent);
        border-color: var(--bs-accent);
        color: white;
        transform: scale(1.05);
        box-shadow: 0 3px 12px rgba(255, 125, 77, 0.4);
    }

    /* 자료 카드 스타일 */
    .material-card {
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        overflow: hidden;
        margin-bottom: 2rem;
        position: relative;
    }

    .material-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }

    .card-image {
        height: 200px;
        position: relative;
        overflow: hidden;
        background-color: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .preview-page-card {
        width: 90%;
        height: 85%;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        padding: 15px;
        font-size: 0.8rem;
        line-height: 1.3;
        color: #333;
        overflow: hidden;
        position: relative;
    }

    .preview-page-card h4 {
        font-size: 1rem;
        font-weight: 700;
        margin-bottom: 10px;
        color: #2d3436;
        text-align: center;
        border-bottom: 2px solid #ddd;
        padding-bottom: 5px;
    }

    .preview-page-card .content {
        font-size: 0.75rem;
        line-height: 1.4;
    }

    .card-badge {
        position: absolute;
        top: 15px;
        left: 15px;
        background-color: var(--bs-accent);
        color: white;
        padding: 0.3rem 0.8rem;
        border-radius: 15px;
        font-size: 0.8rem;
        font-weight: 600;
        z-index: 10;
    }

    .card-price {
        position: absolute;
        top: 15px;
        right: 15px;
        background-color: rgba(0,0,0,0.7);
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-weight: 700;
        z-index: 10;
    }

    .card-content {
        padding: 1.5rem;
    }

    .card-title {
        font-size: 1.3rem;
        font-weight: 700;
        margin-bottom: 0.8rem;
        color: #2d3436;
    }

    .card-description {
        color: #636e72;
        margin-bottom: 1rem;
        line-height: 1.6;
    }

    .card-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1rem;
        font-size: 0.9rem;
        color: #74b9ff;
    }

    .card-stats {
        display: flex;
        gap: 0.8rem;
        margin-bottom: 1rem;
        flex-wrap: wrap;
    }

    .stat-item {
        display: flex;
        align-items: center;
        gap: 0.3rem;
        font-size: 0.85rem;
        color: #636e72;
        padding: 0.2rem 0.5rem;
        background-color: #f8f9fa;
        border-radius: 12px;
        font-weight: 500;
    }

    .stat-item i {
        font-size: 0.9rem;
    }

    /* 카드 추가 정보 */
    .card-extra-info {
        border-top: 1px solid #f0f0f0;
        padding-top: 1rem;
    }

    .material-tags .badge {
        margin-right: 0.3rem;
        font-size: 0.75rem;
        border: 1px solid #dee2e6;
    }

    .popularity-score i {
        font-size: 1.2rem;
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }

    /* 배지 색상 */
    .card-badge.bg-danger {
        background-color: #dc3545 !important;
    }

    .card-badge.bg-warning {
        background-color: #ffc107 !important;
        color: #212529 !important;
    }

    .card-badge.bg-success {
        background-color: #28a745 !important;
    }

    .card-badge.bg-primary {
        background-color: var(--bs-blind-dark) !important;
    }

    .card-actions {
        display: flex;
        gap: 0.5rem;
    }

    .btn-preview {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        color: #495057;
        flex: 1;
        border-radius: 8px;
        padding: 0.6rem;
        font-weight: 500;
        transition: all 0.2s;
        text-decoration: none;
        text-align: center;
    }

    .btn-preview:hover {
        background-color: var(--bs-blind-light-gray);
        border-color: var(--bs-blind-light-gray);
        color: white;
        text-decoration: none;
    }

    .btn-purchase {
        background-color: var(--bs-accent);
        border: 1px solid var(--bs-accent);
        color: white;
        flex: 1;
        border-radius: 8px;
        padding: 0.6rem;
        font-weight: 600;
        transition: all 0.2s;
        text-decoration: none;
        text-align: center;
    }

    .btn-purchase:hover {
        background-color: #ff6a36;
        border-color: #ff6a36;
        color: white;
        text-decoration: none;
    }

    /* 선택된 필터 태그 */
    .selected-filters .badge {
        font-size: 0.85rem;
        padding: 0.5rem 0.8rem;
        border-radius: 20px;
        margin: 0.2rem;
    }

    /* 로딩 스피너 스타일 */
    .loading-spinner {
        display: none;
        text-align: center;
        padding: 3rem 0;
    }

    .loading-spinner.show {
        display: block;
    }

    .spinner-border-custom {
        width: 3rem;
        height: 3rem;
        border: 0.3em solid rgba(36, 177, 181, 0.2);
        border-right-color: var(--bs-blind-dark);
        border-radius: 50%;
        animation: spinner-border .75s linear infinite;
    }

    @keyframes spinner-border {
        to {
            transform: rotate(360deg);
        }
    }

    /* 페이드 인 애니메이션 */
    .fade-in {
        opacity: 0;
        transform: translateY(20px);
        transition: all 0.5s ease;
    }

    .fade-in.show {
        opacity: 1;
        transform: translateY(0);
    }

    /* 무한 스크롤 로딩 */
    .load-more-trigger {
        height: 1px;
        margin: 2rem 0;
    }

    .load-more-btn {
        background: linear-gradient(45deg, var(--bs-blind-dark), var(--bs-blind-light-gray));
        border: none;
        color: white;
        padding: 1rem 2rem;
        border-radius: 25px;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s;
        box-shadow: 0 4px 15px rgba(36, 177, 181, 0.3);
    }

    .load-more-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(36, 177, 181, 0.4);
        color: white;
    }

    .load-more-btn:disabled {
        opacity: 0.6;
        transform: none;
        cursor: not-allowed;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .page-title {
            font-size: 2rem;
        }
        
        .card-actions {
            flex-direction: column;
        }
        
        .card-meta {
            flex-direction: column;
            gap: 0.5rem;
        }
    }

    /* 검색 결과 없음 */
    .no-results {
        text-align: center;
        padding: 4rem 0;
        display: none;
    }

    .no-results.show {
        display: block;
    }
</style>

<!-- 페이지 헤더 -->
<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">
                <h1 class="page-title">학습자료 쇼핑몰</h1>
                <p class="page-subtitle">최고의 학습자료를 찾아보세요. 검증된 자료로 학습 효과를 극대화하세요!</p>
            </div>
        </div>
    </div>
</div>

<!-- 메인 콘텐츠 -->
<div class="main-content">
    <div class="container">
        <!-- 필터 및 정렬 섹션 -->
        <div class="filter-section">
            <div class="row">
                <div class="col-12 mb-4">
                    <h6 class="mb-4"><i class="bi bi-funnel me-2"></i>카테고리 필터</h6>
                    
                    <!-- 학교급 탭 -->
                    <div class="mb-4">
                        <label class="form-label small fw-bold mb-2">학교급</label>
                        <div class="school-level-tabs d-flex flex-wrap gap-2">
                            <button type="button" class="tab-btn active" data-school-level="">전체</button>
                            <button type="button" class="tab-btn" data-school-level="elementary">초등학교</button>
                            <button type="button" class="tab-btn" data-school-level="middle">중학교</button>
                            <button type="button" class="tab-btn" data-school-level="high">고등학교</button>
                            <button type="button" class="tab-btn" data-school-level="suneung">수능</button>
                            <button type="button" class="tab-btn" data-school-level="etc">기타</button>
                        </div>
                    </div>
                    
                    <!-- 학년 버튼 -->
                    <div class="mb-4" id="gradeSection" style="display: none;">
                        <label class="form-label small fw-bold mb-2">학년</label>
                        <div class="grade-buttons d-flex flex-wrap gap-2" id="gradeButtons">
                            <!-- 동적으로 생성됨 -->
                        </div>
                    </div>
                    
                    <!-- 과목 버튼 -->
                    <div class="mb-4">
                        <label class="form-label small fw-bold mb-2">과목</label>
                        <div class="subject-buttons d-flex flex-wrap gap-2">
                            <button type="button" class="filter-btn active" data-subject="">전체</button>
                            <button type="button" class="filter-btn" data-subject="korean">국어</button>
                            <button type="button" class="filter-btn" data-subject="math">수학</button>
                            <button type="button" class="filter-btn" data-subject="english">영어</button>
                            <button type="button" class="filter-btn" data-subject="social">사회</button>
                            <button type="button" class="filter-btn" data-subject="science">과학</button>
                            <button type="button" class="filter-btn" data-subject="art">예체능</button>
                            <button type="button" class="filter-btn" data-subject="etc">기타</button>
                        </div>
                    </div>
                    
                    <!-- 정렬 및 검색 -->
                    <div class="row align-items-end">
                        <div class="col-md-3">
                            <label class="form-label small fw-bold mb-2">정렬</label>
                            <select id="sortSelect" class="form-select form-select-sm">
                                <option value="popular">인기순</option>
                                <option value="latest">최신순</option>
                                <option value="price_low">가격 낮은순</option>
                                <option value="price_high">가격 높은순</option>
                                <option value="rating">별점순</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-bold mb-2">검색</label>
                            <div class="d-flex gap-2">
                                <input type="text" id="searchInput" class="form-control form-control-sm" 
                                       placeholder="자료명, 작성자 검색..." value="<%=keyword%>">
                                <button type="button" id="searchBtn" class="btn btn-primary btn-sm" 
                                        style="background-color: var(--bs-blind-dark); border-color: var(--bs-blind-dark);">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 선택된 필터 태그 -->
                <div class="col-12">
                    <div class="selected-filters d-flex flex-wrap gap-2 mb-3" id="selectedFilters">
                        <!-- 동적으로 생성됨 -->
                    </div>
                </div>
            </div>
        </div>

        <!-- 로딩 스피너 -->
        <div class="loading-spinner" id="loadingSpinner">
            <div class="spinner-border-custom"></div>
            <p class="mt-3 text-muted">자료를 불러오는 중...</p>
        </div>

        <!-- 자료 카드 그리드 -->
        <div class="row" id="materialGrid">
            <!-- AJAX로 동적으로 로드됨 -->
        </div>

        <!-- 검색 결과 없음 -->
        <div class="no-results" id="noResults">
            <i class="bi bi-search" style="font-size: 4rem; color: #dee2e6;"></i>
            <h4 class="mt-3 text-muted">검색 결과가 없습니다</h4>
            <p class="text-muted">다른 조건으로 검색해보세요.</p>
            <button type="button" class="btn btn-primary" id="resetFilters"
                    style="background-color: var(--bs-blind-dark); border-color: var(--bs-blind-dark);">
                전체 자료 보기
            </button>
        </div>

        <!-- 더 보기 버튼 -->
        <div class="text-center mt-4" id="loadMoreSection" style="display: none;">
            <button type="button" class="load-more-btn" id="loadMoreBtn">
                <i class="bi bi-arrow-down-circle me-2"></i>더 많은 자료 보기
            </button>
        </div>

        <!-- 무한 스크롤 트리거 -->
        <div class="load-more-trigger" id="loadMoreTrigger"></div>

        <!-- 페이지네이션 -->
        <nav aria-label="자료 페이지네이션" class="mt-5" id="paginationSection">
            <ul class="pagination justify-content-center" id="pagination">
                <!-- 동적으로 생성됨 -->
            </ul>
        </nav>
    </div>
</div>

<!-- 미리보기 모달 (기존과 동일) -->
<div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg, var(--bs-blind-dark), var(--bs-blind-light-gray)); color: white;">
                <h5 class="modal-title" id="previewModalLabel">
                    <i class="bi bi-eye me-2"></i>자료 미리보기
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="preview-content">
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <h6 class="mb-1" id="previewTitle">자료 제목</h6>
                            <small class="text-muted">미리보기는 실제 자료의 일부분만 보여드립니다.</small>
                        </div>
                        <div class="col-md-4 text-end">
                            <div class="preview-stats d-flex justify-content-end gap-3">
                                <span class="badge bg-light text-dark">
                                    <i class="bi bi-eye-fill me-1"></i><span id="previewViewCount">-</span>
                                </span>
                                <span class="badge bg-light text-dark">
                                    <i class="bi bi-star-fill text-warning me-1"></i><span id="previewRating">-</span>
                                </span>
                                <span class="badge bg-light text-dark">
                                    <i class="bi bi-file-earmark-text me-1"></i><span id="previewPages">-</span>p
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 미리보기 페이지들 -->
                    <div class="preview-pages">
                        <div class="preview-page active" id="previewPage1" style="height: 500px; background-color: #f8f9fa; border: 2px dashed #dee2e6; display: flex; align-items: center; justify-content: center; margin-bottom: 1rem; border-radius: 10px; position: relative;">
                            <div class="text-center">
                                <i class="bi bi-file-earmark-text" style="font-size: 4rem; color: #dee2e6;"></i>
                                <p class="mt-3 text-muted">첫 번째 페이지 미리보기</p>
                                <p class="small text-muted">실제 자료의 표지 또는 목차 페이지입니다.</p>
                            </div>
                            <div class="preview-watermark">PREVIEW</div>
                        </div>
                        
                        <div class="preview-page" id="previewPage2" style="height: 500px; background-color: #f8f9fa; border: 2px dashed #dee2e6; display: none; align-items: center; justify-content: center; margin-bottom: 1rem; border-radius: 10px; position: relative;">
                            <div class="text-center">
                                <i class="bi bi-file-earmark-pdf" style="font-size: 4rem; color: #dee2e6;"></i>
                                <p class="mt-3 text-muted">두 번째 페이지 미리보기</p>
                                <p class="small text-muted">핵심 내용의 일부를 확인해보세요.</p>
                            </div>
                            <div class="preview-watermark">PREVIEW</div>
                        </div>
                        
                        <div class="preview-page" id="previewPage3" style="height: 500px; background-color: #f8f9fa; border: 2px dashed #dee2e6; display: none; align-items: center; justify-content: center; margin-bottom: 1rem; border-radius: 10px; position: relative;">
                            <div class="text-center">
                                <i class="bi bi-file-earmark-richtext" style="font-size: 4rem; color: #dee2e6;"></i>
                                <p class="mt-3 text-muted">세 번째 페이지 미리보기</p>
                                <p class="small text-muted">더 많은 내용을 보려면 구매해주세요!</p>
                            </div>
                            <div class="preview-watermark">PREVIEW</div>
                        </div>
                    </div>
                    
                    <!-- 페이지 네비게이션 -->
                    <div class="preview-nav text-center">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-outline-primary btn-sm active" onclick="showPreviewPage(1)">
                                <i class="bi bi-1-circle"></i>
                            </button>
                            <button type="button" class="btn btn-outline-primary btn-sm" onclick="showPreviewPage(2)">
                                <i class="bi bi-2-circle"></i>
                            </button>
                            <button type="button" class="btn btn-outline-primary btn-sm" onclick="showPreviewPage(3)">
                                <i class="bi bi-3-circle"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <div class="preview-info">
                        <small class="text-muted">
                            <i class="bi bi-info-circle me-1"></i>
                            이 미리보기는 실제 자료의 일부분입니다.
                        </small>
                    </div>
                    <div class="preview-actions">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="bi bi-x-lg me-1"></i>닫기
                        </button>
                        <button type="button" class="btn" style="background-color: var(--bs-accent); color: white;" id="previewPurchaseBtn">
                            <i class="bi bi-cart-plus me-1"></i>구매하기
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.preview-watermark {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) rotate(-45deg);
    font-size: 3rem;
    font-weight: bold;
    color: rgba(0,0,0,0.1);
    pointer-events: none;
    z-index: 1;
}

.preview-stats .badge {
    border: 1px solid #dee2e6;
}

.preview-nav .btn-group .btn {
    border-color: var(--bs-blind-dark);
    color: var(--bs-blind-dark);
}

.preview-nav .btn-group .btn.active,
.preview-nav .btn-group .btn:hover {
    background-color: var(--bs-blind-dark);
    border-color: var(--bs-blind-dark);
    color: white;
}

.preview-page {
    transition: all 0.3s ease;
}

.modal-xl .modal-content {
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}

.modal-header {
    border-radius: 15px 15px 0 0;
}
</style>

<script>
// 전역 변수
let currentFilters = {
    schoolLevel: '<%=schoolLevel%>',
    grade: '<%=grade%>',
    subject: '<%=subject%>',
    sortBy: '<%=sortBy%>',
    keyword: '<%=keyword%>',
    page: 1
};

let isLoading = false;
let hasMore = true;
let infiniteScrollEnabled = false; // 무한 스크롤 활성화 여부

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    initializeFilters();
    setupEventListeners();
    loadMaterials(true); // 초기 로드
    setupInfiniteScroll();
});

// 필터 초기화
function initializeFilters() {
    // 학교급 버튼 활성화
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-school-level') === currentFilters.schoolLevel) {
            btn.classList.add('active');
        }
    });
    
    // 과목 버튼 활성화
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-subject') === currentFilters.subject) {
            btn.classList.add('active');
        }
    });
    
    // 정렬 선택
    document.getElementById('sortSelect').value = currentFilters.sortBy;
    
    // 학년 버튼 생성
    updateGradeButtons();
    
    // 선택된 필터 태그 업데이트
    updateSelectedFilters();
}

// 이벤트 리스너 설정
function setupEventListeners() {
    // 학교급 버튼
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const schoolLevel = this.getAttribute('data-school-level');
            updateFilter('schoolLevel', schoolLevel);
            updateGradeButtons();
            
            // 활성화 클래스 업데이트
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });
    
    // 과목 버튼
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const subject = this.getAttribute('data-subject');
            updateFilter('subject', subject);
            
            // 활성화 클래스 업데이트
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });
    
    // 정렬 선택
    document.getElementById('sortSelect').addEventListener('change', function() {
        updateFilter('sortBy', this.value);
    });
    
    // 검색
    document.getElementById('searchBtn').addEventListener('click', function() {
        const keyword = document.getElementById('searchInput').value.trim();
        updateFilter('keyword', keyword);
    });
    
    document.getElementById('searchInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            const keyword = this.value.trim();
            updateFilter('keyword', keyword);
        }
    });
    
    // 필터 리셋
    document.getElementById('resetFilters').addEventListener('click', function() {
        resetAllFilters();
    });
    
    // 더 보기 버튼
    document.getElementById('loadMoreBtn').addEventListener('click', function() {
        loadMoreMaterials();
    });
}

// 학년 버튼 업데이트
function updateGradeButtons() {
    const gradeSection = document.getElementById('gradeSection');
    const gradeButtons = document.getElementById('gradeButtons');
    
    if (['elementary', 'middle', 'high'].includes(currentFilters.schoolLevel)) {
        const maxGrade = currentFilters.schoolLevel === 'elementary' ? 6 : 3;
        let buttonsHtml = `
            <button type="button" class="grade-btn \${currentFilters.grade == '' ? 'active' : ''}" data-grade="">
                <i class="bi bi-list"></i>
            </button>
        `;
        
        for (let i = 1; i <= maxGrade; i++) {
            buttonsHtml += `
                <button type="button" class="grade-btn \${currentFilters.grade == i.toString() ? 'active' : ''}" data-grade="${i}">
                    \${i}
                </button>
            `;
        }
        
        gradeButtons.innerHTML = buttonsHtml;
        gradeSection.style.display = 'block';
        
        // 학년 버튼 이벤트 리스너 추가
        gradeButtons.querySelectorAll('.grade-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const grade = this.getAttribute('data-grade');
                updateFilter('grade', grade);
                
                // 활성화 클래스 업데이트
                gradeButtons.querySelectorAll('.grade-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });
    } else {
        gradeSection.style.display = 'none';
        if (currentFilters.grade !== '') {
            updateFilter('grade', '');
        }
    }
}

// 필터 업데이트
function updateFilter(key, value) {
    currentFilters[key] = value;
    currentFilters.page = 1; // 페이지 리셋
    hasMore = true;
    
    updateSelectedFilters();
    loadMaterials(true); // 새로 로드
    updateURL();
}

// 선택된 필터 태그 업데이트
function updateSelectedFilters() {
    const container = document.getElementById('selectedFilters');
    let html = '';
    
    if (isAllFiltersEmpty()) {
        html = `
            <span class="badge bg-secondary">
                <i class="bi bi-funnel-fill me-1"></i>전체 자료
            </span>
        `;
    } else {
        if (currentFilters.schoolLevel) {
            const schoolNames = {
                'elementary': '초등학교',
                'middle': '중학교',
                'high': '고등학교',
                'suneung': '수능',
                'etc': '기타'
            };
            html += `
                <span class="badge" style="background-color: var(--bs-blind-dark);">
                    <i class="bi bi-tag-fill me-1"></i>\${schoolNames[currentFilters.schoolLevel]}
                    <button type="button" class="btn-close btn-close-white ms-2" style="font-size: 0.7rem;" onclick="removeFilter('schoolLevel')"></button>
                </span>
            `;
        }
        
        if (currentFilters.grade) {
            html += `
                <span class="badge" style="background-color: var(--bs-accent);">
                    <i class="bi bi-tag-fill me-1"></i>\${currentFilters.grade}학년
                    <button type="button" class="btn-close btn-close-white ms-2" style="font-size: 0.7rem;" onclick="removeFilter('grade')"></button>
                </span>
            `;
        }
        
        if (currentFilters.subject) {
            const subjectNames = {
                'korean': '국어',
                'math': '수학',
                'english': '영어',
                'social': '사회',
                'science': '과학',
                'art': '예체능',
                'etc': '기타'
            };
            html += `
                <span class="badge" style="background-color: #6f42c1;">
                    <i class="bi bi-tag-fill me-1"></i>\${subjectNames[currentFilters.subject]}
                    <button type="button" class="btn-close btn-close-white ms-2" style="font-size: 0.7rem;" onclick="removeFilter('subject')"></button>
                </span>
            `;
        }
        
        if (currentFilters.keyword) {
            html += `
                <span class="badge" style="background-color: #20c997;">
                    <i class="bi bi-search me-1"></i>"\${currentFilters.keyword}"
                    <button type="button" class="btn-close btn-close-white ms-2" style="font-size: 0.7rem;" onclick="removeFilter('keyword')"></button>
                </span>
            `;
        }
    }
    
    container.innerHTML = html;
}

// 개별 필터 제거
function removeFilter(filterKey) {
    currentFilters[filterKey] = '';
    currentFilters.page = 1;
    hasMore = true;
    
    // UI 업데이트
    if (filterKey === 'schoolLevel') {
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-school-level') === '') {
                btn.classList.add('active');
            }
        });
        updateGradeButtons();
    } else if (filterKey === 'grade') {
        updateGradeButtons();
    } else if (filterKey === 'subject') {
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.classList.remove('active');
            if (btn.getAttribute('data-subject') === '') {
                btn.classList.add('active');
            }
        });
    } else if (filterKey === 'keyword') {
        document.getElementById('searchInput').value = '';
    }
    
    updateSelectedFilters();
    loadMaterials(true);
    updateURL();
}

// 모든 필터가 비어있는지 확인
function isAllFiltersEmpty() {
    return !currentFilters.schoolLevel && !currentFilters.grade && 
           !currentFilters.subject && !currentFilters.keyword;
}

// 모든 필터 리셋
function resetAllFilters() {
    currentFilters = {
        schoolLevel: '',
        grade: '',
        subject: '',
        sortBy: 'popular',
        keyword: '',
        page: 1
    };
    hasMore = true;
    
    // UI 리셋
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-school-level') === '') {
            btn.classList.add('active');
        }
    });
    
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-subject') === '') {
            btn.classList.add('active');
        }
    });
    
    document.getElementById('sortSelect').value = 'popular';
    document.getElementById('searchInput').value = '';
    
    updateGradeButtons();
    updateSelectedFilters();
    loadMaterials(true);
    updateURL();
}

// 자료 로드 (AJAX)
async function loadMaterials(reset = false) {
    if (isLoading) return;
    
    isLoading = true;
    showLoading();
    
    if (reset) {
        document.getElementById('materialGrid').innerHTML = '';
        currentFilters.page = 1;
    }
    
    try {
        const params = new URLSearchParams({
            schoolLevel: currentFilters.schoolLevel,
            grade: currentFilters.grade,
            subject: currentFilters.subject,
            sortBy: currentFilters.sortBy,
            keyword: currentFilters.keyword,
            page: currentFilters.page,
            ajax: 'true'
        });
        
        const response = await fetch(`<%=request.getContextPath()%>/materials/list.do?\${params}`);
        const data = await response.json();
        
        if (data.success) {
            if (reset) {
                renderMaterials(data.materials);
            } else {
                appendMaterials(data.materials);
            }
            
            hasMore = data.hasMore;
            updateLoadMoreButton();
            updateNoResultsDisplay(data.materials.length === 0 && reset);
            
            // 페이지네이션 업데이트 (필요한 경우)
            if (data.pageBar) {
                updatePagination(data.pageBar);
            }
        } else {
            console.error('자료 로드 실패:', data.message);
        }
        
    } catch (error) {
        console.error('AJAX 요청 실패:', error);
    } finally {
        isLoading = false;
        hideLoading();
    }
}

// 더 많은 자료 로드
async function loadMoreMaterials() {
    if (!hasMore || isLoading) return;
    
    currentFilters.page++;
    await loadMaterials(false);
}

// 자료 렌더링
function renderMaterials(materials) {
    const grid = document.getElementById('materialGrid');
    grid.innerHTML = materials.map(material => createMaterialCard(material)).join('');
    
    // 애니메이션 효과
    setTimeout(() => {
        grid.querySelectorAll('.material-card').forEach((card, index) => {
            card.classList.add('fade-in');
            setTimeout(() => {
                card.classList.add('show');
            }, index * 100);
        });
    }, 50);
    
    setupCardEventListeners();
}

// 자료 추가 렌더링
function appendMaterials(materials) {
    const grid = document.getElementById('materialGrid');
    const newCards = materials.map(material => createMaterialCard(material)).join('');
    grid.insertAdjacentHTML('beforeend', newCards);
    
    // 새로 추가된 카드들에 애니메이션
    const newCardElements = grid.querySelectorAll('.material-card:not(.fade-in)');
    newCardElements.forEach((card, index) => {
        card.classList.add('fade-in');
        setTimeout(() => {
            card.classList.add('show');
        }, index * 100);
    });
    
    setupCardEventListeners();
}

// 자료 카드 생성
function createMaterialCard(material) {
    // 배지 설정
    let badgeText = '';
    let badgeClass = '';
    
    if (material.materialViewCount > 5000) {
        badgeText = 'HOT';
        badgeClass = 'bg-danger';
    } else if (material.materialRating >= 4.5) {
        badgeText = '베스트';
        badgeClass = 'bg-warning';
    } else if (material.materialPrice === 0) {
        badgeText = '무료';
        badgeClass = 'bg-success';
    } else {
        badgeText = '일반';
        badgeClass = 'bg-primary';
    }
    
    // 과목별 미리보기 내용
    let previewContent = '';
    switch(material.materialSubject) {
        case 'math':
            previewContent = `
                <div class="math-formula">
                    <strong>수학 문제집</strong><br>
                    총 \${material.materialPage}페이지
                </div>
                <div class="math-formula">
                    <strong>핵심 공식 수록</strong><br>
                    체계적 학습 가능
                </div>
            `;
            break;
        case 'korean':
            previewContent = `
                <p><strong>국어 학습자료</strong></p>
                <p>• 총 \${material.materialPage}페이지</p>
                <p>• 체계적 문제 구성</p>
                <p>• 상세한 해설 포함</p>
            `;
            break;
        case 'english':
            previewContent = `
                <div class="word-card">
                    <span><strong>English</strong></span>
                    <span>영어</span>
                </div>
                <p style="font-size: 0.7rem;">\${material.materialPage}페이지 구성</p>
            `;
            break;
        case 'science':
            previewContent = `
                <div class="experiment-step">
                    과학 실험 가이드
                </div>
                <div class="experiment-step">
                    \${material.materialPage}페이지 분량
                </div>
            `;
            break;
        default:
            previewContent = `
                <p><strong>\${material.materialSubject} 학습자료</strong></p>
                <p>• 총 \${material.materialPage}페이지</p>
                <p>• 전문가 제작</p>
                <p>• 검증된 내용</p>
            `;
    }
    
    return `
        <div class="col-lg-4 col-md-6 col-12">
            <div class="material-card">
                <div class="card-image">
                    <span class="card-badge \${badgeClass}">\${badgeText}</span>
                    <span class="card-price">\${material.materialPrice == 0 ? 'FREE' : '₩' + material.materialPrice.toLocaleString()}</span>
                    <div class="preview-page-card">
                        <h4>\${material.materialTitle}</h4>
                        <div class="content">
                            \${previewContent}
                        </div>
                    </div>
                </div>
                <div class="card-content">
                    <h3 class="card-title">\${material.materialTitle}</h3>
                    <p class="card-description">\${material.materialDiscription}</p>
                    <div class="card-meta">
                        <span><i class="bi bi-person-fill me-1"></i>\${material.instructorName}</span>
                        <span><i class="bi bi-calendar3 me-1"></i>\${material.materialCreatedDate}</span>
                    </div>
                    
                    <div class="card-stats">
                        <div class="stat-item" title="조회수" data-bs-toggle="tooltip">
                            <i class="bi bi-eye-fill" style="color: #17a2b8;"></i>
                            <span>\${material.materialViewCount.toLocaleString()}</span>
                        </div>
                        <div class="stat-item" title="다운로드 수" data-bs-toggle="tooltip">
                            <i class="bi bi-download" style="color: #28a745;"></i>
                            <span>\${material.materialDownloadCount.toLocaleString()}</span>
                        </div>
                        <div class="stat-item" title="평점" data-bs-toggle="tooltip">
                            <i class="bi bi-star-fill" style="color: #ffd700;"></i>
                            <span>\${material.materialRating.toFixed(1)}</span>
                        </div>
                        <div class="stat-item" title="댓글 수" data-bs-toggle="tooltip">
                            <i class="bi bi-chat-dots" style="color: #6f42c1;"></i>
                            <span>\${material.materialCommentCount.toLocaleString()}</span>
                        </div>
                        <div class="stat-item" title="페이지 수" data-bs-toggle="tooltip">
                            <i class="bi bi-file-earmark-text" style="color: #fd7e14;"></i>
                            <span>\${material.materialPage}p</span>
                        </div>
                    </div>
                    
                    <div class="card-extra-info mb-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="material-tags">
                                <span class="badge bg-light text-dark">\${material.materialCategory}</span>
                                ${material.materialGrade 
                                ? `<span class="badge bg-light text-dark">\${material.materialGrade}학년</span>` 
                                : ''}
                            </div>
                            <div class="popularity-score">
                                \${(material.materialViewCount * 0.3 + material.materialDownloadCount * 0.4 + material.materialRating * material.materialCommentCount * 0.3) > 1000 ? 
                                    '<i class="bi bi-fire text-danger" title="인기 자료"></i>' : ''}
                            </div>
                        </div>
                    </div>
                    
                    <div class="card-actions">
                        <button type="button" class="btn-preview" data-material-id="\${material.materialId}" data-material-title="\${material.materialTitle}">
                            <i class="bi bi-eye me-1"></i>미리보기
                        </button>
                        <a href="<%=request.getContextPath()%>/materials/purchase.do?id=\${material.materialId}" class="btn-purchase">
                            <i class="bi bi-\${material.materialPrice == 0 ? 'download' : 'cart-plus'} me-1"></i>
                            \${material.materialPrice == 0 ? '다운로드' : '구매하기'}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// 카드 이벤트 리스너 설정
function setupCardEventListeners() {
    // 미리보기 버튼
    document.querySelectorAll('.btn-preview').forEach(btn => {
        btn.addEventListener('click', function() {
            const materialId = this.getAttribute('data-material-id');
            const materialTitle = this.getAttribute('data-material-title');
            openPreview(materialTitle, materialId);
        });
    });
    
    // 구매 버튼
    document.querySelectorAll('.btn-purchase').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            const card = this.closest('.material-card');
            const title = card.querySelector('.card-title').textContent;
            const price = card.querySelector('.card-price').textContent;
            
            if (price === 'FREE') {
                if (confirm(title + '을(를) 다운로드하시겠습니까?')) {
                    window.location.href = this.href;
                }
            } else {
                if (confirm(title + '을(를) ' + price + '에 구매하시겠습니까?')) {
                    window.location.href = this.href;
                }
            }
        });
    });
    
    // 툴팁 초기화
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

// 로딩 표시/숨김
function showLoading() {
    document.getElementById('loadingSpinner').classList.add('show');
}

function hideLoading() {
    document.getElementById('loadingSpinner').classList.remove('show');
}

// 더 보기 버튼 업데이트
function updateLoadMoreButton() {
    const loadMoreSection = document.getElementById('loadMoreSection');
    const loadMoreBtn = document.getElementById('loadMoreBtn');
    
    if (hasMore) {
        loadMoreSection.style.display = 'block';
        loadMoreBtn.disabled = false;
        loadMoreBtn.innerHTML = '<i class="bi bi-arrow-down-circle me-2"></i>더 많은 자료 보기';
    } else {
        loadMoreSection.style.display = 'none';
    }
}

// 검색 결과 없음 표시
function updateNoResultsDisplay(show) {
    const noResults = document.getElementById('noResults');
    const materialGrid = document.getElementById('materialGrid');
    
    if (show) {
        noResults.classList.add('show');
        materialGrid.style.display = 'none';
    } else {
        noResults.classList.remove('show');
        materialGrid.style.display = 'flex';
    }
}

// 페이지네이션 업데이트 (선택적 사용)
function updatePagination(pageBarHtml) {
    const pagination = document.getElementById('pagination');
    pagination.innerHTML = pageBarHtml;
    
    // 페이지네이션 클릭 이벤트 추가
    pagination.querySelectorAll('a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const url = new URL(this.href);
            const page = url.searchParams.get('page');
            if (page) {
                currentFilters.page = parseInt(page);
                loadMaterials(true);
                updateURL();
            }
        });
    });
}

// URL 업데이트 (브라우저 히스토리)
function updateURL() {
    const params = new URLSearchParams();
    
    if (currentFilters.schoolLevel) params.set('schoolLevel', currentFilters.schoolLevel);
    if (currentFilters.grade) params.set('grade', currentFilters.grade);
    if (currentFilters.subject) params.set('subject', currentFilters.subject);
    if (currentFilters.sortBy !== 'popular') params.set('sortBy', currentFilters.sortBy);
    if (currentFilters.keyword) params.set('keyword', currentFilters.keyword);
    if (currentFilters.page > 1) params.set('page', currentFilters.page);
    
    const newURL = window.location.pathname + (params.toString() ? '?' + params.toString() : '');
    history.pushState(null, '', newURL);
}

// 무한 스크롤 설정
function setupInfiniteScroll() {
    const trigger = document.getElementById('loadMoreTrigger');
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting && hasMore && !isLoading && infiniteScrollEnabled) {
                loadMoreMaterials();
            }
        });
    }, {
        rootMargin: '100px'
    });
    
    observer.observe(trigger);
    
    // 무한 스크롤 토글 기능 (선택적)
    // infiniteScrollEnabled = true; // 필요시 활성화
}

// 미리보기 모달 관련 함수들
function openPreview(title, materialId) {
    document.getElementById('previewTitle').textContent = title;
    
    // 조회수 증가 요청
    if (materialId) {
        fetch('<%=request.getContextPath()%>/materials/increaseView.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'materialId=' + materialId
        }).then(response => {
            if (response.ok) {
                updateViewCountInCards(materialId);
            }
        }).catch(error => {
            console.log('조회수 증가 중 오류:', error);
        });
    }
    
    const modal = new bootstrap.Modal(document.getElementById('previewModal'));
    modal.show();
}

function showPreviewPage(pageNum) {
    document.querySelectorAll('.preview-page').forEach(page => {
        page.style.display = 'none';
    });
    
    document.getElementById(`previewPage${pageNum}`).style.display = 'flex';
    
    document.querySelectorAll('.preview-nav .btn').forEach(btn => {
        btn.classList.remove('active');
    });
    document.querySelectorAll('.preview-nav .btn')[pageNum - 1].classList.add('active');
}

function updateViewCountInCards(materialId) {
    document.querySelectorAll('.btn-preview').forEach(btn => {
        if (btn.getAttribute('data-material-id') === materialId.toString()) {
            const card = btn.closest('.material-card');
            const viewCountSpan = card.querySelector('.stat-item:first-child span');
            if (viewCountSpan) {
                let currentCount = parseInt(viewCountSpan.textContent.replace(/,/g, ''));
                viewCountSpan.textContent = (currentCount + 1).toLocaleString();
            }
        }
    });
}

// 브라우저 뒤로가기 지원
window.addEventListener('popstate', function(event) {
    const urlParams = new URLSearchParams(window.location.search);
    
    currentFilters = {
        schoolLevel: urlParams.get('schoolLevel') || '',
        grade: urlParams.get('grade') || '',
        subject: urlParams.get('subject') || '',
        sortBy: urlParams.get('sortBy') || 'popular',
        keyword: urlParams.get('keyword') || '',
        page: parseInt(urlParams.get('page')) || 1
    };
    
    initializeFilters();
    loadMaterials(true);
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>