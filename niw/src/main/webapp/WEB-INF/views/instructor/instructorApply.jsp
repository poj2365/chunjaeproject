<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User" %>
<%@ page import="java.sql.Date" %>


<%@ include file="../common/header.jsp" %>

<style>
.instructor-application-container {
    max-width: 800px;
    margin: 2rem auto;
    padding: 0 1rem;
}

.application-card {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    padding: 2.5rem;
    margin-bottom: 2rem;
}

.application-header {
    text-align: center;
    margin-bottom: 2rem;
    padding-bottom: 1.5rem;
    border-bottom: 2px solid var(--bs-blind-gray);
}

.application-title {
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--bs-blind-gray);
    margin-bottom: 0.5rem;
}

.application-subtitle {
    color: #6c757d;
    font-size: 1rem;
}

.form-section {
    margin-bottom: 2rem;
}

.section-title {
    font-size: 1.2rem;
    font-weight: 600;
    color: var(--bs-blind-gray);
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid #e9ecef;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    font-weight: 600;
    color: #495057;
    margin-bottom: 0.5rem;
    display: block;
}

.form-control, .form-select {
    border: 2px solid #e9ecef;
    border-radius: 8px;
    padding: 0.75rem 1rem;
    font-size: 1rem;
    transition: all 0.3s;
}

.form-control:focus, .form-select:focus {
    border-color: var(--bs-blind-gray);
    box-shadow: 0 0 0 0.2rem rgba(26, 138, 142, 0.25);
}

.readonly-input {
    background-color: #f8f9fa;
    color: #6c757d;
    cursor: not-allowed;
}

.portfolio-upload {
    border: 2px dashed #dee2e6;
    border-radius: 8px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s;
    margin-bottom: 1rem;
}

.portfolio-upload:hover {
    border-color: var(--bs-blind-gray);
    background-color: #f8f9fa;
}

.portfolio-upload i {
    font-size: 2rem;
    color: var(--bs-blind-gray);
    margin-bottom: 0.5rem;
}

.portfolio-item {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 1rem;
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.portfolio-info {
    display: flex;
    align-items: center;
}

.portfolio-info i {
    color: var(--bs-blind-gray);
    margin-right: 0.5rem;
}

.btn-submit {
    background: linear-gradient(135deg, var(--bs-blind-gray), var(--bs-blind-light-gray));
    color: white;
    border: none;
    padding: 1rem 3rem;
    font-size: 1.1rem;
    font-weight: 600;
    border-radius: 50px;
    transition: all 0.3s;
    display: block;
    margin: 2rem auto 0;
}

.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(26, 138, 142, 0.3);
    color: white;
}

.btn-remove {
    color: #dc3545;
    background: none;
    border: none;
    padding: 0.25rem;
    font-size: 1.2rem;
}

.required {
    color: #dc3545;
}

.info-text {
    font-size: 0.9rem;
    color: #6c757d;
    margin-top: 0.5rem;
}

.portfolio-upload.drag-over {
    border-color: var(--bs-blind-gray);
    background-color: rgba(26, 138, 142, 0.1);
    transform: scale(1.02);
}

@media (max-width: 768px) {
    .application-card {
        padding: 1.5rem;
        margin: 1rem;
    }
    
    .instructor-application-container {
        margin: 1rem auto;
    }
}
</style>

