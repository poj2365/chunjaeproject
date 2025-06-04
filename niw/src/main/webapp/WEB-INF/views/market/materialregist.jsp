<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 <%@ page import="com.niw.market.model.dto.Material" %>
 <%@ include file="/WEB-INF/views/common/header.jsp"%>
 
<%
	String introduce=(String)request.getAttribute("introduce");
%>

<style>
:root {
	--main-color: rgb(36, 177, 181);
	--main-color-light: rgba(36, 177, 181, 0.1);
	--main-color-dark: rgb(30, 150, 153);
	--accent-color: rgb(255, 136, 0);
}

.main-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 2rem;
}

.main-color {
	color: var(--main-color);
}

.main-bg {
	background-color: var(--main-color);
	color: white;
}

.main-border {
	border-color: var(--main-color) !important;
}

.main-outline {
	color: var(--main-color);
	border-color: var(--main-color);
}

.main-outline:hover {
	background-color: var(--main-color);
	color: white;
}

.bg-main-light {
	background-color: var(--main-color-light);
}

.form-control:focus, .form-select:focus {
	border-color: var(--main-color);
	box-shadow: 0 0 0 0.25rem rgba(36, 177, 181, 0.25);
}

.accent-color {
	color: var(--accent-color);
}

.upload-card {
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
	overflow: hidden;
}

.upload-header {
	background-color: white;
	padding: 1.5rem;
	border-bottom: 2px solid var(--main-color);
}

.upload-body {
	padding: 2rem;
	background-color: white;
}

.form-label {
	font-weight: 500;
	margin-bottom: 0.5rem;
	color: #444;
}

.btn-main {
	background-color: var(--main-color);
	border-color: var(--main-color);
	color: white;
	font-weight: 500;
	padding: 0.6rem 1.5rem;
	border-radius: 5px;
	transition: all 0.3s;
}

.btn-main:hover {
	background-color: var(--main-color-dark);
	border-color: var(--main-color-dark);
	color: white;
}

.form-section {
	margin-bottom: 1.5rem;
}

.form-section-title {
	font-weight: 700;
	display: flex;
	align-items: center;
	margin-bottom: 1rem;
}

.dropdown-toggle {
	position: relative;
	cursor: pointer;
}

.dropdown-toggle::after {
	display: inline-block;
	content: "";
	width: 0;
	height: 0;
	margin-left: 8px;
	vertical-align: middle;
	border-top: 6px solid;
	border-right: 6px solid transparent;
	border-left: 6px solid transparent;
}

.preview-item {
	position: relative;
	border: 1px dashed #ccc;
	border-radius: 8px;
	padding: 1rem;
	margin-bottom: 1rem;
	transition: all 0.3s;
}

.preview-item:hover {
	border-color: var(--main-color);
	background-color: rgba(36, 177, 181, 0.03);
}

.delete-preview {
	position: absolute;
	top: 8px;
	right: 8px;
	background-color: rgba(255, 255, 255, 0.8);
	border-radius: 50%;
	width: 24px;
	height: 24px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	color: #f55;
	transition: all 0.2s;
}

.delete-preview:hover {
	background-color: #f55;
	color: white;
}

.file-upload {
	border: 2px dashed #ddd;
	border-radius: 10px;
	padding: 2rem;
	text-align: center;
	transition: all 0.3s;
	cursor: pointer;
}

.file-upload:hover {
	border-color: var(--main-color);
	background-color: rgba(36, 177, 181, 0.03);
}

.helper-text {
	display: block;
	color: #6c757d;
	font-size: 0.875rem;
	margin-top: 0.25rem;
}

.rules-card {
	border-radius: 10px;
	border: 1px solid rgba(0, 0, 0, 0.1);
	height: 100%;
}

.rules-card-header {
	background-color: var(--main-color);
	color: white;
	padding: 0.75rem 1.25rem;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	font-weight: 700;
}

.rules-card-body {
	padding: 1.25rem;
	font-size: 0.875rem;
}

/* Modal styles */
.modal-title {
	color: var(--main-color);
	font-weight: 700;
}

.modal-body {
	font-size: 0.9rem;
	line-height: 1.6;
}

/* Custom checkbox and radio styling */
.custom-control {
	display: flex;
	align-items: center;
	margin-bottom: 0.5rem;
}

.custom-control-input {
	display: none;
}

.custom-control-label {
	display: flex;
	align-items: center;
	cursor: pointer;
	margin-left: 10px;
}

.custom-control-label::before {
	content: '';
	display: inline-block;
	width: 22px;
	height: 22px;
	flex-shrink: 0;
	border: 2px solid #ddd;
	border-radius: 4px;
	margin-right: 0.5rem;
	transition: all 0.2s;
}

.spinner-border.main-color {
	color: var(--main-color);
}

/* PDF 미리보기 뷰어 스타일 - 새로 추가된 부분 */
.preview-viewer {
    border: 1px solid #e9ecef;
    border-radius: 10px;
    overflow: hidden;
    background: white;
    margin-top: 1rem;
}

