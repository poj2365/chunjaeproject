<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.niw.market.model.dto.Material" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
    List<Material> materials = (List<Material>) request.getAttribute("materials");
    List<Integer> purchasedMaterialIds = (List<Integer>) request.getAttribute("purchases");
    String pageBar = (String) request.getAttribute("pageBar");
    Integer totalCount = (Integer) request.getAttribute("totalCount");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String selectedGrade = (String) request.getAttribute("selectedGrade");
    String selectedSubject = (String) request.getAttribute("selectedSubject");
    
    if (selectedCategory == null) selectedCategory = "전체";
    if (selectedGrade == null) selectedGrade = "전체";
    if (selectedSubject == null) selectedSubject = "전체";
    if (purchasedMaterialIds == null) purchasedMaterialIds = java.util.Collections.emptyList();
%>

<style>
.material-container {
    background: #ffffff;
    min-height: calc(100vh - 200px);
    padding: 2rem 0;
}

.filter-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 2rem;
    margin-bottom: 2rem;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.filter-title {
    font-size: 1.5rem;
    font-weight: 700;
    color: #2d3748;
    margin-bottom: 1.5rem;
    text-align: center;
}

.filter-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    justify-content: center;
    margin-bottom: 1rem;
}

.filter-btn {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    border: none;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 25px;
    font-weight: 500;
    transition: all 0.3s ease;
    cursor: pointer;
    min-width: 80px;
}

.filter-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.filter-btn.active {
    background: linear-gradient(45deg, var(--bs-blind-accent), #ff6a36);
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(255, 125, 77, 0.3);
}

.material-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 2rem;
    margin-bottom: 3rem;
}

.material-card {
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    position: relative;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    height: 100%;
}

.material-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.card-image {
    width: 100%;
    height: 200px;
    background: linear-gradient(135deg, var(--bs-dropdown-pastel) 0%, #a8f4f7 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 3rem;
    color: var(--bs-blind-dark);
    position: relative;
    overflow: hidden;
}

.card-image::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23ffffff" stroke-width="0.5" opacity="0.3"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
}

.card-thumbnail {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 0;
}