<div class="instructor-application-container">
    <div class="application-card">
        <div class="application-header">
            <h1 class="application-title">학습자료 판매 등록 권한 요청</h1>
            <p class="application-subtitle">강사로 활동하기 위한 정보를 입력해주세요</p>
        </div>

        <form id="instructorApplicationForm" method="post" action="<%=request.getContextPath()%>/instructor/apply.do" enctype="multipart/form-data">
            
            <!-- 강사 기본 정보 -->
            <div class="form-section">
                <h3 class="section-title">강사 기본 정보</h3>
                
                <div class="form-group">
                    <label for="instructorName" class="form-label">강사이름 <span class="required">*</span></label>
                    <input type="text" class="form-control readonly-input" id="instructorName" name="instructorName" 
                           value="<%=loginUser.userName()%>" readonly>
                    <div class="info-text">회원 정보에서 불러온 이름입니다</div>
                </div>
            </div>

            <!-- 정산 계좌 정보 -->
            <div class="form-section">
                <h3 class="section-title">정산 계좌 정보</h3>
                
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="bankName" class="form-label">은행 <span class="required">*</span></label>
                            <select class="form-select" id="bankName" name="bankName" required>
                                <option value="">은행 선택</option>
                                <option value="국민은행">국민은행</option>
                                <option value="신한은행">신한은행</option>
                                <option value="우리은행">우리은행</option>
                                <option value="하나은행">하나은행</option>
                                <option value="농협은행">농협은행</option>
                                <option value="기업은행">기업은행</option>
                                <option value="카카오뱅크">카카오뱅크</option>
                                <option value="토스뱅크">토스뱅크</option>
                                <option value="새마을금고">새마을금고</option>
                                <option value="신협">신협</option>
                            </select>
                            <div class="info-text">은행을 먼저 선택해주세요</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="accountHolder" class="form-label">예금주 <span class="required">*</span></label>
                            <input type="text" class="form-control" id="accountHolder" name="accountHolder" 
                                   placeholder="예금주명 (한글 2-10자)" maxlength="10" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="accountNumber" class="form-label">계좌번호 <span class="required">*</span></label>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                   placeholder="은행을 먼저 선택해주세요" required>
                            <div class="info-text">숫자만 입력하면 자동으로 형식이 맞춰집니다</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 강사 소개 (이력) -->
            <div class="form-section">
                <h3 class="section-title">강사 소개 (이력)</h3>
                
                <div class="form-group">
                    <label for="introduction" class="form-label">강사 소개 <span class="required">*</span></label>
                    <textarea class="form-control" id="introduction" name="introduction" rows="8" 
                              placeholder="강사님의 학력, 경력, 전문분야, 교육철학 등을 자유롭게 작성해주세요.&#10;&#10;예시:&#10;- 학력: OO대학교 수학교육과 졸업&#10;- 경력: 10년간 중고등학생 수학 지도&#10;- 전문분야: 수능 수학, 내신 대비&#10;- 교육철학: 학생 개개인의 수준에 맞춘 맞춤형 교육" required></textarea>
                    <div class="info-text">최소 100자 이상 작성해주세요</div>
                </div>
            </div>

            <!-- 포트폴리오 (수업자료 또는 강의자료) -->
            <div class="form-section">
                <h3 class="section-title">포트폴리오 (수업자료 또는 강의자료)</h3>
                <div class="info-text mb-3">강사 심사를 위한 자료를 업로드해주세요. (최대 3개 파일)</div>
                
                <div id="portfolioContainer">
                    <div class="portfolio-upload" id="portfolio-upload-1" onclick="document.getElementById('portfolioFile1').click()">
                        <i class="bi bi-cloud-upload"></i>
                        <div>파일을 선택하거나 여기에 드래그하세요</div>
                        <div class="info-text">PDF, PPT, DOC 파일 (최대 10MB)</div>
                    </div>
                    <input type="file" id="portfolioFile1" name="portfolioFile1" 
                           accept=".pdf,.ppt,.pptx,.doc,.docx" style="display: none;" 
                           onchange="handleFileSelect(this, 1)">
                </div>
                
                <div id="portfolioList"></div>
                
                <button type="button" id="addPortfolioBtn" class="btn btn-outline-secondary mt-2" 
                        onclick="addPortfolioInput()" style="display: none;">
                    <i class="bi bi-plus-circle me-2"></i>추가 파일 업로드
                </button>
            </div>

            <!-- 제출 버튼 -->
            <button type="submit" class="btn-submit">
                <i class="bi bi-send me-2"></i>학습자료 판매 권한 요청하기
            </button>

        </form>
    </div>
</div>

<script>