.viewer-header {
    background: var(--main-color);
    color: white;
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.viewer-body {
    padding: 1.5rem;
}

.view-mode-toggle {
    display: flex;
    gap: 0.5rem;
}

.btn-view-mode {
    padding: 0.5rem 1rem;
    border: 1px solid rgba(255, 255, 255, 0.5);
    background: transparent;
    color: white;
    border-radius: 20px;
    font-size: 0.875rem;
    transition: all 0.3s ease;
    cursor: pointer;
}

.btn-view-mode.active,
.btn-view-mode:hover {
    background: rgba(255, 255, 255, 0.2);
    border-color: white;
}

.grid-viewer,
.book-viewer {
    display: none;
}

.grid-viewer.active,
.book-viewer.active {
    display: block;
}

.page-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.preview-page-card {
    border: 2px solid #e9ecef;
    border-radius: 8px;
    overflow: hidden;
    transition: all 0.3s ease;
    cursor: pointer;
    position: relative;
    background: white;
}

.preview-page-card:hover {
    border-color: var(--main-color);
    box-shadow: 0 4px 12px rgba(36, 177, 181, 0.15);
    transform: translateY(-2px);
}

.preview-page-card.selected {
    border-color: var(--main-color);
    background: var(--main-color-light);
}

/* 비활성화된 페이지 카드 스타일 */
.preview-page-card.disabled {
    opacity: 0.5;
    pointer-events: none;
    cursor: not-allowed;
}

.preview-page-card.disabled .preview-checkbox {
    cursor: not-allowed;
}

.preview-page-card.disabled .page-image {
    filter: grayscale(50%);
}

.page-image-container {
    position: relative;
    height: 250px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
}

.page-image {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.3s ease;
}

.preview-page-card:hover .page-image {
    transform: scale(1.05);
}

.page-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.preview-page-card:hover .page-overlay {
    opacity: 1;
}

.page-info {
    padding: 0.75rem;
    border-top: 1px solid #e9ecef;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.page-number {
    font-weight: 600;
    color: #495057;
}

.pagination-controls {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 1rem;
    margin: 1.5rem 0;
    flex-wrap: wrap;
}

.page-info-display {
    color: #6c757d;
    font-size: 0.9rem;
}

.btn-page {
    border: none;
    background: var(--main-color);
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    cursor: pointer;
}

.btn-page:hover:not(:disabled) {
    background: var(--main-color-dark);
    transform: scale(1.1);
}

.btn-page:disabled {
    background: #6c757d;
    cursor: not-allowed;
}

.page-input-group {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.page-input {
    width: 60px;
    text-align: center;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    padding: 0.25rem;
}

/* 책 형태 뷰어 스타일 */
.book-container {
    position: relative;
    background: #f8f9fa;
    border-radius: 10px;
    padding: 2rem;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.book-page {
    width: 100%;
    max-width: 600px;
    max-height: 800px;
    margin: 0 auto;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    transition: transform 0.5s ease;
    object-fit: contain;
}

.book-controls {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 2rem;
    margin-top: 1.5rem;
    flex-wrap: wrap;
}

.book-nav-btn {
    background: var(--main-color);
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 25px;
    font-weight: 500;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    cursor: pointer;
}

.book-nav-btn:hover:not(:disabled) {
    background: var(--main-color-dark);
    transform: translateY(-2px);
    color: white;
}

.book-nav-btn:disabled {
    background: #6c757d;
    cursor: not-allowed;
}

.selection-summary {
    background: var(--main-color-light);
    border: 1px solid var(--main-color);
    border-radius: 8px;
    padding: 1rem;
    margin-top: 1.5rem;
}

.selection-summary h6 {
    color: var(--main-color);
    margin-bottom: 0.5rem;
}

.selected-pages-list {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.selected-page-badge {
    background: var(--main-color);
    color: white;
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.8rem;
}

/* 비활성화된 체크박스 스타일 */
.preview-checkbox:disabled {
    cursor: not-allowed;
    opacity: 0.6;
}

.preview-checkbox:disabled + label {
    cursor: not-allowed;
    opacity: 0.6;
}

/* 책 뷰 체크박스 비활성화 스타일 */
#bookPageSelect:disabled {
    cursor: not-allowed;
    opacity: 0.6;
}

#bookPageSelect:disabled + label {
    cursor: not-allowed;
    opacity: 0.6;
}

/* 최대 선택 경고 스타일 */
#maximumWarning {
    font-weight: 500;
}

/* 반응형 */
@media (max-width: 768px) {
    .page-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 0.75rem;
    }
    
    .page-image-container {
        height: 180px;
    }
    
    .viewer-header {
        flex-direction: column;
        gap: 1rem;
        text-align: center;
    }
    
    .pagination-controls {
        gap: 0.5rem;
    }
    
    .book-controls {
        gap: 1rem;
    }
    
    .book-nav-btn {
        padding: 0.5rem 1rem;
        font-size: 0.875rem;
    }
    
    .book-container {
        padding: 1rem;
    }
    
    .book-page {
        max-width: 100%;
    }
}
</style>

