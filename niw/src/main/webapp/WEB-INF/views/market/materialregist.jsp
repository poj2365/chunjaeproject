<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

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

.preview-page-item {
	border: 2px solid #ddd;
	border-radius: 8px;
	padding: 1rem;
	cursor: pointer;
	transition: all 0.3s;
	background-color: white;
}

.preview-page-item:hover {
	border-color: var(--main-color);
	box-shadow: 0 2px 8px rgba(36, 177, 181, 0.15);
}

.preview-page-item.selected {
	border-color: var(--main-color);
	background-color: rgba(36, 177, 181, 0.05);
}

.preview-page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 0.5rem;
}

.page-number {
	font-weight: 600;
	color: #495057;
}

.preview-image-container {
	text-align: center;
}

.preview-image-container img {
	max-height: 200px;
	border: 1px solid #e9ecef;
}

.spinner-border.main-color {
	color: var(--main-color);
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
						action="<%=request.getContextPath()%>/study/materialInsert.do"
						method="post" enctype="multipart/form-data">
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
										<option value="대학교">대학교</option>
										<option value="직장인">직장인</option>
										<option value="기타">기타</option>
									</select>
								</div>
								<div class="col-md-4">
									<label class="form-label">학년</label> <select
										class="form-select" name="grade">
										<option value="">선택해주세요</option>
										<option value="1학년">1학년</option>
										<option value="2학년">2학년</option>
										<option value="3학년">3학년</option>
										<option value="4학년">4학년</option>
										<option value="5학년">5학년</option>
										<option value="6학년">6학년</option>
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
										placeholder="자료의 판매 가격을 입력해주세요" min="1000" required> <span
										class="input-group-text">원</span>
								</div>
								<small class="helper-text">최소 1,000원부터 설정 가능합니다.</small>
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

								<!-- 테스트용 버튼 -->
								<div class="mt-2">
									<button type="button" class="btn btn-sm btn-outline-primary"
										onclick="testFileUpload()">파일 선택 테스트</button>
									<small class="text-muted ms-2">위 버튼도 안 되면 JavaScript
										오류입니다</small>
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
								페이지를 선택하여 미리보기로 설정할 수 있습니다.
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
									placeholder="강사님의 경력이나 교육 철학 등을 간략히 소개해주세요."></textarea>
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
						<li class="mb-1">최소 3페이지 이상의 미리보기 필수</li>
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
	    //$('#fileInput')[0].files='';
	    selectedFile = null;
	    isProcessing = false;
	    $('#fileUpload p').text('PDF 파일을 끌어서 놓거나 클릭하여 업로드');
	  }
	  
	  // 파일 표시 업데이트
	  function updateFileDisplay(fileName, fileSize, status) {
	    $('#fileUpload p').text(`${fileName} (${fileSize}MB) - ${status}`);
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
	          const result = typeof response === 'string' ? JSON.parse(response) : response;
	          console.log("실행 ",result);
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
	        
	       // handlePreviewError(errorMessage);
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
	  
	  // 미리보기 페이지들을 화면에 표시
	  function displayPreviewPages(pages, fileName) {
	    const userId = '<%=loginUser != null ? loginUser.userId() : ""%>';
	    const contextPath = '<%=request.getContextPath()%>';
	    
	    if (!userId) {
	      console.error('사용자 ID가 없습니다.');
	      handlePreviewError('사용자 인증이 필요합니다.');
	      return;
	    }
	    
	    let html = '<div class="row g-3">';
	    
	    for (let i = 0; i < pages.length; i++) {
	      const isSelected = i < 3;
	      const imageUrl = `${contextPath}/resources/upload/market/${userId}/material/previews/${pages[i]}`;
	      
	      html += `
	        <div class="col-md-4 col-sm-6">
	          <div class="preview-page-item \${isSelected ? 'selected' : ''}" data-page="\${i + 1}">
	            <div class="preview-page-header">
	              <span class="page-number">페이지 ${i + 1}</span>
	              <div class="form-check">
	                <input class="form-check-input preview-checkbox" type="checkbox" 
	                       id="page\${i + 1}" name="selectedPages" value="\${i + 1}" 
	                       ${isSelected ? 'checked' : ''}>
	                <label class="form-check-label" for="page\${i + 1}">
	                  미리보기로 사용
	                </label>
	              </div>
	            </div>
	            <div class="preview-image-container">
	              <img src="${imageUrl}" 
	                   alt="페이지 ${i + 1}" 
	                   class="img-fluid rounded"
	                   onerror="this.src='\${contextPath}/resources/images/preview-error.png'">
	            </div>
	          </div>
	        </div>
	      `;
	    }
	    
	    html += '</div>';
	    html += `
	      <div class="mt-3 alert alert-info" id="previewAlert">
	        <i class="bi bi-info-circle me-2"></i>
	        <strong>미리보기 페이지 선택</strong><br>
	        최소 3페이지 이상을 선택해주세요. 선택된 페이지들이 구매자에게 미리보기로 제공됩니다.
	      </div>
	    `;
	    
	    $('#previewContainer').html(html);
	    bindPreviewPageEvents();
	  }
	  
	  // 미리보기 페이지 선택 이벤트 - 무한 재귀 방지
	  function bindPreviewPageEvents() {
	    // 페이지 아이템 클릭 (체크박스 제외)
	    $(document).off('click.previewPage').on('click.previewPage', '.preview-page-item', function(e) {
	      // 체크박스나 라벨을 직접 클릭한 경우는 제외
	      if ($(e.target).is('input[type="checkbox"], label')) {
	        return;
	      }
	      
	      e.preventDefault();
	      e.stopPropagation();
	      
	      const checkbox = $(this).find('.preview-checkbox');
	      if (checkbox.length) {
	        // prop 변경만 하고 change 이벤트는 수동으로 호출
	        const newState = !checkbox.prop('checked');
	        checkbox.prop('checked', newState);
	        
	        // 페이지 아이템 상태 변경
	        $(this).toggleClass('selected', newState);
	        
	        // 알림 업데이트
	        updatePreviewAlert();
	      }
	    });
	    
	    // 체크박스 직접 변경
	    $(document).off('change.previewCheckbox').on('change.previewCheckbox', '.preview-checkbox', function(e) {
	      e.stopPropagation();
	      
	      const pageItem = $(this).closest('.preview-page-item');
	      pageItem.toggleClass('selected', this.checked);
	      
	      updatePreviewAlert();
	    });
	  }
	  
	  // 미리보기 알림 업데이트
	  function updatePreviewAlert() {
	    const selectedCount = $('.preview-checkbox:checked').length;
	    const alertElement = $('#previewAlert');
	    
	    if (alertElement.length === 0) return;
	    
	    if (selectedCount < 3) {
	      alertElement.removeClass('alert-info').addClass('alert-warning');
	      alertElement.find('strong').text('미리보기 페이지 부족');
	      alertElement.find('br').next().text(`현재 ${selectedCount}페이지 선택됨. 최소 3페이지 이상 선택해주세요.`);
	    } else {
	      alertElement.removeClass('alert-warning').addClass('alert-info');
	      alertElement.find('strong').text('미리보기 페이지 선택');
	      alertElement.find('br').next().text(`${selectedCount}페이지가 선택되었습니다. 구매자에게 미리보기로 제공됩니다.`);
	    }
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
	  
	  // Form validation
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
	        $(this).focus();
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
	      $('#fileInput').focus();
	      return false;
	    }
	    
	    // 미리보기 페이지 선택 확인
	    const selectedPreviews = $('.preview-checkbox:checked').length;
	    if (selectedPreviews < 3) {
	      e.preventDefault();
	      alert('미리보기 페이지를 최소 3페이지 이상 선택해주세요.');
	      $('html, body').animate({
	        scrollTop: $('#previewContainer').offset().top - 100
	      }, 500);
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
	      alert(`${fieldLabel}를 입력해주세요.`);
	      emptyField.focus();
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

	function saveDraft() {
	  if (confirm('현재 작성 중인 내용을 임시저장하시겠습니까?')) {
	    const formData = new FormData($('form')[0]);
	    
	    $.ajax({
	      url: '<%=request.getContextPath()%>/study/saveDraft.do',
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
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>