const BANK_FORMATS = {
    '국민은행': [6, 2, 6],      // 123456-12-123456
    '신한은행': [3, 2, 6],      // 123-12-123456  
    '우리은행': [4, 3, 6],      // 1234-123-123456
    '하나은행': [3, 6, 5],      // 123-123456-12345
    '농협은행': [3, 4, 4, 2],   // 123-1234-1234-12
    '기업은행': [3, 6, 2],      // 123-123456-12
    '카카오뱅크': [4, 2, 7],    // 1234-12-1234567
    '토스뱅크': [4, 2, 7],      // 1234-12-1234567
    '새마을금고': [4, 2, 6, 1], // 1234-12-123456-1
    '신협': [3, 4, 6]           // 123-1234-123456
};


function formatAccountNumber(bankName, inputValue) {

    const numbersOnly = inputValue.replace(/[^0-9]/g, '');
    
 
    const format = BANK_FORMATS[bankName];
    if (!format) {
        return numbersOnly; 
    }
    
    let formatted = '';
    let currentIndex = 0;
    

    for (let i = 0; i < format.length; i++) {
        const sectionLength = format[i];
        const section = numbersOnly.substr(currentIndex, sectionLength);
        
        if (section.length > 0) {
            formatted += section;
            
            
            if (i < format.length - 1 && numbersOnly.length > currentIndex + sectionLength) {
                formatted += '-';
            }
        }
        
        currentIndex += sectionLength;
        
        // 입력된 숫자가 현재 구간까지만 있으면 종료
        if (currentIndex >= numbersOnly.length) {
            break;
        }
    }
    
    return formatted;
}

// 최대 입력 길이 계산 (하이픈 포함)
function getMaxLength(bankName) {
    const format = BANK_FORMATS[bankName];
    if (!format) return 20; // 기본값
    
    const totalDigits = format.reduce((sum, length) => sum + length, 0);
    const totalHyphens = format.length - 1;
    return totalDigits + totalHyphens;
}

// 이벤트 리스너 설정
document.addEventListener('DOMContentLoaded', function() {
    const bankSelect = document.getElementById('bankName');
    const accountInput = document.getElementById('accountNumber');
    const accountHolder = document.getElementById('accountHolder');
    
    // ===== 예금주 한글 입력 처리 개선 =====
    let isComposing = false; // IME 입력 상태 추적
    
    // IME 입력 시작
    accountHolder.addEventListener('compositionstart', function() {
        isComposing = true;
    });
    
    // IME 입력 종료
    accountHolder.addEventListener('compositionend', function() {
        isComposing = false;
        // IME 입력 완료 후 처리
        setTimeout(() => {
            processAccountHolderInput.call(this);
        }, 10);
    });
    
    // 일반 입력 처리
    accountHolder.addEventListener('input', function() {
        // IME 입력 중이 아닐 때만 처리
        if (!isComposing) {
            setTimeout(() => {
                processAccountHolderInput.call(this);
            }, 10);
        }
    });
    
    // 예금주명 처리 함수
    function processAccountHolderInput() {
        // 한글, 영문, 공백만 허용
        const originalValue = this.value;
        const filteredValue = originalValue.replace(/[^가-힣a-zA-Z\s]/g, '');
        
        // 값이 변경되었을 때만 업데이트 (무한 루프 방지)
        if (originalValue !== filteredValue) {
            this.value = filteredValue;
        }
        
        // 길이 제한 (2-10자)
        if (this.value.length > 10) {
            this.value = this.value.substring(0, 10);
        }
        
        validateAccountHolder(this.value);
    }
    
    // 예금주 붙여넣기 시 처리 개선
    accountHolder.addEventListener('paste', function(e) {
        setTimeout(() => {
            processAccountHolderInput.call(this);
        }, 50);
    });
    
    // ===== 드래그 앤 드롭 기능 초기화 =====
    const firstUploadArea = document.getElementById('portfolio-upload-1');
    setupDragAndDrop(firstUploadArea, 1);
    
    // 초기 버튼 상태 설정
    updateAddButton();
    
    // ===== 기존 은행/계좌번호 처리 =====
    // 은행 변경시 계좌번호 입력란 초기화 및 플레이스홀더 변경
    bankSelect.addEventListener('change', function() {
        const selectedBank = this.value;
        accountInput.value = '';
        updatePlaceholder(selectedBank);
        updateMaxLength(selectedBank);
    });
    
    // 계좌번호 입력시 실시간 포맷팅
    accountInput.addEventListener('input', function(e) {
        const selectedBank = bankSelect.value;
        if (!selectedBank) {
            // 은행이 선택되지 않았으면 숫자만 허용
            this.value = this.value.replace(/[^0-9]/g, '');
            return;
        }
        
        // 커서 위치 저장
        const cursorPosition = this.selectionStart;
        const previousValue = this.value;
        
        // 포맷팅 적용
        const formatted = formatAccountNumber(selectedBank, this.value);
        this.value = formatted;
        
        // 커서 위치 조정 (하이픈이 자동 추가된 경우)
        if (formatted.length > previousValue.length && formatted[cursorPosition] === '-') {
            this.setSelectionRange(cursorPosition + 1, cursorPosition + 1);
        }
        
        // 실시간 유효성 검증
        validateAccountFormat(selectedBank, formatted);
    });
    
    // 붙여넣기 시에도 포맷팅 적용
    accountInput.addEventListener('paste', function(e) {
        setTimeout(() => {
            const selectedBank = bankSelect.value;
            if (selectedBank) {
                this.value = formatAccountNumber(selectedBank, this.value);
                validateAccountFormat(selectedBank, this.value);
            }
        }, 10);
    });
});

