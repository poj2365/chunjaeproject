<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.market.model.dto.Material" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
    Material material = (Material) request.getAttribute("material");
    Boolean isPurchased = (Boolean) request.getAttribute("isPurchased");
    
    if (material == null) {
        response.sendRedirect(request.getContextPath() + "/market/list.do");
        return;
    }
    if (isPurchased == null) isPurchased = false;
%>

<style>
.detail-container {
    background: #ffffff;
    min-height: calc(100vh - 200px);
    padding: 2rem 0;
}

.detail-card {
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
}

.detail-header {
    background: linear-gradient(135deg, var(--bs-dropdown-pastel) 0%, #a8f4f7 100%);
    padding: 2rem;
    text-align: center;
    position: relative;
}

.detail-header::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23ffffff" stroke-width="0.5" opacity="0.2"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
}

.detail-header-content {
    position: relative;
    z-index: 1;
}

.material-thumbnail {
    width: 200px;
    height: 250px;
    background: white;
    border-radius: 15px;
    margin: 0 auto 1.5rem;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    position: relative;
}

.material-thumbnail img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.material-thumbnail i {
    font-size: 4rem;
    color: var(--bs-blind-dark);
}

/* 썸네일 슬라이더 스타일 */
.thumbnail-slider {
    position: relative;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.slider-container {
    position: relative;
    width: 100%;
    height: 100%;
}

.slider-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: opacity 0.3s ease;
    position: absolute;
    top: 0;
    left: 0;
}

.slider-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    border-radius: 50%;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s ease;
    z-index: 10;
    opacity: 0;
}

.thumbnail-slider:hover .slider-btn {
    opacity: 1;
}

.prev-btn {
    left: 10px;
}

.next-btn {
    right: 10px;
}

.slider-btn:hover {
    background: rgba(0, 0, 0, 0.7);
    transform: translateY(-50%) scale(1.1);
}

.slider-dots {
    position: absolute;
    bottom: 10px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 5px;
    z-index: 10;
}

.dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.5);
    cursor: pointer;
    transition: all 0.3s ease;
}

.dot.active {
    background: white;
    transform: scale(1.2);
}

.material-title {
    font-size: 2rem;
    font-weight: 700;
    color: #2d3748;
    margin-bottom: 0.5rem;
}

.material-instructor {
    font-size: 1.1rem;
    color: #718096;
    margin-bottom: 1rem;
}