<div class="main-container">
	<div class="row g-5">
		<!-- Main Form Column -->
		<div class="col-lg-8">
			<div class="upload-card">
				<div
					class="upload-header d-flex justify-content-between align-items-center">
					<h1 class="h3 mb-0 main-color fw-bold d-flex align-items-center">
						<i class="bi bi-journals me-2"></i> 학습자료 등록하기
					</h1>
					<button class="btn btn-sm btn-outline-secondary" type="button"
						data-bs-toggle="modal" data-bs-target="#termsModal">
						<i class="bi bi-question-circle me-1"></i> 자료 등록 규정 자세히보기
					</button>
				</div>

				<div class="upload-body">
					<form
						action="<%=request.getContextPath()%>/market/registMaterial.do"
						method="post" >
						<!-- 자료 정보 섹션 -->
						<div class="form-section">
							<h3 class="form-section-title">
								<i class="bi bi-info-circle-fill main-color me-2"></i> 자료 정보
							</h3>

							<div class="mb-3">
								<label for="materialTitle" class="form-label">자료 제목</label> <input
									type="text" class="form-control" id="materialTitle"
									name="materialTitle" placeholder="자료의 제목을 입력해주세요" required>
								<small class="helper-text">검색에 잘 노출될 수 있는 명확한 제목을
									작성해주세요.</small>
							</div>

							<div class="row mb-3">
								<div class="col-md-4">
									<label class="form-label">자료 카테고리</label> <select
										class="form-select" name="category" required>
										<option value="">선택해주세요</option>
										<option value="초등학교">초등학교</option>
										<option value="중학교">중학교</option>
										<option value="고등학교">고등학교</option>
										<option value="기타">기타</option>
									</select>
								</div>
								<div class="col-md-4">
									<label class="form-label">학년</label> <select
										class="form-select" name="grade">
										<option value="">선택해주세요</option>

									</select>
								</div>
								<div class="col-md-4">
									<label class="form-label">과목</label> <select
										class="form-select" name="subject">
										<option value="">선택해주세요</option>
										<option value="국어">국어</option>
										<option value="영어">영어</option>
										<option value="수학">수학</option>
										<option value="과학">과학</option>
										<option value="사회">사회</option>
										<option value="기타">기타</option>
									</select>
								</div>
							</div>

							<div class="mb-3">
								<label class="form-label">판매가격</label>
								<div class="input-group">
									<input type="number" class="form-control" name="price"
										placeholder="자료의 판매 가격을 입력해주세요" min="1000" step="100" required> <span
										class="input-group-text">원</span>
								</div>
								<small class="helper-text">100원 단위로 최소 1,000원부터 설정 가능합니다.</small>
							</div>

							<div class="mb-3">
								<label class="form-label">자료파일</label>
								<div class="file-upload" id="fileUpload"
									style="position: relative; z-index: 1;">
									<i class="bi bi-file-earmark-pdf fs-1 main-color"></i>
									<p class="mb-0 mt-2">PDF 파일을 끌어서 놓거나 클릭하여 업로드</p>
									<small class="text-muted d-block mt-1">PDF 파일만 업로드 가능
										(최대 50MB)</small> <input type="file" id="fileInput" name="uploadFile"
										class="d-none" accept=".pdf" required>
								</div>

					
							
							</div>
						</div>

						<!-- 미리보기 페이지 섹션 -->
						<div class="form-section">
							<h3 class="form-section-title">
								<i class="bi bi-eye-fill main-color me-2"></i> 미리보기 페이지
							</h3>

							<div class="alert alert-info" role="alert">
								<i class="bi bi-info-circle me-2"></i> <strong>자동 미리보기
									생성</strong><br> 업로드한 PDF 파일에서 자동으로 미리보기 페이지가 생성됩니다. 파일 등록 후 원하는
								페이지를 선택하여 미리보기로 설정할 수 있습니다. (최대 3페이지)
							</div>

							<div class="preview-items mb-3" id="previewContainer">
								<!-- 자료 업로드 후 PDF API를 통해 미리보기가 자동 생성됩니다 -->
								<div class="text-center py-4 text-muted">
									<i class="bi bi-file-earmark-pdf fs-1 mb-2"></i>
									<p class="mb-0">PDF 파일을 먼저 업로드해주세요.</p>
									<small>업로드 후 미리보기 페이지를 선택할 수 있습니다.</small>
								</div>
							</div>
						</div>

						<!-- 강사 소개 및 자료 소개 섹션 -->
						<div class="form-section">
							<h3 class="form-section-title">
								<i class="bi bi-person-fill main-color me-2"></i> 강사 소개 / 자료 설명
							</h3>

							<div class="mb-3">
								<label class="form-label">강사 소개</label>
								<textarea class="form-control" name="teacherIntro" rows="3"
									><%=introduce %></textarea>
							</div>

							<div class="mb-3">
								<label class="form-label">자료 소개</label>
								<textarea class="form-control" name="materialDescription"
									rows="5" placeholder="학습자료에 대한 상세한 설명을 작성해주세요." required></textarea>
								<small class="helper-text">자료의 특징, 대상, 학습 목표 등을 포함하면
									좋습니다.</small>
							</div>
						</div>

						<!-- 제출 버튼 -->
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button class="btn btn-outline-secondary me-md-2" type="button"
              onclick="cancleRegist()">등록취소</button>
							<button class="btn btn-outline-secondary me-md-2" type="button"
								onclick="saveDraft()">임시저장</button>
							<button class="btn btn-main" type="submit">
								<i class="bi bi-journal-check me-1"></i> 학습자료 등록하기
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Right Side Rules Column -->
		<div class="col-lg-4">
			<div class="rules-card sticky-top" style="top: 20px;">
				<div class="rules-card-header">
					<i class="bi bi-clipboard2-check me-2"></i> 자료등록 규정 안내
				</div>
				<div class="rules-card-body">
					<div class="mb-4">
						<p class="fw-medium mb-3">
							<strong class="text-dark">"학습메이트"</strong> 온라인서비스 사업자(이하 "운영자")에
							대하여 콘텐츠 공유 또는 판매등록을 신청한 회원(이하 "회원")은 다음과 같은 사항을 확인하고 이에 대하여 본
							서약서에 동의합니다.
						</p>
						<ol class="ps-3 mb-3">
							<li class="mb-2">"회원"이 등록 신청한 콘텐츠에 대하여 "회원"은 저작권법 및 기타 관련법령
								그리고 "운영자"의 약관, 콘텐츠 공유 및 판매에 관한 약관를 숙지하고 확인하였습니다.</li>
							<li class="mb-2">"회원"이 등록 신청한 콘텐츠의 저작권리 및 사용권 일체는 "회원"에게 있음을
								확인합니다.</li>
							<li class="mb-2">"회원"이 등록 신청한 콘텐츠는 저작권법 및 기타 관련 법령에 저촉되지 않음을
								확인합니다.</li>
							<li class="mb-2">"회원"이 등록 신청한 콘텐츠의 재등록 불가 및 재등록 가능한 보류 처리에
								대한 이의 신청시 "운영자"의 결정과 조치에 대해 일체 이의를 제기하지 않음을 확인합니다.</li>
							<li class="mb-2">"회원"이 등록 신청한 콘텐츠는 명예훼손, 민.형사상 책임은 "회원"에게
								있음을 확인합니다.</li>
							<li class="mb-2">회원가입 시 또는 콘텐츠 등록 신청 시 "운영자"에 제공한 "회원"의
								개인정보는 모두 거짓이 없음을 확인합니다.</li>
						</ol>
					</div>

					<h6 class="fw-bold mb-2">【자료등록 규정】</h6>
					<p class="mb-3">다음 자료는 업로드가 제한되어 있으니 자료등록시 참고해주세요.</p>

					<h6 class="fw-bold mb-2 main-color">【업로드 불가】</h6>
					<ul class="ps-3 mb-3">
						<li class="mb-1">저작권에 위배되는 자료를 올리는 경우</li>
						<li class="mb-1">타인의 개인정보가 포함되어 있는 자료</li>
						<li class="mb-1">정치적, 종교적 활동 등의 홍보자료</li>
						<li class="mb-1">자극적인 내용이나 청소년 유해물</li>
						<li class="mb-1">영리목적의 광고나 홍보글</li>
					</ul>

					<h6 class="fw-bold mb-2 main-color">【자료파일 규정】</h6>
					<ul class="ps-3 mb-3">
						<li class="mb-1">파일 형식: PDF만 가능</li>
						<li class="mb-1">파일 최대 크기: 50MB</li>
						<li class="mb-1">PDF 파일은 비밀번호가 설정되지 않아야 함</li>
						<li class="mb-1">다운로드 테스트 후 업로드 필수</li>
					</ul>

					<h6 class="fw-bold mb-2 main-color">【미리보기 페이지】</h6>
					<ul class="ps-3 mb-3">
						<li class="mb-1">업로드한 PDF에서 자동으로 미리보기 생성</li>
						<li class="mb-1">PDF 문서의 각 페이지를 이미지로 추출</li>
						<li class="mb-1">최소 1페이지, 최대 3페이지까지 미리보기 선택 가능</li>
						<li class="mb-1">자료의 내용을 확인할 수 있는 대표적인 페이지 선택</li>
					</ul>

					<h6 class="fw-bold mb-2 main-color">【자료 소개 작성】</h6>
					<ul class="ps-3 mb-3">
						<li class="mb-1">자료의 특징과 내용을 명확하게 설명</li>
						<li class="mb-1">대상학년, 학습목표, 활용방법 등 포함</li>
						<li class="mb-1">오탈자가 없도록 검토 필수</li>
					</ul>

					<h6 class="fw-bold mb-2 main-color">【판매가격 설정】</h6>
					<ul class="ps-3 mb-3">
						<li class="mb-1">최소 판매가 1,000원부터 설정 가능</li>
						<li class="mb-1">판매가의 30%는 사이트 수수료로 차감</li>
						<li class="mb-1">판매수익은 매월 15일 정산</li>
					</ul>

					<h6 class="fw-bold mb-2 main-color">【유의사항】</h6>
					<ul class="ps-3 mb-3">
						<li class="mb-1">모든 업로드 자료는 관리자 검수 후 게시됩니다.</li>
						<li class="mb-1">검수에는 영업일 기준 1~3일이 소요됩니다.</li>
						<li class="mb-1">규정 위반 시 자료 삭제 및 계정 정지될 수 있습니다.</li>
					</ul>

					<div class="bg-main-light p-3 rounded mt-4">
						<p class="fw-bold mb-2">
							<i class="bi bi-shield-check me-1"></i> 자료등록 전 확인사항
						</p>
						<div class="form-check mb-2">
							<input class="form-check-input" type="checkbox" id="check1"
								required> <label class="form-check-label" for="check1">
								자료의 저작권을 보유하고 있거나 이용허락을 받았습니다. </label>
						</div>
						<div class="form-check mb-2">
							<input class="form-check-input" type="checkbox" id="check2"
								required> <label class="form-check-label" for="check2">
								자료 등록 규정을 읽고 이에 동의합니다. </label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="check3"
								required> <label class="form-check-label" for="check3">
								허위자료 및 규정 위반 시 제재를 받을 수 있음을 이해합니다. </label>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="termsModal" tabindex="-1"
	aria-labelledby="termsModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="termsModalLabel">
					<i class="bi bi-file-earmark-text me-2"></i> 【학습메이트】 학습자료 판매 및 구매
					이용약관
				</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h6 class="fw-bold mb-3">【분쟁해결】</h6>
				<ol>
					<li>본 계약과 관련하여 양 당사자간 또는 제3자간의 분쟁이 발생한 경우 원칙적으로 상호간의 협의에 의해
						해결한다.</li>
					<li>제1항에도 불구하고 분쟁이 해결되지 않을 경우 "운영자"의 주소지 관할 지방법원을 그 관할로 하여
						재판함으로써 해결한다.</li>
				</ol>

				<h6 class="fw-bold mb-3 mt-4">【학습자료 판매】</h6>
				<ol>
					<li>학습자료 판매자는 학습메이트 규정에 맞는 인증절차를 통해 학습자료 판매등록 권한을 얻어 학습자료를 판매할
						수 있다. 인증절차를 통해 판매권한을 승인받아도 업로드한 학습자료가 학습메이트 규정에 맞지 않는다면, 운영자는 해당
						자료와 판매권한을 무통보 삭제할 수 있다.</li>
					<li>회원은 아래 각 호에 해당되는 콘텐츠 자료는 등록할 수 없다.
						<ul class="mt-2">
							<li>회원이 저작권 및 사용권을 보유하고 있지 않으며 제3자의 저작권 및 사용권 등 기타 권리를 침해하는
								자료</li>
							<li>공공 안녕질서 및 미풍양속에 위배되는 내용을 포함하는 자료</li>
							<li>다른 회원 또는 제3자에게 불이익을 주거나 명예를 손상시키는 자료</li>
							<li>기술 및 영업비밀을 포함하고 있어 회사 기밀이 유출될 수 있는 자료</li>
							<li>타인의 개인정보를 유출하는 자료</li>
							<li>불법복제 또는 해킹을 조장하는 자료</li>
							<li>학습메이트에 이미 동일(유사)한 자료를 판매하고 있는 경우</li>
							<li>기타 학습메이트의 서비스 운영기준에 미흡된다고 판단되는 경우</li>
						</ul>
					</li>
				</ol>

				<h6 class="fw-bold mb-3 mt-4">【학습자료 판매금 정산】</h6>
				<ol>
					<li>판매수익금은 포인트로 전환되지 않으며, 따로 "출금신청"을 통해 정산된다.</li>
					<li>"출금신청" 이후 "입금일"은 출금신청한 날로부터 영업일 기준 최대 14일 이내 회원님의 은행계좌에
						입금하기로 한다.</li>
				</ol>

				<h6 class="fw-bold mb-3 mt-4">【학습자료 구매】</h6>
				<ol>
					<li>포인트를 충전하여 학습자료를 구매할 수 있다.</li>
					<li>미사용 포인트는 포인트 결제일로 부터 1년 이내 수수료 10%를 제외하고 환불요청 할 수 있다.</li>
					<li>"환불요청" 이후 "미사용 포인트 환불"은 신청한 날로부터 영업일 기준 최대 14일 이내 회원님의
						은행계좌에 입금하기로 한다.</li>
				</ol>

				<h6 class="fw-bold mb-3 mt-4">【저작권 및 사용권의 귀속 및 책임】</h6>
				<ol>
					<li>회원이 등록한 자료에 대한 저작권 및 기타 지적재산권은 해당 회원에 귀속하며 운영자는 기간 및 용도의
						제한없이 서비스 이용권 및 2차 저작권, 복제, 배포, 전송 등의 사용권을 가진다.</li>
					<li>운영자는 회원이 등록한 문서를 계속적으로 서비스할 수 있으나 회원의 요청이 있을시에는 해당 자료를 삭제할
						수 있다. 단 다음 각호에 해당하는 사항에 대해서는 아래 절차에 의해 처리하도록 한다.</li>
					<li>회원이 등록한 자료가 제3자의 저작권 및 사용권, 개인정보, 기술 및 영업비밀 등 타인의 권리 또는
						이익을 침해하는 경우 또는 서비스 이용으로 인하여 이용자에게 피해를 입은 경우, 해당회원은 배상책임을 비롯하여 그로
						인해 발생한 분쟁에 대한 민· 형사상의 법적 책임을 진다.</li>
				</ol>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-main" data-bs-dismiss="modal">동의하고
					계속하기</button>
			</div>
		</div>
	</div>