// ===== 드래그 앤 드롭 기능 설정 =====
function setupDragAndDrop(uploadDiv, fileIndex) {
    // 드래그 이벤트 방지 (기본 브라우저 동작 방지)
    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        uploadDiv.addEventListener(eventName, preventDefaults, false);
        document.body.addEventListener(eventName, preventDefaults, false);
    });
    
    // 드래그 시각적 효과
    ['dragenter', 'dragover'].forEach(eventName => {
        uploadDiv.addEventListener(eventName, highlight, false);
    });
    
    ['dragleave', 'drop'].forEach(eventName => {
        uploadDiv.addEventListener(eventName, unhighlight, false);
    });
    
    // 파일 드롭 처리
    uploadDiv.addEventListener('drop', function(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        
        if (files.length > 0) {
            const fileInput = document.getElementById('portfolioFile' + fileIndex);
            fileInput.files = files;
            handleFileSelect(fileInput, fileIndex);
        }
    }, false);
    
    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }
    
    function highlight(e) {
        uploadDiv.classList.add('drag-over');
    }
    
    function unhighlight(e) {
        uploadDiv.classList.remove('drag-over');
    }
}

// 플레이스홀더 업데이트
function updatePlaceholder(bankName) {
    const accountInput = document.getElementById('accountNumber');
    const examples = {
        '국민은행': '123456-12-123456',
        '신한은행': '123-12-123456',
        '우리은행': '1234-123-123456',
        '하나은행': '123-123456-12345',
        '농협은행': '123-1234-1234-12',
        '기업은행': '123-123456-12',
        '카카오뱅크': '1234-12-1234567',
        '토스뱅크': '1234-12-1234567',
        '새마을금고': '1234-12-123456-1',
        '신협': '123-1234-123456'
    };
    
    accountInput.placeholder = examples[bankName] || '계좌번호를 입력하세요';
}

// 최대 길이 업데이트
function updateMaxLength(bankName) {
    const accountInput = document.getElementById('accountNumber');
    accountInput.maxLength = getMaxLength(bankName);
}

// 계좌번호 형식 유효성 검증
function validateAccountFormat(bankName, accountNumber) {
    const format = BANK_FORMATS[bankName];
    if (!format) return true;
    
    const numbersOnly = accountNumber.replace(/[^0-9]/g, '');
    const expectedLength = format.reduce((sum, length) => sum + length, 0);
    
    const errorDiv = document.getElementById('accountError') || createErrorDiv();
    
    if (numbersOnly.length === expectedLength) {
        // 완전한 계좌번호
        errorDiv.style.display = 'none';
        document.getElementById('accountNumber').style.borderColor = '#28a745';
        return true;
    } else if (numbersOnly.length > expectedLength) {
        // 너무 긴 계좌번호
        errorDiv.textContent = '계좌번호가 너무 깁니다.';
        errorDiv.style.display = 'block';
        document.getElementById('accountNumber').style.borderColor = '#dc3545';
        return false;
    } else if (accountNumber.length > 0) {
        // 입력 중
        errorDiv.style.display = 'none';
        document.getElementById('accountNumber').style.borderColor = '#007bff';
        return false;
    }
    
    return false;
}