.material-categories {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.category-badge {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 600;
}

.detail-content {
    display: grid;
    grid-template-columns: 1fr 350px;
    gap: 2rem;
    padding: 2rem;
}

.material-info {
    background: #f8f9fa;
    border-radius: 15px;
    padding: 1.5rem;
}

.info-title {
    font-size: 1.3rem;
    font-weight: 700;
    color: #2d3748;
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.material-description {
    color: #4a5568;
    line-height: 1.6;
    margin-bottom: 1.5rem;
}

.material-stats {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.stat-box {
    background: white;
    border-radius: 10px;
    padding: 1rem;
    text-align: center;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.stat-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--bs-blind-dark);
    display: block;
}

.stat-label {
    font-size: 0.85rem;
    color: #718096;
    margin-top: 0.25rem;
}

.instructor-info {
    background: linear-gradient(135deg, var(--bs-blind-light-gray) 0%, var(--bs-dropdown-pastel) 100%);
    color: white;
    border-radius: 15px;
    padding: 1.5rem;
    margin-bottom: 1.5rem;
}

.instructor-title {
    font-size: 1.1rem;
    font-weight: 700;
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.purchase-section {
    background: white;
    border-radius: 15px;
    padding: 1.5rem;
    border: 2px solid #e2e8f0;
}

.price-section {
    text-align: center;
    margin-bottom: 1.5rem;
}

.price-label {
    font-size: 0.9rem;
    color: #718096;
    margin-bottom: 0.5rem;
}

.material-price {
    font-size: 2.5rem;
    font-weight: 700;
    color: var(--bs-blind-dark);
}

.price-free {
    color: #48bb78 !important;
}

.purchase-buttons {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.btn-purchase {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 10px;
    font-weight: 600;
    font-size: 1rem;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.btn-purchase:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(26, 138, 142, 0.3);
    color: white;
}

.btn-preview {
    background: linear-gradient(45deg, var(--bs-blind-accent), #ff6a36);
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 10px;
    font-weight: 600;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.btn-preview:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(255, 125, 77, 0.3);
    color: white;
}

.btn-back {
    background: #e2e8f0;
    color: #4a5568;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 10px;
    font-weight: 500;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
}

.btn-back:hover {
    background: #cbd5e0;
    transform: translateY(-2px);
}

.preview-modal .modal-content {
    border-radius: 20px;
    border: none;
}

.preview-modal .modal-header {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
    border-radius: 20px 20px 0 0;
}

.preview-content {
    text-align: center;
    padding: 2rem;
}

.preview-image {
    max-width: 100%;
    max-height: 400px;
    border-radius: 10px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

/* 로딩 스피너 */
.spinner-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.spinner-content {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    text-align: center;
}

@media (max-width: 768px) {
    .detail-content {
        grid-template-columns: 1fr;
        gap: 1rem;
        padding: 1rem;
    }
    
    .material-title {
        font-size: 1.5rem;
    }
    
    .material-thumbnail {
        width: 150px;
        height: 200px;
    }
    
    .material-stats {
        grid-template-columns: 1fr;
    }
}
</style>

<div class="detail-container">
    <div class="container">
        <!-- 뒤로가기 버튼 -->
        <div class="mb-3">
            <button class="btn-back" onclick="history.back()">
                <i class="bi bi-arrow-left"></i>목록으로 돌아가기
            </button>
        </div>
        
        <!-- 자료 상세 카드 -->
        <div class="detail-card">
            <!-- 헤더 섹션 -->
            <div class="detail-header">
                <div class="detail-header-content">
                    <div class="material-thumbnail">
                        <% if (material.thumbnailFilePaths() != null && !material.thumbnailFilePaths().isEmpty() 
                               && !material.thumbnailFilePaths().get(0).trim().isEmpty()) { %>
                            
                            <% if (material.thumbnailFilePaths().size() == 1) { %>
                                <!-- 단일 이미지 -->
                                <img src="<%= request.getContextPath() %>/<%= material.thumbnailFilePaths().get(0) %>" 
                                     alt="<%= material.materialTitle() %>"
                                     onerror="this.style.display='none'; this.parentNode.innerHTML='<i class=\'bi bi-file-earmark-text\' style=\'font-size: 4rem; color: var(--bs-blind-dark);\'></i>';">
                            <% } else { %>
                                <!-- 다중 이미지 슬라이더 -->
                                <div class="thumbnail-slider" data-material-id="<%= material.materialId() %>">
                                    <div class="slider-container">
                                        <% for(int i = 0; i < material.thumbnailFilePaths().size(); i++) { %>
                                            <img src="<%= request.getContextPath() %>/<%= material.thumbnailFilePaths().get(i) %>" 
                                                 alt="<%= material.materialTitle() %> - 이미지 <%= (i+1) %>" 
                                                 class="slider-image <%= i == 0 ? "active" : "" %>"
                                                 style="<%= i == 0 ? "z-index: 1;" : "z-index: 0; opacity: 0;" %>"
                                                 onerror="this.style.display='none';">
                                        <% } %>
                                    </div>
                                    
                                    <% if (material.thumbnailFilePaths().size() > 1) { %>
                                        <!-- 슬라이더 컨트롤 -->
                                        <button class="slider-btn prev-btn" onclick="changeSlide(<%= material.materialId() %>, -1)">
                                            <i class="bi bi-chevron-left"></i>
                                        </button>
                                        <button class="slider-btn next-btn" onclick="changeSlide(<%= material.materialId() %>, 1)">
                                            <i class="bi bi-chevron-right"></i>
                                        </button>
                                        
                                        <!-- 도트 인디케이터 -->
                                        <div class="slider-dots">
                                            <% for(int i = 0; i < material.thumbnailFilePaths().size(); i++) { %>
                                                <span class="dot <%= i == 0 ? "active" : "" %>" 
                                                      onclick="currentSlide(<%= material.materialId() %>, <%= i %>)"></span>
                                            <% } %>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                            
                        <% } else { %>
                            <i class="bi bi-file-earmark-text"></i>
                        <% } %>
                    </div>
                    
                    <h1 class="material-title"><%= material.materialTitle() %></h1>
                    
                    <p class="material-instructor">
                        <i class="bi bi-person-circle me-2"></i><%= material.instructorName() %>
                    </p>
                    
                    <div class="material-categories">
                        <span class="category-badge"><%= material.materialCategory() %></span>
                        <span class="category-badge"><%= material.materialGrade() %></span>
                        <span class="category-badge"><%= material.materialSubject() %></span>
                    </div>
                </div>
            </div>
            
            <!-- 컨텐츠 섹션 -->
            <div class="detail-content">
                <!-- 자료 정보 -->
                <div class="material-info">
                    <h3 class="info-title">
                        <i class="bi bi-info-circle"></i>자료 정보
                    </h3>
                    
                    <div class="material-description">
                        <%= material.materialDiscription() != null ? material.materialDiscription().replace("\n", "<br>") : "자료 설명이 없습니다." %>
                    </div>
                    
                    <div class="material-stats">
                        <div class="stat-box">
                            <span class="stat-value"><%= material.materialPage() %></span>
                            <div class="stat-label">페이지</div>
                        </div>
                        <div class="stat-box">
                            <span class="stat-value"><%= String.format("%.1f", material.materialRating()) %></span>
                            <div class="stat-label">평점</div>
                        </div>
                        <div class="stat-box">
                            <span class="stat-value"><%= material.materialViewCount() %></span>
                            <div class="stat-label">조회수</div>
                        </div>
                        <div class="stat-box">
                            <span class="stat-value"><%= material.materialDownloadCount() %></span>
                            <div class="stat-label">다운로드</div>
                        </div>
                    </div>
                    
                    <!-- 강사 정보 -->
                    <div class="instructor-info">
                        <h4 class="instructor-title">
                            <i class="bi bi-person-badge"></i>강사 소개
                        </h4>
                        <p class="mb-0">
                            <%= material.instructorIntro() != null ? material.instructorIntro() : "강사 소개가 없습니다." %>
                        </p>
                    </div>
                </div>
                
                <!-- 구매 섹션 -->
                <div class="purchase-section">
                    <div class="price-section">
                        <div class="price-label">자료 가격</div>
                        <div class="material-price <%= material.materialPrice() == 0 ? "price-free" : "" %>">
                            <% if (material.materialPrice() == 0) { %>
                                <i class="bi bi-gift me-2"></i>무료
                            <% } else { %>
                                <%= String.format("%,d", material.materialPrice()) %>원
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="purchase-buttons">
                        <% if (material.previewPath() != null && !material.previewPath().trim().isEmpty()) { %>
                            <button class="btn-preview" data-bs-toggle="modal" data-bs-target="#previewModal">
                                <i class="bi bi-eye"></i>미리보기
                            </button>
                        <% } %>
                        
                        <% if (isPurchased) { %>
                            <button class="btn-purchase" onclick="downloadMaterial(<%= material.materialId() %>)">
                                <i class="bi bi-download"></i>다운로드
                            </button>
                        <% } else { %>
                            <button class="btn-purchase" onclick="purchaseMaterial(<%= material.materialId() %>, '<%= material.materialTitle() %>', <%= material.materialPrice() %>)">
                                <i class="bi bi-cart-plus"></i>구매하기
                            </button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 미리보기 모달 -->
<% if (material.previewPath() != null && !material.previewPath().trim().isEmpty()) { %>
<div class="modal fade preview-modal" id="previewModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-eye me-2"></i>미리보기 - <%= material.materialTitle() %>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div class="preview-content">
                    <% if (material.thumbnailFilePaths() != null && !material.thumbnailFilePaths().isEmpty()) { %>
                        <img src="<%= request.getContextPath() %>/<%= material.thumbnailFilePaths().get(0) %>" 
                             alt="미리보기" class="preview-image"
                             onerror="this.style.display='none'; this.parentNode.innerHTML='<div class=\'text-center p-4\'><i class=\'bi bi-exclamation-triangle fs-1 text-warning\'></i><h5 class=\'mt-2\'>미리보기를 불러올 수 없습니다</h5></div>';">
                    <% } else { %>
                        <div class="text-center p-4">
                            <i class="bi bi-exclamation-triangle fs-1 text-warning"></i>
                            <h5 class="mt-2">미리보기가 없습니다</h5>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
<% } %>

<script>
// 슬라이더 기능
let currentSlideIndex = {};

function changeSlide(materialId, direction) {
    const slider = document.querySelector(`[data-material-id="\${materialId}"]`);
    if (!slider) return;
    
    const images = slider.querySelectorAll('.slider-image');
    const dots = slider.querySelectorAll('.dot');
    
    if (!currentSlideIndex[materialId]) {
        currentSlideIndex[materialId] = 0;
    }
    
    // 현재 이미지 숨기기
    images[currentSlideIndex[materialId]].style.opacity = '0';
    images[currentSlideIndex[materialId]].style.zIndex = '0';
    dots[currentSlideIndex[materialId]].classList.remove('active');
    
    // 다음/이전 슬라이드 인덱스 계산
    currentSlideIndex[materialId] += direction;
    
    if (currentSlideIndex[materialId] >= images.length) {
        currentSlideIndex[materialId] = 0;
    } else if (currentSlideIndex[materialId] < 0) {
        currentSlideIndex[materialId] = images.length - 1;
    }
    
    // 새 이미지 표시
    images[currentSlideIndex[materialId]].style.opacity = '1';
    images[currentSlideIndex[materialId]].style.zIndex = '1';
    dots[currentSlideIndex[materialId]].classList.add('active');
}

function currentSlide(materialId, slideIndex) {
    const slider = document.querySelector(`[data-material-id="\${materialId}"]`);
    if (!slider) return;
    
    const images = slider.querySelectorAll('.slider-image');
    const dots = slider.querySelectorAll('.dot');
    
    // 현재 이미지 숨기기
    if (currentSlideIndex[materialId] !== undefined) {
        images[currentSlideIndex[materialId]].style.opacity = '0';
        images[currentSlideIndex[materialId]].style.zIndex = '0';
        dots[currentSlideIndex[materialId]].classList.remove('active');
    }
    
    // 선택된 이미지 표시
    currentSlideIndex[materialId] = slideIndex;
    images[slideIndex].style.opacity = '1';
    images[slideIndex].style.zIndex = '1';
    dots[slideIndex].classList.add('active');
}

$(document).ready(function() {
    // 카드 애니메이션
    $('.detail-card').css({
        'opacity': '0',
        'transform': 'translateY(30px)'
    }).animate({
        'opacity': '1'
    }, 600).css('transform', 'translateY(0)');
    
    // 통계 카운터 애니메이션
    $('.stat-value').each(function() {
        const $this = $(this);
        const countTo = parseInt($this.text().replace(/,/g, '')) || 0;
        
        $({ countNum: 0 }).animate({
            countNum: countTo
        }, {
            duration: 1500,
            easing: 'linear',
            step: function() {
                $this.text(Math.floor(this.countNum).toLocaleString());
            },
            complete: function() {
                $this.text(countTo.toLocaleString());
            }
        });
    });
});

// 자료 구매
function purchaseMaterial(materialId, materialTitle, price) {
    <% if (loginUser == null) { %>
        alert('로그인이 필요한 서비스입니다.');
        location.href = '<%= request.getContextPath() %>/user/loginview.do';
        return;
    <% } %>
    
    if (!confirm(`'\${materialTitle}' 자료를 \${price.toLocaleString()}원에 구매하시겠습니까?`)) {
        return;
    }
    
    const button = $(`.btn-purchase[data-material-id="\${materialId}"]`);
    button.prop('disabled', true).html('<i class="bi bi-hourglass-split me-1"></i>처리중...');
    
    showSpinner('구매 처리 중...');
    
    $.ajax({
        url: '<%= request.getContextPath() %>/market/purchase.do',
        type: 'POST',
        data: { materialId: materialId },
        dataType: 'json',
        success: function(response) {
            hideSpinner();
            
            if (response.success) {
                alert(`구매가 완료되었습니다!\n\${response.materialTitle}\n결제 금액: \${response.price.toLocaleString()}원`);
                
                // 버튼을 다운로드 버튼으로 변경
                button.removeClass('btn-purchase')
                      .addClass('btn-download')
                      .prop('disabled', false)
                      .html('<i class="bi bi-download me-1"></i>다운로드')
                      .attr('onclick', `event.stopPropagation(); downloadMaterial(\${materialId}, '\${materialTitle}')`);
                
                // 구매한 자료 ID 목록에 추가 (새로고침 없이 상태 유지)
                window.purchasedMaterialIds = window.purchasedMaterialIds || [];
                if (!window.purchasedMaterialIds.includes(materialId)) {
                    window.purchasedMaterialIds.push(materialId);
                }
                
            } else {
                alert(response.message);
                button.prop('disabled', false).html('<i class="bi bi-cart-plus me-1"></i>구매하기');
            }
        },
        error: function(xhr, status, error) {
            hideSpinner();
            console.error('구매 요청 실패:', xhr.responseText);
            alert('구매 처리 중 오류가 발생했습니다. 다시 시도해주세요.');
            button.prop('disabled', false).html('<i class="bi bi-cart-plus me-1"></i>구매하기');
        }
    });
}
// 구매한 자료 다운로드
function downloadMaterial(materialId) {
    <% if (loginUser == null) { %>
        alert('로그인이 필요한 서비스입니다.');
        location.href = '<%= request.getContextPath() %>/user/loginview.do';
        return;
    <% } %>
    
    if (confirm('이 자료를 다운로드하시겠습니까?')) {
        // 새 창에서 다운로드
        window.open('<%= request.getContextPath() %>/market/download.do?id=' + materialId, '_blank');
    }
}

// 미리보기 모달 이벤트
$('#previewModal').on('shown.bs.modal', function() {
    $(this).find('.preview-image').css({
        'opacity': '0',
        'transform': 'scale(0.8)'
    }).animate({
        'opacity': '1'
    }, 300).css('transform', 'scale(1)');
});

function showSpinner(message = '처리 중...') {
    const spinner = $(`
        <div class="spinner-overlay">
            <div class="spinner-content">
                <div class="spinner-border text-primary mb-2" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mb-0">${message}</p>
            </div>
        </div>
    `);
    $('body').append(spinner);
}

function hideSpinner() {
    $('.spinner-overlay').remove();
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>