</div>

<script>
  // 1) 카테고리별 학년 맵핑
const gradeMap = {
  '초등학교': ['1학년','2학년','3학년','4학년','5학년','6학년'],
  '중학교':   ['1학년','2학년','3학년'],
  '고등학교': ['1학년','2학년','3학년'],
  '기타':     []
};

// 2) 이벤트 바인딩
$('select[name="category"]').on('change', function() {
  const cat = $(this).val();
  const grades = gradeMap[cat] || [];
  const $grade = $('select[name="grade"]');
  
  // 3) 기존 옵션 지우고 기본 추가
  $grade.empty()
        .append('<option value="">선택해주세요</option>');
  
  // 4) 해당 카테고리 학년만 추가
  grades.forEach(g => {
    $grade.append(`<option value="\${g}">\${g}</option>`);
  });
  
  // 5) 기타 등 옵션 없을 땐 select 비활성화 (선택 안 되도록)
  if (grades.length === 0) {
    $grade.prop('disabled', true);
  } else {
    $grade.prop('disabled', false);
  }
});

// 6) 페이지 로드 시에도 현재 상태 반영
$(function(){
  $('select[name="category"]').trigger('change');
});


// PDF 미리보기 뷰어 클래스 - 수정된 부분
class PDFPreviewViewer {
  constructor() {
    this.pages = [];
    this.selectedPages = new Set();
    this.currentViewPage = 1;
    this.pagesPerView = 6; // 한 번에 6개 페이지만 표시
    this.currentBookPage = 1;
    this.viewMode = 'grid';
    this.userId = '';
    this.contextPath = '';
    
    this.init();
  }
  
  init() {
    this.bindEvents();
  }
  
  bindEvents() {
    // 뷰 모드 전환
    $(document).on('click', '.btn-view-mode', (e) => {
      const mode = $(e.target).data('mode');
      this.switchViewMode(mode);
    });
    
    // 격자 뷰 페이지네이션
    $(document).on('click', '#prevPage', () => {
      if (this.currentViewPage > 1) {
        this.currentViewPage--;
        this.renderGridPages();
        this.updatePaginationControls();
      }
    });
    
    $(document).on('click', '#nextPage', () => {
      const totalViewPages = Math.ceil(this.pages.length / this.pagesPerView);
      if (this.currentViewPage < totalViewPages) {
        this.currentViewPage++;
        this.renderGridPages();
        this.updatePaginationControls();
      }
    });
    
    // 페이지 직접 입력
    $(document).on('change', '#currentPageInput', (e) => {
      const page = parseInt($(e.target).val());
      const totalViewPages = Math.ceil(this.pages.length / this.pagesPerView);
      if (page >= 1 && page <= totalViewPages) {
        this.currentViewPage = page;
        this.renderGridPages();
        this.updatePaginationControls();
      } else {
        $(e.target).val(this.currentViewPage);
      }
    });
    
    // 책 뷰 네비게이션
    $(document).on('click', '#bookPrevBtn', () => {
      if (this.currentBookPage > 1) {
        this.currentBookPage--;
        this.renderBookPage();
        this.updateBookControls();
      }
    });
    
    $(document).on('click', '#bookNextBtn', () => {
      if (this.currentBookPage < this.pages.length) {
        this.currentBookPage++;
        this.renderBookPage();
        this.updateBookControls();
      }
    });
    
    // 책 뷰 페이지 선택 - 수정된 부분
    $(document).on('change', '#bookPageSelect', (e) => {
      if ($(e.target).is(':checked')) {
        // 최대 3개 제한 체크
        if (this.selectedPages.size >= 3) {
          e.preventDefault();
          $(e.target).prop('checked', false);
          alert('미리보기 페이지는 최대 3페이지까지만 선택할 수 있습니다.');
          return;
        }
        this.selectedPages.add(this.currentBookPage);
      } else {
        this.selectedPages.delete(this.currentBookPage);
      }
      this.updateSelectedPagesDisplay();
      this.updateCheckboxStates();
    });
  }
  