// 예금주명 유효성 검증
function validateAccountHolder(accountHolder) {
    const errorDiv = document.getElementById('holderError') || createHolderErrorDiv();
    const holderInput = document.getElementById('accountHolder');
    
    if (accountHolder.length >= 2 && accountHolder.length <= 10) {
        errorDiv.style.display = 'none';
        holderInput.style.borderColor = '#28a745';
        return true;
    } else if (accountHolder.length > 0) {
        errorDiv.textContent = '예금주명은 2-10자로 입력해주세요.';
        errorDiv.style.display = 'block';
        holderInput.style.borderColor = '#dc3545';
        return false;
    }
    
    return false;
}

// 에러 메시지 div 생성
function createErrorDiv() {
    const errorDiv = document.createElement('div');
    errorDiv.id = 'accountError';
    errorDiv.className = 'error-message';
    errorDiv.style.color = '#dc3545';
    errorDiv.style.fontSize = '0.875rem';
    errorDiv.style.marginTop = '0.25rem';
    errorDiv.style.display = 'none';
    
    document.getElementById('accountNumber').parentNode.appendChild(errorDiv);
    return errorDiv;
}

function createHolderErrorDiv() {
    const errorDiv = document.createElement('div');
    errorDiv.id = 'holderError';
    errorDiv.className = 'error-message';
    errorDiv.style.color = '#dc3545';
    errorDiv.style.fontSize = '0.875rem';
    errorDiv.style.marginTop = '0.25rem';
    errorDiv.style.display = 'none';
    
    document.getElementById('accountHolder').parentNode.appendChild(errorDiv);
    return errorDiv;
}

// 폼 제출 전 최종 검증
function validateAccountBeforeSubmit() {
    const bankName = document.getElementById('bankName').value;
    const accountNumber = document.getElementById('accountNumber').value;
    const accountHolder = document.getElementById('accountHolder').value;
    
    if (!bankName) {
        alert('은행을 선택해주세요.');
        return false;
    }
    
    if (!validateAccountFormat(bankName, accountNumber)) {
        alert('올바른 계좌번호를 입력해주세요.');
        return false;
    }
    
    if (!validateAccountHolder(accountHolder)) {
        alert('올바른 예금주명을 입력해주세요.');
        return false;
    }
    
    return true;
}

let portfolioFiles = [null, null, null]; // 3개 슬롯 관리 (index 0, 1, 2)
const maxPortfolioCount = 3;

function handleFileSelect(input, index) {
    const file = input.files[0];
    if (file) {
        // 파일 크기 체크 (10MB)
        if (file.size > 10 * 1024 * 1024) {
            alert('파일 크기는 10MB를 초과할 수 없습니다.');
            input.value = '';
            return;
        }
        
        // 파일 확장자 체크
        const allowedTypes = ['.pdf', '.ppt', '.pptx', '.doc', '.docx'];
        const fileExtension = '.' + file.name.split('.').pop().toLowerCase();
        if (!allowedTypes.includes(fileExtension)) {
            alert('PDF, PPT, DOC 파일만 업로드 가능합니다.');
            input.value = '';
            return;
        }
        
        // 파일 상태 업데이트
        portfolioFiles[index - 1] = file;
        
        // 해당 업로드 영역 숨기기
        const uploadDiv = document.getElementById('portfolio-upload-' + index);
        if (uploadDiv) {
            uploadDiv.style.display = 'none';
        }
        
        displayPortfolioFile(file, index);
        updateAddButton();
    }
}

function displayPortfolioFile(file, index) {
    const portfolioList = document.getElementById('portfolioList');
    const portfolioItem = document.createElement('div');
    portfolioItem.className = 'portfolio-item';
    portfolioItem.id = 'portfolio-item-' + index;
    
    portfolioItem.innerHTML = 
        '<div class="portfolio-info">' +
            '<i class="bi bi-file-earmark"></i>' +
            '<span>' + file.name + ' (' + (file.size / 1024 / 1024).toFixed(2) + ' MB)</span>' +
        '</div>' +
        '<button type="button" class="btn-remove" onclick="removePortfolioFile(' + index + ')">' +
            '<i class="bi bi-x-circle"></i>' +
        '</button>';
    
    portfolioList.appendChild(portfolioItem);
}