.card-content {
    padding: 1.5rem;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.card-category {
    display: inline-block;
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
    padding: 0.25rem 0.75rem;
    border-radius: 15px;
    font-size: 0.75rem;
    font-weight: 600;
    margin-bottom: 0.75rem;
}

.card-title {
    font-size: 1.1rem;
    font-weight: 700;
    color: #2d3748;
    margin-bottom: 0.5rem;
    line-height: 1.3;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.card-instructor {
    color: #718096;
    font-size: 0.9rem;
    margin-bottom: 0.75rem;
}

.card-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.75rem;
    font-size: 0.85rem;
    color: #a0aec0;
}

.card-price {
    font-size: 1.25rem;
    font-weight: 700;
    color: var(--bs-blind-dark);
    text-align: right;
}

.price-free {
    color: #48bb78 !important;
}

.card-stats {
    display: flex;
    gap: 1rem;
    margin-top: 0.75rem;
    font-size: 0.8rem;
    color: #a0aec0;
}

.stat-item {
    display: flex;
    align-items: center;
    gap: 0.25rem;
}

.card-actions {
    display: flex;
    justify-content: flex-end;
    margin-top: auto;
    padding-top: 1rem;
}

.btn-card-download,
.btn-card-purchase,
.btn-card-purchased {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 25px;
    font-weight: 600;
    font-size: 0.85rem;
    transition: all 0.3s ease;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 0.25rem;
    min-width: 100px;
    justify-content: center;
}

.btn-card-download {
    background: linear-gradient(45deg, #48bb78, #38a169);
    color: white;
}

.btn-card-download:hover {
    background: linear-gradient(45deg, #38a169, #2f855a);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
}

.btn-card-purchase {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
}

.btn-card-purchase:hover {
    background: linear-gradient(45deg, var(--bs-blind-dark), var(--bs-blind-light-gray));
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(26, 138, 142, 0.3);
}

.btn-card-purchased {
    background: linear-gradient(45deg, #48bb78, #38a169);
    color: white;
    cursor: default;
}

.btn-card-purchase:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
}

.result-summary {
    text-align: center;
    margin-bottom: 2rem;
}

.result-text {
    color: var(--bs-blind-dark);
    font-size: 1.1rem;
    background: rgba(26, 138, 142, 0.1);
    backdrop-filter: blur(10px);
    padding: 1rem 2rem;
    border-radius: 50px;
    display: inline-block;
    border: 1px solid rgba(26, 138, 142, 0.2);
}

.no-results {
    text-align: center;
    padding: 4rem 2rem;
    color: #6c757d;
}

.no-results i {
    font-size: 4rem;
    margin-bottom: 1rem;
    opacity: 0.5;
    color: var(--bs-blind-gray);
}

.pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 3rem;
}

.pagination .page-link {
    background: rgba(255, 255, 255, 0.9);
    border: none;
    color: var(--bs-blind-dark);
    font-weight: 500;
    margin: 0 0.25rem;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.pagination .page-item.active .page-link {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
    box-shadow: 0 4px 15px rgba(26, 138, 142, 0.3);
}

.pagination .page-link:hover {
    background: linear-gradient(45deg, var(--bs-blind-gray), var(--bs-blind-dark));
    color: white;
    transform: translateY(-2px);
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
    .material-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
    }
    
    .filter-buttons {
        flex-direction: column;
        align-items: center;
    }
    
    .filter-btn {
        width: 200px;
    }
}
</style>

<div class="material-container">
    <div class="container">
        <!-- 필터 섹션 -->
        <div class="filter-section">
            <h2 class="filter-title">
                <i class="bi bi-book me-2"></i>학습자료 찾기
            </h2>
            
            <!-- 카테고리 필터 -->
            <div class="mb-3">
                <h6 class="text-muted mb-2"><i class="bi bi-tag me-1"></i>학교급</h6>
                <div class="filter-buttons" id="categoryButtons">
                    <button class="filter-btn <%= "전체".equals(selectedCategory) ? "active" : "" %>" 
                            data-type="category" data-value="전체">전체</button>
                    <button class="filter-btn <%= "초등".equals(selectedCategory) ? "active" : "" %>" 
                            data-type="category" data-value="초등">초등학교</button>
                    <button class="filter-btn <%= "중등".equals(selectedCategory) ? "active" : "" %>" 
                            data-type="category" data-value="중등">중학교</button>
                    <button class="filter-btn <%= "고등".equals(selectedCategory) ? "active" : "" %>" 
                            data-type="category" data-value="고등">고등학교</button>
                </div>
            </div>
            
            <!-- 학년 필터 -->
            <div class="mb-3">
                <h6 class="text-muted mb-2"><i class="bi bi-calendar3 me-1"></i>학년</h6>
                <div class="filter-buttons" id="gradeButtons">
                    <button class="filter-btn <%= "전체".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="전체">전체</button>
                    <button class="filter-btn <%= "1학년".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="1학년">1학년</button>
                    <button class="filter-btn <%= "2학년".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="2학년">2학년</button>
                    <button class="filter-btn <%= "3학년".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="3학년">3학년</button>
                    <button class="filter-btn <%= "4학년".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="4학년">4학년</button>
                    <button class="filter-btn <%= "5학년".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="5학년">5학년</button>
                    <button class="filter-btn <%= "6학년".equals(selectedGrade) ? "active" : "" %>" 
                            data-type="grade" data-value="6학년">6학년</button>
                </div>
            </div>
            
            <!-- 과목 필터 -->
            <div class="mb-3">
                <h6 class="text-muted mb-2"><i class="bi bi-journal-text me-1"></i>과목</h6>
                <div class="filter-buttons" id="subjectButtons">
                    <button class="filter-btn <%= "전체".equals(selectedSubject) ? "active" : "" %>" 
                            data-type="subject" data-value="전체">전체</button>
                    <button class="filter-btn <%= "국어".equals(selectedSubject) ? "active" : "" %>" 
                            data-type="subject" data-value="국어">국어</button>
                    <button class="filter-btn <%= "수학".equals(selectedSubject) ? "active" : "" %>" 
                            data-type="subject" data-value="수학">수학</button>
                    <button class="filter-btn <%= "영어".equals(selectedSubject) ? "active" : "" %>" 
                            data-type="subject" data-value="영어">영어</button>
                    <button class="filter-btn <%= "사회".equals(selectedSubject) ? "active" : "" %>" 
                            data-type="subject" data-value="사회">사회</button>
                    <button class="filter-btn <%= "과학".equals(selectedSubject) ? "active" : "" %>" 
                            data-type="subject" data-value="과학">과학</button>
                </div>
            </div>
        </div>
        
        <!-- 검색 결과 요약 -->
        <div class="result-summary">
            <div class="result-text">
                <i class="bi bi-search me-2"></i>
                총 <strong><%= totalCount %></strong>개의 학습자료를 찾았습니다
            </div>
        </div>
        
        <!-- 자료 그리드 -->
        <% if (materials != null && !materials.isEmpty()) { %>
            <div class="material-grid">
                <% for (Material material : materials) { %>
                    <div class="material-card" data-material-id="<%= material.materialId() %>">
                        <div class="card-image">
                            <% if (material.thumbnailFilePaths() != null && !material.thumbnailFilePaths().isEmpty() 
                                   && !material.thumbnailFilePaths().get(0).trim().isEmpty()) { %>
                                <img src="<%= request.getContextPath() %>/<%= material.thumbnailFilePaths().get(0) %>" 
                                     alt="<%= material.materialTitle() %>" class="card-thumbnail"
                                     onerror="this.style.display='none'; this.parentNode.innerHTML='<i class=\'bi bi-file-earmark-text\'></i>';">
                            <% } else { %>
                                <i class="bi bi-file-earmark-text"></i>
                            <% } %>
                        </div>
                        
                        <div class="card-content">
                            <div class="card-main-info">
                                <div class="card-category">
                                    <%= material.materialCategory() %> • <%= material.materialGrade() %> • <%= material.materialSubject() %>
                                </div>
                                
                                <h5 class="card-title"><%= material.materialTitle() %></h5>
                                
                                <p class="card-instructor">
                                    <i class="bi bi-person-circle me-1"></i><%= material.instructorName() %>
                                </p>
                                
                                <div class="card-info">
                                    <span><i class="bi bi-file-text me-1"></i><%= material.materialPage() %>페이지</span>
                                    <span><i class="bi bi-star-fill me-1"></i><%= String.format("%.1f", material.materialRating()) %></span>
                                </div>
                                
                                <div class="card-price <%= material.materialPrice() == 0 ? "price-free" : "" %>">
                                    <% if (material.materialPrice() == 0) { %>
                                        <i class="bi bi-gift me-1"></i>무료
                                    <% } else { %>
                                        <i class="bi bi-currency-dollar me-1"></i><%= String.format("%,d", material.materialPrice()) %>원
                                    <% } %>
                                </div>
                            </div>
                            
                            <div class="card-bottom">
                                <div class="card-stats">
                                    <div class="stat-item">
                                        <i class="bi bi-eye"></i>
                                        <span><%= material.materialViewCount() %></span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="bi bi-download"></i>
                                        <span><%= material.materialDownloadCount() %></span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="bi bi-chat-dots"></i>
                                        <span><%= material.materialCommentCount() %></span>
                                    </div>
                                </div>
                                
                                <!-- 구매/다운로드 버튼 -->
                                <div class="card-actions">
                                    <% if (purchasedMaterialIds.contains(material.materialId())) { %>
                                        <!-- 이미 구매한 자료 -->
                                        <button class="btn-card-download" onclick="event.stopPropagation(); downloadMaterial(<%= material.materialId() %>, '<%= material.materialTitle() %>')">
                                            <i class="bi bi-download me-1"></i>다운로드
                                        </button>
                                    <% } else if (material.materialPrice() == 0) { %>
                                        <!-- 무료 자료 -->
                                        <button class="btn-card-download" onclick="event.stopPropagation(); downloadMaterial(<%= material.materialId() %>, '<%= material.materialTitle() %>')">
                                            <i class="bi bi-download me-1"></i>무료 다운로드
                                        </button>
                                    <% } else { %>
                                        <!-- 유료 자료 구매 -->
                                        <button class="btn-card-purchase" 
                                                onclick="event.stopPropagation(); purchaseMaterial(<%= material.materialId() %>, '<%= material.materialTitle() %>', <%= material.materialPrice() %>)"
                                                data-material-id="<%= material.materialId() %>">
                                            <i class="bi bi-cart-plus me-1"></i>구매하기
                                        </button>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            
            <!-- 페이징 -->
            <div class="pagination-container">
                <%= pageBar %>
            </div>
            
        <% } else { %>
            <div class="no-results">
                <i class="bi bi-inbox"></i>
                <h4>검색 결과가 없습니다</h4>
                <p>다른 조건으로 검색해보세요.</p>
            </div>
        <% } %>
    </div>
</div>

<script>
$(document).ready(function() {
    // 현재 선택된 필터값들
    let currentCategory = '<%= selectedCategory %>';
    let currentGrade = '<%= selectedGrade %>';
    let currentSubject = '<%= selectedSubject %>';
    
    // 필터 버튼 클릭 이벤트
    $('.filter-btn').click(function() {
        const type = $(this).data('type');
        const value = $(this).data('value');
        
        // 같은 타입의 다른 버튼들 비활성화
        $(this).siblings().removeClass('active');
        $(this).addClass('active');
        
        // 현재 값 업데이트
        if (type === 'category') {
            currentCategory = value;
            // 카테고리 변경시 학년 필터 조정
            adjustGradeButtons(value);
        } else if (type === 'grade') {
            currentGrade = value;
        } else if (type === 'subject') {
            currentSubject = value;
        }
        
        // 페이지 로드
        loadMaterials(1);
    });
    
    // 카드 클릭 이벤트 (상세페이지로 이동)
    $('.material-card').click(function() {
        const materialId = $(this).data('material-id');
        location.href = '<%= request.getContextPath() %>/market/detail.do?id=' + materialId;
    });
    
    // 카테고리에 따른 학년 버튼 조정
    function adjustGradeButtons(category) {
        const gradeButtons = $('#gradeButtons .filter-btn');
        
        if (category === '초등') {
            gradeButtons.hide();
            gradeButtons.filter('[data-value="전체"], [data-value="1학년"], [data-value="2학년"], [data-value="3학년"], [data-value="4학년"], [data-value="5학년"], [data-value="6학년"]').show();
        } else if (category === '중등' || category === '고등') {
            gradeButtons.hide();
            gradeButtons.filter('[data-value="전체"], [data-value="1학년"], [data-value="2학년"], [data-value="3학년"]').show();
        } else {
            gradeButtons.show();
        }
        
        // 현재 선택된 학년이 숨겨진 경우 전체로 변경
        if (!$('#gradeButtons .filter-btn.active').is(':visible')) {
            $('#gradeButtons .filter-btn.active').removeClass('active');
            $('#gradeButtons .filter-btn[data-value="전체"]').addClass('active');
            currentGrade = '전체';
        }
    }
    
    // 자료 목록 로드
    function loadMaterials(page) {
        const url = '<%= request.getContextPath() %>/market/list.do';
        const params = {
            category: currentCategory,
            grade: currentGrade,
            subject: currentSubject,
            cPage: page
        };
        
        // 페이지 이동
        location.href = url + '?' + $.param(params);
    }
    
    // 초기 로드시 학년 버튼 조정
    adjustGradeButtons(currentCategory);
    
    // 카드 호버 애니메이션
    $('.material-card').hover(
        function() {
            $(this).find('.card-image').css('transform', 'scale(1.05)');
        },
        function() {
            $(this).find('.card-image').css('transform', 'scale(1)');
        }
    );
    
    // 스크롤 애니메이션
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // 카드들에 애니메이션 적용
    $('.material-card').each(function(index) {
        $(this).css({
            'opacity': '0',
            'transform': 'translateY(30px)',
            'transition': 'all 0.6s ease'
        });
        
        setTimeout(() => {
            observer.observe(this);
        }, index * 100);
    });
});

// 로딩 스피너 표시/숨김
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

// 자료 구매하기
function purchaseMaterial(materialId, materialTitle, price) {
    <% if (loginUser == null) { %>
        alert('로그인이 필요한 서비스입니다.');
        location.href = '<%= request.getContextPath() %>/user/loginview.do';
        return;
    <% } %>
    
    if (!confirm(`'\${materialTitle}' 자료를 \${price.toLocaleString()}원에 구매하시겠습니까?`)) {
        return;
    }
    
    const button = $(`.btn-card-purchase[data-material-id="\${materialId}"]`);
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
                button.removeClass('btn-card-purchase')
                      .addClass('btn-card-download')
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

// 자료 다운로드
function downloadMaterial(materialId, materialTitle) {
    <% if (loginUser == null) { %>
        alert('로그인이 필요한 서비스입니다.');
        location.href = '<%= request.getContextPath() %>/user/loginview.do';
        return;
    <% } %>
    
    if (confirm(`'\${materialTitle}' 자료를 다운로드하시겠습니까?`)) {
        showSpinner('다운로드 준비 중...');
        
        // 다운로드 페이지로 이동
        location.href = '<%= request.getContextPath() %>/market/download.do?id=' + materialId;
        
        // 3초 후 스피너 숨김 (다운로드 시작 후)
        setTimeout(hideSpinner, 3000);
    }
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>