  switchViewMode(mode) {
    this.viewMode = mode;
    
    // 버튼 상태 업데이트
    $('.btn-view-mode').removeClass('active');
    $(`.btn-view-mode[data-mode="\${mode}"]`).addClass('active');
    
    // 뷰어 표시/숨김
    $('.grid-viewer').toggleClass('active', mode === 'grid');
    $('.book-viewer').toggleClass('active', mode === 'book');
    
    if (mode === 'book') {
      this.renderBookPage();
      this.updateBookControls();
    }
  }
  
  loadPages(pages, fileName, userId, contextPath) {
    this.pages = pages.map((page, index) => ({
      url: `\${contextPath}/resources/upload/market/\${userId}/material/previews/\${page}`,
      pageNumber: index + 1,
      filename: page
    }));
    
    console.log(`총 \${this.pages.length}개 페이지 로드됨, 페이지당 \${this.pagesPerView}개씩 표시`);
    
    this.userId = userId;
    this.contextPath = contextPath;
    this.currentViewPage = 1;
    this.currentBookPage = 1;
    this.selectedPages.clear();
    
    // 처음 3페이지 자동 선택 (최대 3페이지)
    for (let i = 1; i <= Math.min(3, this.pages.length); i++) {
      this.selectedPages.add(i);
    }
    
    this.renderGridPages();
    this.updatePaginationControls();
    this.updateSelectedPagesDisplay();
    this.updateCheckboxStates();
    
    if (this.viewMode === 'book') {
      this.renderBookPage();
      this.updateBookControls();
    }
  }
  
  renderGridPages() {
    const startIndex = (this.currentViewPage - 1) * this.pagesPerView;
    const endIndex = Math.min(startIndex + this.pagesPerView, this.pages.length);
    const currentPages = this.pages.slice(startIndex, endIndex);
    
    console.log(`페이지네이션: \${startIndex}-\${endIndex}, 표시할 페이지: \${currentPages.length}개`);
    
    const grid = $('#pageGrid');
    grid.empty();
    
    // 확실히 제한된 개수만 표시
    if (currentPages.length === 0) {
      grid.html('<div class="col-12 text-center text-muted">표시할 페이지가 없습니다.</div>');
      return;
    }
    
    currentPages.forEach((page, index) => {
      const actualPageNum = startIndex + index + 1;
      const isSelected = this.selectedPages.has(actualPageNum);
      
      const pageCard = $(`
        <div class="preview-page-card \${isSelected ? 'selected' : ''}" data-page="\${actualPageNum}">
          <div class="page-image-container">
            <img class="page-image" src="\${encodeURI(page.url)}" alt="페이지 \${actualPageNum}"
                 >
            <div class="page-overlay">
              <i class="bi bi-eye text-white fs-1"></i>mar
            </div>
          </div>
          <div class="page-info">
            <span class="page-number">페이지 \${actualPageNum}</span>
            <div class="form-check">
              <input class="form-check-input preview-checkbox" type="checkbox" 
                     id="page\${actualPageNum}" name="selectedPages" value="\${actualPageNum}" 
                     \${isSelected ? 'checked' : ''}>
              <label class="form-check-label" for="page\${actualPageNum}">
                선택
              </label>
            </div>
          </div>
        </div>
      `);
      
      // 페이지 선택 이벤트 - 수정된 부분
      pageCard.find('.preview-checkbox').on('change', (e) => {
        const pageNum = parseInt($(e.target).val());
        if ($(e.target).is(':checked')) {
          // 최대 3개 제한 체크
          if (this.selectedPages.size >= 3) {
            e.preventDefault();
            $(e.target).prop('checked', false);
            alert('미리보기 페이지는 최대 3페이지까지만 선택할 수 있습니다.');
            return;
          }
          this.selectedPages.add(pageNum);
          pageCard.addClass('selected');
        } else {
          this.selectedPages.delete(pageNum);
          pageCard.removeClass('selected');
        }
        this.updateSelectedPagesDisplay();
        this.updateCheckboxStates();
      });
      
      // 카드 클릭으로도 선택 가능
      pageCard.on('click', (e) => {
        if (!$(e.target).is('input, label')) {
          const checkbox = pageCard.find('.preview-checkbox');
          checkbox.prop('checked', !checkbox.prop('checked')).trigger('change');
        }
      });
      
      grid.append(pageCard);
    });
    
    console.log(`실제 렌더링된 페이지 카드: \${grid.children().length}개`);
  }
  
  renderBookPage() {
    if (this.pages.length === 0) return;
    
    const bookPage = $('#bookPage');
    const currentPage = this.pages[this.currentBookPage - 1];
    
    if (currentPage) {
      bookPage.attr('src', currentPage.url);
      bookPage.attr('alt', `페이지 \${this.currentBookPage}`);
    }
    
    // 선택 상태 업데이트
    const checkbox = $('#bookPageSelect');
    const isSelected = this.selectedPages.has(this.currentBookPage);
    checkbox.prop('checked', isSelected);
    
    // 체크박스 비활성화 상태 업데이트
    const isMaxSelected = this.selectedPages.size >= 3;
    if (!isSelected) {
      checkbox.prop('disabled', isMaxSelected);
    } else {
      checkbox.prop('disabled', false);
    }
  }
  
  updatePaginationControls() {
    const totalViewPages = Math.ceil(this.pages.length / this.pagesPerView);
    
    $('#prevPage').prop('disabled', this.currentViewPage === 1);
    $('#nextPage').prop('disabled', this.currentViewPage === totalViewPages);
    $('#currentPageInput').val(this.currentViewPage);
    $('#totalPages').text(totalViewPages);
    
    const startPage = (this.currentViewPage - 1) * this.pagesPerView + 1;
    const endPage = Math.min(startPage + this.pagesPerView - 1, this.pages.length);
    $('#pageRangeInfo').text(`\${startPage}-\${endPage} / \${this.pages.length}`);
  }
  
  updateBookControls() {
    $('#bookPrevBtn').prop('disabled', this.currentBookPage === 1);
    $('#bookNextBtn').prop('disabled', this.currentBookPage === this.pages.length);
    $('#bookCurrentPage').text(this.currentBookPage);
    $('#bookTotalPages').text(this.pages.length);
  }
  