function removePortfolioFile(index) {
    // 파일 상태 업데이트
    portfolioFiles[index - 1] = null;
    
    // 입력 필드 초기화
    document.getElementById('portfolioFile' + index).value = '';
    
    // 파일 아이템 제거
    const portfolioItem = document.getElementById('portfolio-item-' + index);
    if (portfolioItem) {
        portfolioItem.remove();
    }
    
    // 해당 업로드 영역 다시 보이기
    const uploadDiv = document.getElementById('portfolio-upload-' + index);
    if (uploadDiv) {
        uploadDiv.style.display = 'block';
    }
    
    updateAddButton();
}

function addPortfolioInput() {
    // 다음 빈 슬롯 찾기
    let nextIndex = -1;
    for (let i = 0; i < maxPortfolioCount; i++) {
        if (portfolioFiles[i] === null) {
            nextIndex = i + 1; // 1부터 시작하는 인덱스
            break;
        }
    }
    
    if (nextIndex === -1) {
        return; // 모든 슬롯이 차있음
    }
    
    // 이미 해당 인덱스의 업로드 영역이 존재하는지 확인
    if (document.getElementById('portfolio-upload-' + nextIndex)) {
        document.getElementById('portfolio-upload-' + nextIndex).style.display = 'block';
        updateAddButton();
        return;
    }
    
    const portfolioContainer = document.getElementById('portfolioContainer');
    const newUploadDiv = document.createElement('div');
    newUploadDiv.className = 'portfolio-upload';
    newUploadDiv.id = 'portfolio-upload-' + nextIndex;
    newUploadDiv.onclick = function() { 
        document.getElementById('portfolioFile' + nextIndex).click(); 
    };
    
    // 새로 생성된 업로드 영역에도 드래그앤드롭 이벤트 추가
    setupDragAndDrop(newUploadDiv, nextIndex);
    
    newUploadDiv.innerHTML = 
        '<i class="bi bi-cloud-upload"></i>' +
        '<div>파일을 선택하거나 여기에 드래그하세요</div>' +
        '<div class="info-text">PDF, PPT, DOC 파일 (최대 10MB)</div>';
    
    const newFileInput = document.createElement('input');
    newFileInput.type = 'file';
    newFileInput.id = 'portfolioFile' + nextIndex;
    newFileInput.name = 'portfolioFile' + nextIndex;
    newFileInput.accept = '.pdf,.ppt,.pptx,.doc,.docx';
    newFileInput.style.display = 'none';
    newFileInput.onchange = function() { handleFileSelect(this, nextIndex); };
    
    portfolioContainer.appendChild(newUploadDiv);
    portfolioContainer.appendChild(newFileInput);
    
    updateAddButton();
}

// 추가 버튼 상태 업데이트
function updateAddButton() {
    const uploadedCount = portfolioFiles.filter(file => file !== null).length;
    const addBtn = document.getElementById('addPortfolioBtn');
    
    if (uploadedCount < maxPortfolioCount) {
        addBtn.style.display = 'block';
    } else {
        addBtn.style.display = 'none';
    }
}

// 폼 제출 전 유효성 검사
document.getElementById('instructorApplicationForm').addEventListener('submit', function(e) {
    const introduction = document.getElementById('introduction').value.trim();
    
    if (introduction.length < 100) {
        e.preventDefault();
        alert('강사 소개는 최소 100자 이상 작성해주세요.');
        document.getElementById('introduction').focus();
        return;
    }
    
    // 계좌 정보 검증
    if (!validateAccountBeforeSubmit()) {
        e.preventDefault();
        return;
    }
    
    if (confirm('강사 권한 신청을 제출하시겠습니까?')) {
        // 제출 진행
    } else {
        e.preventDefault();
    }
});
</script>

<%@ include file="../common/footer.jsp" %>