  // 수정된 함수
  updateSelectedPagesDisplay() {
    const selectedArray = Array.from(this.selectedPages).sort((a, b) => a - b);
    const selectedList = $('#selectedPagesList');
    const selectedCount = $('#selectedCount');
    const maximumWarning = $('#maximumWarning');
    
    selectedCount.text(selectedArray.length);
    maximumWarning.toggle(selectedArray.length >= 3);
    
    if (selectedArray.length === 0) {
      selectedList.html('<span class="text-muted">아직 선택된 페이지가 없습니다.</span>');
    } else {
      selectedList.html(selectedArray.map(page => 
        `<span class="selected-page-badge">페이지 \${page}</span>`
      ).join(''));
    }
  }
  
  // 새로 추가된 함수 - 체크박스 상태 업데이트
  updateCheckboxStates() {
    const isMaxSelected = this.selectedPages.size >= 3;
    
    // 격자 뷰의 체크박스들 상태 업데이트
    $('.preview-checkbox').each((index, checkbox) => {
      const pageNum = parseInt($(checkbox).val());
      const isCurrentSelected = this.selectedPages.has(pageNum);
      
      // 선택되지 않은 체크박스들을 비활성화/활성화
      if (!isCurrentSelected) {
        $(checkbox).prop('disabled', isMaxSelected);
        $(checkbox).closest('.preview-page-card').toggleClass('disabled', isMaxSelected);
      }
    });
    
    // 책 뷰의 체크박스 상태 업데이트
    const bookCheckbox = $('#bookPageSelect');
    if (bookCheckbox.length) {
      const isBookPageSelected = this.selectedPages.has(this.currentBookPage);
      if (!isBookPageSelected) {
        bookCheckbox.prop('disabled', isMaxSelected);
      }
    }
  }
  
  getSelectedPages() {
    return Array.from(this.selectedPages).sort((a, b) => a - b);
  }
  
  // 페이지당 표시 개수 변경 함수 추가
  setPagesPerView(count) {
    this.pagesPerView = count;
    this.currentViewPage = 1; // 첫 페이지로 리셋
    this.renderGridPages();
    this.updatePaginationControls();
    console.log(`페이지당 표시 개수를 \${count}개로 변경했습니다.`);
  }
}

// 전역 뷰어 인스턴스
let pdfViewer = null;
let savedFileName = null;

// 새로운 displayPreviewPages 함수 - 기존 함수를 완전히 교체
function displayPreviewPages(pages, fileName) {
  const userId = '<%=loginUser != null ? loginUser.userId() : ""%>';
  const contextPath = '<%=request.getContextPath()%>';
  
  if (!userId) {
    console.error('사용자 ID가 없습니다.');
    handlePreviewError('사용자 인증이 필요합니다.');
    return;
  }
  
  // 뷰어 HTML 구조 생성
  const viewerHtml = `
    <div class="preview-viewer">
      <div class="viewer-header">
        <div>
          <h5 class="mb-0 text-white">
            <i class="bi bi-file-earmark-pdf me-2"></i>
            PDF 미리보기 선택 (\${fileName})
          </h5>
          <small class="opacity-75">미리보기로 사용할 페이지를 선택해주세요 (최대 3페이지)</small>
        </div>
        <div class="view-mode-toggle">
          <button type="button" class="btn-view-mode active" data-mode="grid">
            <i class="bi bi-grid-3x3-gap me-1"></i> 격자
          </button>
          <button type="button" class="btn-view-mode" data-mode="book">
            <i class="bi bi-book me-1"></i> 책
          </button>
        </div>
      </div>

      <div class="viewer-body">
        <!-- 격자 뷰 -->
        <div class="grid-viewer active">
          <div class="pagination-controls">
            <button type="button" class="btn-page" id="prevPage" disabled>
              <i class="bi bi-chevron-left"></i>
            </button>
            
            <div class="page-input-group">
              <input type="number" class="page-input" id="currentPageInput" value="1" min="1">
              <span class="page-info-display">/ <span id="totalPages">1</span></span>
            </div>
            
            <button type="button" class="btn-page" id="nextPage">
              <i class="bi bi-chevron-right"></i>
            </button>
            
            <div class="page-info-display ms-3">
              <span id="pageRangeInfo">1-6 / 1</span> 페이지
            </div>
          </div>

          <div class="page-grid" id="pageGrid">
            <!-- 페이지들이 여기에 동적으로 생성됩니다 -->
          </div>
        </div>

        <!-- 책 뷰 -->
        <div class="book-viewer">
          <div class="book-container">
            <div class="text-center">
              <img class="book-page" id="bookPage" src="" alt="PDF 페이지">
            </div>
            
            <div class="book-controls">
              <button type="button" class="book-nav-btn" id="bookPrevBtn" disabled>
                <i class="bi bi-chevron-left"></i> 이전
              </button>
              
              <div class="d-flex align-items-center gap-3">
                <span class="fw-bold">페이지 <span id="bookCurrentPage">1</span> / <span id="bookTotalPages">1</span></span>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="bookPageSelect">
                  <label class="form-check-label" for="bookPageSelect">
                    미리보기로 선택
                  </label>
                </div>
              </div>
              
              <button type="button" class="book-nav-btn" id="bookNextBtn">
                다음 <i class="bi bi-chevron-right"></i>
              </button>
            </div>
          </div>
        </div>

        <!-- 선택된 페이지 요약 -->
        <div class="selection-summary">
          <h6><i class="bi bi-check2-circle me-1"></i> 선택된 미리보기 페이지</h6>
          <div class="selected-pages-list" id="selectedPagesList">
            <span class="text-muted">아직 선택된 페이지가 없습니다.</span>
          </div>
          <div class="mt-2">
            <small class="text-muted">
              선택된 페이지: <span id="selectedCount">0</span>개 / 최대 3개
              <span class="text-warning ms-2" id="maximumWarning" style="display: none;">
                (최대 3페이지까지 선택 가능)
              </span>
            </small>
          </div>
        </div>
      </div>
    </div>
  `;
  
  $('#previewContainer').html(viewerHtml);
  
  // 뷰어 인스턴스 생성 및 페이지 로드
  if (!pdfViewer) {
    pdfViewer = new PDFPreviewViewer();
  }
  
  pdfViewer.loadPages(pages, fileName, userId, contextPath);
}

$(document).ready(function() {
	  console.log('문서 로드 완료');
	  
	  let selectedFile = null;
	  let isProcessing = false; // 처리 중 플래그 추가
	  
	  // File upload functionality - 간단하고 확실한 방법
	  $('#fileUpload').on('click', function() {
	    console.log('파일 업로드 영역 클릭됨');
	    
	    // 처리 중이면 리턴
	    if (isProcessing) {
	      console.log('현재 파일 처리 중입니다.');
	      return;
	    }
	    
	    // 파일 입력 요소 찾기
	    const fileInput = document.getElementById('fileInput');
	    console.log('파일 입력 요소:', fileInput);
	    
	    if (fileInput) {
	      try {
	        fileInput.click();
	        console.log('파일 선택 창 열기 시도');
	      } catch (error) {
	        console.error('파일 선택 창 열기 실패:', error);
	      }
	    } else {
	      console.error('fileInput 요소를 찾을 수 없습니다.');
	    }
	  });
	  
	  $('#fileInput').on('change', function(e) {
	    e.stopPropagation(); // 이벤트 전파 중단
      $.ajax({
        url : '<%=request.getContextPath()%>/market/cancleRegist.do',
        type : 'POST',
        data : {"savedFileName": savedFileName},
        success(){
        
        }

      })
	    console.log('파일 선택 이벤트 발생', this.files);
	    
	    if (this.files && this.files.length > 0 && !isProcessing) {
	      handleFileSelection(this.files[0]);
	    }
	  });
	  
	  // 파일 선택 처리 함수
	  function handleFileSelection(file) {
	    if (isProcessing) return;
	    
	    const fileName = file.name;
	    const fileSize = (file.size / 1024 / 1024).toFixed(2);
	    const fileExtension = fileName.split('.').pop().toLowerCase();
	    
	    console.log('선택된 파일:', fileName, '크기:', fileSize + 'MB', '확장자:', fileExtension);
	    
	    // 파일 크기 검증 (50MB)
	    if (file.size > 50 * 1024 * 1024) {
	      alert('파일 크기는 50MB를 초과할 수 없습니다.');
	      resetFileInput();
	      return;
		
	    }
			
	    // PDF 파일 확인
	    if (fileExtension === 'pdf') {
	      selectedFile = file;
	      updateFileDisplay(fileName, fileSize, '미리보기 생성 중...');
	      uploadAndGeneratePreview(file);
	    } else {
	      alert('PDF 파일만 업로드 가능합니다.');
	      resetFileInput();
	    }
	  }
		
	  // 파일 입력 초기화
	  function resetFileInput() {
	    $('#fileInput').val('');
	    selectedFile = null;
	    isProcessing = false;
	    $('#fileUpload p').text('PDF 파일을 끌어서 놓거나 클릭하여 업로드');
	  }
	  	
	  // 파일 표시 업데이트
	  function updateFileDisplay(fileName, fileSize, status) {
	    $('#fileUpload p').text(`\${fileName} (\${fileSize}MB) - \${status}`);
	  }
	  
	  // AJAX로 PDF 업로드 및 미리보기 생성
	  function uploadAndGeneratePreview(file) {
	    if (isProcessing) return;
	    isProcessing = true;
	    
	    const formData = new FormData();
	    formData.append('uploadFile', file);
	    
	    $.ajax({
	      url: '<%=request.getContextPath()%>/market/generatePreview.do',
	      type: 'POST',
	      data: formData,
	      processData: false,
	      contentType: false,
	      timeout: 30000,
	      enctype: 'multipart/form-data',
	      success: function(response) {
	        try { 
            debugger;
	          const result = typeof response === 'string' ? JSON.parse(response) : response;
	          console.log("실행 ",result);
              savedFileName=file.name;
	          if (result.success && result.pages && result.pages.length > 0) {
	            displayPreviewPages(result.pages, file.name);
	            updateFileDisplay(file.name, (file.size / 1024 / 1024).toFixed(2), '미리보기 생성 완료');
	          } else {
	            handlePreviewError(result.message || '미리보기 생성에 실패했습니다.');
	          }
	        } catch (e) {
	          console.error('응답 파싱 오류:', e);
	          handlePreviewError('서버 응답을 처리할 수 없습니다.');
	        } 
	      },
	      error: function(xhr, status, error) {
	        console.error('AJAX 오류:', status, error);
			
	        let errorMessage = '서버 오류로 미리보기 생성에 실패했습니다.';
	        if (status === 'timeout') {
	          errorMessage = '서버 응답 시간이 초과되었습니다. 파일 크기를 확인해주세요.';
	        } else if (xhr.status === 413) {
	          errorMessage = '파일 크기가 너무 큽니다.';
	        }
	      },
	      complete: function() {
	        isProcessing = false; // 완료 시 플래그 해제
	      },
	      beforeSend: function() {
	        showLoadingState();
	      }
	    });
	  }
	
	  // 로딩 상태 표시
	  function showLoadingState() {
	    $('#previewContainer').html(`
	      <div class="text-center py-4">
	        <div class="spinner-border main-color" role="status">
	          <span class="visually-hidden">Loading...</span>
	        </div>
	        <p class="mt-2 mb-0">PDF 페이지를 분석하고 있습니다...</p>
	        <small class="text-muted">잠시만 기다려주세요.</small>
	      </div>
	    `);
	  }
	  
	  // 미리보기 생성 오류 처리
	  function handlePreviewError(message) {
	    alert(message);
	    
	    if (selectedFile) {
	      const fileName = selectedFile.name;
	      const fileSize = (selectedFile.size / 1024 / 1024).toFixed(2);
	      updateFileDisplay(fileName, fileSize, '미리보기 생성 실패');
	    }
	    
	    $('#previewContainer').html(`
	      <div class="text-center py-4 text-muted">
	        <i class="bi bi-exclamation-triangle fs-1 mb-2 text-warning"></i>
	        <p class="mb-0">미리보기 생성에 실패했습니다.</p>
	        <small>파일을 다시 업로드해주세요.</small>
	      </div>
	    `);
	    
	    isProcessing = false;
	  }
	  
	  // Drag and drop functionality - 무한 재귀 방지
	  let dragEnterCount = 0;
	  
	  $('#fileUpload').on('dragenter', function(e) {
	    e.preventDefault();
	    e.stopPropagation();
	    
	    if (isProcessing) return;
	    
	    dragEnterCount++;
	    $(this).addClass('border-main bg-main-light');
	  });
	  
	  $('#fileUpload').on('dragover', function(e) {
	    e.preventDefault();
	    e.stopPropagation();
	  });
	  
	  $('#fileUpload').on('dragleave', function(e) {
	    e.preventDefault();
	    e.stopPropagation();
	    
	    dragEnterCount--;
	    if (dragEnterCount <= 0) {
	      dragEnterCount = 0;
	      $(this).removeClass('border-main bg-main-light');
	    }
	  });
		
	  $('#fileUpload').on('drop', function(e) {
	    e.preventDefault();
	    e.stopPropagation();
	    
	    if (isProcessing) return;
	    
	    dragEnterCount = 0;
	    $(this).removeClass('border-main bg-main-light');
	    
	    const files = e.originalEvent.dataTransfer.files;
	    
	    if (files && files.length > 0) {
	      const file = files[0];
	      const fileExtension = file.name.split('.').pop().toLowerCase();
	      
	      if (fileExtension === 'pdf') {
	        handleFileSelection(file);
	      } else {
	        alert('PDF 파일만 업로드 가능합니다.');
	      }
	    }
	  });
	  
	  // Form validation - 수정된 부분
	  $('form').on('submit', function(e) {
	    // 처리 중이면 제출 방지
	    if (isProcessing) {
	      e.preventDefault();
	      alert('파일 처리가 완료될 때까지 기다려주세요.');
	      return false;
	    }
	    
	    // 필수 체크박스 확인
	    let allChecked = true;
	    const requiredCheckboxes = $('input[type="checkbox"][required]');
	    
	    requiredCheckboxes.each(function() {
	      if (!$(this).is(':checked')) {
	        allChecked = false;
	        // $(this).focus();
	        return false;
	      }
	    });
	    
	    if (!allChecked) {
	      e.preventDefault();
	      alert('자료등록 전 확인사항을 모두 체크해주세요.');
	      return false;
	    }
	    
	    // 파일 업로드 확인
	    if (!selectedFile) {
	      e.preventDefault();
	      alert('PDF 파일을 업로드해주세요.');
	      // $('#fileInput').focus();
	      return false;
	    }
	    
	    // 미리보기 페이지 선택 확인 - 수정된 부분
	    if (pdfViewer) {
	      const selectedPages = pdfViewer.getSelectedPages();
	      
	      // 최소 1페이지, 최대 3페이지 검증
	      if (selectedPages.length === 0) {
	        e.preventDefault();
	        alert('미리보기 페이지를 최소 1페이지 이상 선택해주세요.');
	        $('html, body').animate({
	          scrollTop: $('#previewContainer').offset().top - 100
	        }, 500);
	        return false;
	      }
	      
	      if (selectedPages.length > 3) {
	        e.preventDefault();
	        alert('미리보기 페이지는 최대 3페이지까지만 선택할 수 있습니다.');
	        $('html, body').animate({
	          scrollTop: $('#previewContainer').offset().top - 100
	        }, 500);
	        return false;
	      }
	      
	      // 선택된 페이지 정보를 hidden input으로 추가
	      $('input[name="selectedPreviewPages"]').remove();
	      selectedPages.forEach(page => {
	        $(this).append(`<input type="hidden" name="selectedPreviewPages" value="\${page}">`);
	      });
	      
	    } else {
	      e.preventDefault();
	      alert('PDF 파일을 먼저 업로드해주세요.');
	      return false;
	    }
	    
	    // 필수 입력 필드 확인
	    const requiredFields = $('input[required], textarea[required], select[required]').not('[type="checkbox"]');
	    let emptyField = null;
	    
	    requiredFields.each(function() {
	      if (!$(this).val() || !$(this).val().toString().trim()) {
	        emptyField = $(this);
	        return false;
	      }
	    });
	    
	    if (emptyField) {
	      e.preventDefault();
	      const fieldLabel = emptyField.closest('.mb-3').find('label').text() || '필수 입력 필드';
	      alert(`\${fieldLabel}를 입력해주세요.`);
	      // emptyField.focus();
	      return false;
	    }
	    
	    // 제출 버튼 비활성화 (중복 제출 방지)
	    const submitBtn = $(this).find('button[type="submit"]');
	    submitBtn.prop('disabled', true).text('등록 중...');
	    
	    return true;
	  });
	  
	  // 입력 필드 실시간 검증
	  $('input[name="price"]').on('input', function() {
	    const value = parseInt($(this).val());
	    if (value && value < 1000) {
	      $(this).addClass('is-invalid');
	      if (!$(this).next('.invalid-feedback').length) {
	        $(this).after('<div class="invalid-feedback">최소 1,000원부터 설정 가능합니다.</div>');
	      }
	    } else {
	      $(this).removeClass('is-invalid');
	      $(this).next('.invalid-feedback').remove();
	    }
	  });
	});

	// 전역 함수들
	function debugFileUpload() {
	  console.log('=== 파일 업로드 디버깅 ===');
	  console.log('jQuery 버전:', $.fn.jquery);
	  console.log('jQuery 로드됨:', typeof $ !== 'undefined');
	  
	  const fileUpload = $('#fileUpload');
	  const fileInput = $('#fileInput');
	  
	  console.log('fileUpload 요소 개수:', fileUpload.length);
	  console.log('fileInput 요소 개수:', fileInput.length);
	  
	  if (fileUpload.length > 0) {
	    console.log('fileUpload 요소 정보:', {
	      id: fileUpload.attr('id'),
	      classes: fileUpload.attr('class'),
	      visible: fileUpload.is(':visible'),
	      offset: fileUpload.offset()
	    });
	  }
	  
	  if (fileInput.length > 0) {
	    console.log('fileInput 요소 정보:', {
	      id: fileInput.attr('id'),
	      type: fileInput.attr('type'),
	      classes: fileInput.attr('class'),
	      visible: fileInput.is(':visible'),
	      display: fileInput.css('display')
	    });
	    
	    // 직접 클릭 테스트
	    try {
	      fileInput[0].click();
	      console.log('✅ 파일 입력 클릭 성공');
	    } catch (error) {
	      console.error('❌ 파일 입력 클릭 실패:', error);
	    }
	  }
	  
	  console.log('=== 디버깅 완료 ===');
	}
  function cancleRegist(){

    if(confirm('작성중인 내용이 삭제됩니다, 정말 취소하시겠습니까?')){
      $.ajax({
        url : '<%=request.getContextPath()%>/market/cancleRegist.do',
        type : 'POST',
        data : {"savedFileName": savedFileName},
        success(){
          alert('자료 등록이 취소되었습니다.');
          location.href='<%=request.getContextPath()%>/'
        }

      })
    }
  }
	function saveDraft() {
	  if (confirm('현재 작성 중인 내용을 임시저장하시겠습니까?')) {
	    const formData = new FormData($('form')[0]);
	    
	    $.ajax({ 
	      url: '<%=request.getContextPath()%>/market/saveDraft.do',
	      type: 'POST',
	      data: formData,
	      processData: false,
	      contentType: false,
	      success: function(response) {
	        try {
	          const result = typeof response === 'string' ? JSON.parse(response) : response;
	          if (result.success) {
	            alert('임시저장되었습니다.');
	          } else {
	            alert('임시저장에 실패했습니다: ' + (result.message || '알 수 없는 오류'));
	          }
	        } catch (e) {
	          alert('임시저장되었습니다.');
	        }
	      },
	      error: function() {
	        alert('서버 오류로 임시저장에 실패했습니다.');
	      }
	    });
	  }
	}

	// 디버깅용 함수들 추가
	function testPagination() {
	  if (pdfViewer && pdfViewer.pages.length > 0) {
	    console.log('=== 페이지네이션 테스트 ===');
	    console.log(`총 페이지: \${pdfViewer.pages.length}`);
	    console.log(`페이지당 표시: \${pdfViewer.pagesPerView}`);
	    console.log(`현재 페이지: \${pdfViewer.currentViewPage}`);
	    
	    // 3개씩 보기 테스트
	    pdfViewer.setPagesPerView(3);
	  } else {
	    alert('먼저 PDF 파일을 업로드해주세요.');
	  }
	}

	function resetPagination() {
	  if (pdfViewer) {
	    pdfViewer.setPagesPerView(6);
	    alert('6개씩 보기로 리셋되었습니다.');
	  }
	}

  <%-- window.addEventListener("beforeunload",e=>{
    $.ajax({
        url : '<%=request.getContextPath()%>/market/cancleRegist.do',
        type : 'POST',
        data : {"savedFileName": savedFileName},
        success(){

        }

      });

      return "1";
  }); --%>

</script>

	


<%@ include file="/WEB-INF/views/common/footer.jsp"%>