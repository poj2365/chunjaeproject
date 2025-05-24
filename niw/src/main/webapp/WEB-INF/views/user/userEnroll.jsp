<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습메이트 - 회원가입</title>
    <!-- Google Fonts: GmarketSans -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        :root {
            --bs-primary: #24b1b5;
            --bs-primary-rgb: 36, 177, 181;
            --bs-primary-hover: #1e9599;
            --bs-primary-light: #e3f6f7;
            --bs-primary-light-rgb: 227, 246, 247;
            --bs-secondary: #5a6268;
            --bs-secondary-light: #eef0f2;
            --bs-accent: #ff7d4d;
            --bs-accent-rgb: 255, 125, 77;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'GmarketSansMedium', sans-serif;
            background-color: #f5f6f7;
            color: #222;
            line-height: 1.5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        a {
            text-decoration: none;
            color: inherit;
        }
        
        ul {
            list-style: none;
        }
        
        button {
            cursor: pointer;
            background: none;
            border: none;
            outline: none;
        }
        
        /* 메인 컨테이너 */
        .container {
            max-width: 800px;
            margin: 30px auto;
            flex: 1;
        }
        
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo-section img {
            max-width: 200px;
            height: auto;
        }
        
        .logo-section h1 {
            font-size: 24px;
            color: var(--bs-primary);
            margin-top: 10px;
        }
        
        /* 회원가입 카드 */
        .signup-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 20px;
        }
        
        .card-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        /* 스텝 프로그레스 */
        .step-progress {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }
        
        .step-progress::before {
            content: '';
            position: absolute;
            top: 15px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: #eee;
            z-index: 1;
        }
        
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
        }
        
        .step-circle {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #eee;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            color: #777;
            margin-bottom: 8px;
            transition: all 0.3s;
        }
        
        .step-label {
            font-size: 14px;
            color: #777;
            transition: all 0.3s;
        }
        
        .step.active .step-circle {
            background-color: var(--bs-primary);
            color: white;
        }
        
        .step.active .step-label {
            color: var(--bs-primary);
            font-weight: bold;
        }
        
        .step.completed .step-circle {
            background-color: var(--bs-primary);
            color: white;
        }
        
        .step-progress-bar {
            position: absolute;
            top: 15px;
            left: 0;
            height: 2px;
            background-color: var(--bs-primary);
            z-index: 1;
            transition: width 0.5s ease-in-out;
        }
        
        /* 폼 스타일 */
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #444;
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
            border-color: var(--bs-primary);
            box-shadow: 0 0 0 3px rgba(var(--bs-primary-rgb), 0.2);
            outline: none;
        }
        
        .form-input::placeholder {
            color: #ccc;
        }
        
        .input-group {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .input-group .form-input {
            flex: 1;
        }
        
        .input-group .btn {
            white-space: nowrap;
        }
        
        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .btn-primary {
            background-color: var(--bs-primary);
            color: white;
            border: none;
        }
        
        .btn-primary:hover {
            background-color: var(--bs-primary-hover);
        }
        
        .btn-secondary {
            background-color: #f5f6f7;
            color: #444;
            border: 1px solid #ddd;
        }
        
        .btn-secondary:hover {
            background-color: #eaecef;
        }
        
        .btn-accent {
            background-color: var(--bs-accent);
            color: white;
            border: none;
        }
        
        .btn-accent:hover {
            background-color: #ff6a36;
        }
        
        .btn-lg {
            padding: 15px 30px;
            font-size: 18px;
        }
        
        .btn-block {
            display: block;
            width: 100%;
        }
        
        /* 약관 스타일 */
        .terms-container {
            max-height: 300px;
            overflow-y: auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            border: 1px solid #eee;
            margin-bottom: 15px;
        }
        
        .terms-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }
        
        .terms-text {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }
        
        .terms-checkbox-group {
            margin-bottom: 20px;
        }
        
        .checkbox-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .checkbox-input {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            accent-color: var(--bs-primary);
        }
        
        .checkbox-label {
            font-size: 15px;
            color: #444;
        }
        
        .checkbox-label.required::after {
            content: ' (필수)';
            color: var(--bs-primary);
            font-weight: bold;
        }
        
        .checkbox-label.optional::after {
            content: ' (선택)';
            color: #999;
        }
        
        .check-all {
            padding: 15px;
            background-color: var(--bs-primary-light);
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .check-all .checkbox-label {
            font-weight: bold;
            color: #333;
        }
        
        /* 기타 스타일 생략... */
        
        /* 스텝 콘텐츠 */
        .step-content {
            display: none;
            opacity: 0;
            transition: opacity 0.5s ease;
        }
        
        .step-content.active {
            display: block;
            opacity: 1;
        }
        
        /* 알림 메시지 스타일 */
        .alert {
            margin-bottom: 20px;
            border-radius: 8px;
            padding: 15px;
        }
        
        /* 로딩 스피너 */
        .spinner-container {
            display: none;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 9999;
        }
        
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid var(--bs-primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* 기타 필요한 스타일 추가... */
    </style>
</head>
<body>
    <!-- 로딩 스피너 -->
    <div class="spinner-container" id="loading-spinner">
        <div class="spinner"></div>
    </div>
    
    <div class="container">
        <!-- 로고 영역 -->
        <div class="logo-section">
            <div style="width: 200px; height: 80px; background-color: var(--bs-primary-light); border-radius: 10px; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                <span style="color: var(--bs-primary); font-size: 24px; font-weight: bold;">학습메이트</span>
            </div>
            <h1>회원가입</h1>
        </div>
        
        <!-- 회원가입 카드 -->
        <div class="signup-card">
            <!-- 스텝 프로그레스 -->
            <div class="step-progress">
                <div class="step-progress-bar" id="progress-bar"></div>
                <div class="step active" id="step-1">
                    <div class="step-circle">1</div>
                    <div class="step-label">약관동의</div>
                </div>
                <div class="step" id="step-2">
                    <div class="step-circle">2</div>
                    <div class="step-label">정보입력</div>
                </div>
                <div class="step" id="step-3">
                    <div class="step-circle">3</div>
                    <div class="step-label">가입완료</div>
                </div>
            </div>
            
            <!-- 알림 메시지 영역 -->
            <div id="alert-container"></div>
            
            <!-- 약관동의 스텝 -->
            <div class="step-content active" id="step-1-content">
                <h2 class="card-title">약관 동의</h2>
                
                <div class="check-all">
                    <div class="checkbox-item">
                        <input type="checkbox" id="check-all" class="checkbox-input">
                        <label for="check-all" class="checkbox-label">모든 약관에 동의합니다</label>
                    </div>
                </div>
                
                <div class="terms-checkbox-group">
                    <div class="checkbox-item">
                        <input type="checkbox" id="terms-1" class="checkbox-input terms-checkbox required-checkbox">
                        <label for="terms-1" class="checkbox-label required">이용약관 동의</label>
                    </div>
                    
                    <div class="terms-container">
                        <h3 class="terms-title">이용약관</h3>
                        <div class="terms-text">
                            <p>제1조 (목적)<br>
                            이 약관은 학습메이트(이하 "회사"라 함)가 제공하는 온라인 서비스(이하 "서비스"라 함)의 이용조건 및 절차, 회사와 회원 간의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
                            
                            <!-- 약관 내용 -->
                        </div>
                    </div>
                    
                    <div class="checkbox-item">
                        <input type="checkbox" id="terms-2" class="checkbox-input terms-checkbox required-checkbox">
                        <label for="terms-2" class="checkbox-label required">개인정보 수집 및 이용 동의</label>
                    </div>
                    
                    <div class="terms-container">
                        <h3 class="terms-title">개인정보 수집 및 이용 안내</h3>
                        <div class="terms-text">
                            <p>학습메이트는 회원가입, 상담, 서비스 제공 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.</p>
                            
                            <!-- 개인정보 수집 및 이용 내용 -->
                        </div>
                    </div>
                    
                    <div class="checkbox-item">
                        <input type="checkbox" id="terms-3" class="checkbox-input terms-checkbox required-checkbox">
                        <label for="terms-3" class="checkbox-label required">만 14세 이상 확인</label>
                    </div>
                    
                    <div class="checkbox-item">
                        <input type="checkbox" id="terms-4" class="checkbox-input terms-checkbox">
                        <label for="terms-4" class="checkbox-label optional">마케팅 정보 수신 동의</label>
                    </div>
                </div>
                
                <div class="button-group">
                    <button type="button" class="btn btn-secondary" id="back-to-home-btn">취소</button>
                    <button type="button" class="btn btn-primary" id="next-step-1-btn">다음</button>
                </div>
            </div>
            
            <!-- 정보입력 스텝 -->
            <div class="step-content" id="step-2-content">
                <h2 class="card-title">회원 정보 입력</h2>
                
                <form id="signup-form">
                    <!-- 이름 입력 -->
                    <div class="form-group">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" id="name" name="name" class="form-input" placeholder="이름을 입력하세요" required>
                    </div>
                    
                    <!-- 회원구분 선택 -->
                    <div class="form-group">
                        <label class="form-label">회원구분</label>
                        <div class="radio-group">
                            <div class="radio-item">
                                <input type="radio" id="user-type-general" name="userType" class="radio-input" value="general" checked>
                                <label for="user-type-general" class="radio-label">일반회원</label>
                            </div>
                            <div class="radio-item">
                                <input type="radio" id="user-type-student" name="userType" class="radio-input" value="student">
                                <label for="user-type-student" class="radio-label">학생회원</label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 학생증 인증 (회원구분이 학생일 때만 표시) -->
                    <div class="form-group" id="student-verification" style="display: none;">
                        <label class="form-label">학생증 인증</label>
                        <div class="file-upload">
                            <label for="student-id-upload" class="file-upload-label">
                                <div class="file-upload-icon">
                                    <i class="bi bi-camera"></i>
                                </div>
                                <div class="file-upload-text">
                                    학생증 사진을 업로드하세요<br>
                                    <small>(JPG, PNG 파일 / 10MB 이하)</small>
                                </div>
                            </label>
                            <input type="file" id="student-id-upload" name="studentIdFile" class="file-upload-input" accept="image/*">
                        </div>
                        <div id="upload-preview" style="display: none; margin-top: 10px; text-align: center;">
                            <img id="preview-image" src="" alt="학생증 미리보기" style="max-width: 100%; max-height: 200px; border-radius: 8px;">
                            <div style="margin-top: 10px;">
                                <button type="button" class="btn btn-secondary" id="cancel-upload-btn">취소</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 생년월일 입력 -->
                    <div class="form-group">
                        <label class="form-label">생년월일</label>
                        <div class="birth-inputs">
                            <input type="text" id="birth-year" name="birthYear" class="form-input" placeholder="년(4자리)" maxlength="4" required>
                            <div class="birth-separator">-</div>
                            <input type="text" id="birth-month" name="birthMonth" class="form-input" placeholder="월" maxlength="2" required>
                            <div class="birth-separator">-</div>
                            <input type="text" id="birth-day" name="birthDay" class="form-input" placeholder="일" maxlength="2" required>
                        </div>
                    </div>
                    
                    <!-- 휴대폰번호 입력 및 인증 -->
                    <div class="form-group">
                        <label class="form-label">휴대폰번호</label>
                        <div class="input-group">
                            <input type="tel" id="phone" name="phone" class="form-input" placeholder="'-' 없이 숫자만 입력" maxlength="11" required>
                            <button type="button" class="btn btn-secondary" id="send-verification-btn">인증번호 전송</button>
                        </div>
                        <div class="input-group" id="phone-verification" style="display: none;">
                            <input type="text" id="verification-code" class="form-input" placeholder="인증번호 6자리 입력" maxlength="6">
                            <button type="button" class="btn btn-primary" id="verify-phone-btn">확인</button>
                            <div id="verification-timer" style="display: flex; align-items: center; margin-left: 10px; color: var(--bs-accent); font-weight: bold;">03:00</div>
                        </div>
                        <div id="phone-verified" style="display: none; margin-top: 10px;">
                            <span class="verified-badge"><i class="bi bi-check-circle"></i> 인증완료</span>
                        </div>
                    </div>
                    
                    <!-- 이메일 입력 및 인증 -->
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <div class="input-group">
                            <input type="email" id="email" name="email" class="form-input" placeholder="이메일 주소 입력" required>
                            <button type="button" class="btn btn-secondary" id="send-email-verification-btn">이메일 인증</button>
                        </div>
                        <div class="input-group" id="email-verification" style="display: none;">
                            <input type="text" id="email-verification-code" class="form-input" placeholder="인증번호 6자리 입력" maxlength="6">
                            <button type="button" class="btn btn-primary" id="verify-email-btn">확인</button>
                            <div id="email-verification-timer" style="display: flex; align-items: center; margin-left: 10px; color: var(--bs-accent); font-weight: bold;">05:00</div>
                        </div>
                        <div id="email-verified" style="display: none; margin-top: 10px;">
                            <span class="verified-badge"><i class="bi bi-check-circle"></i> 인증완료</span>
                        </div>
                    </div>
                    
                    <!-- 주소 입력 -->
                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <div class="input-group">
                            <input type="text" id="postcode" name="postcode" class="form-input" placeholder="우편번호" readonly required>
                            <button type="button" class="btn btn-secondary" id="find-address-btn">주소 찾기</button>
                        </div>
                        <div class="address-inputs">
                            <input type="text" id="address" name="address" class="form-input" placeholder="기본주소" style="margin-bottom: 10px;" readonly required>
                            <input type="text" id="address-detail" name="addressDetail" class="form-input" placeholder="상세주소 입력" required>
                        </div>
                    </div>
                    
                    <!-- 비밀번호 설정 -->
                    <div class="form-group">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" id="password" name="password" class="form-input" placeholder="영문, 숫자, 특수문자 조합 8-20자" required>
                        <div style="margin-top: 5px; font-size: 12px; color: #888;">
                            <span id="password-strength" class="password-strength">안전도: 낮음</span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password-confirm" class="form-label">비밀번호 확인</label>
                        <input type="password" id="password-confirm" name="password-confirm" class="form-input" placeholder="비밀번호 재입력" required>
                        <div id="password-match" style="display: none; margin-top: 5px; font-size: 12px; color: var(--bs-primary);">
                            <i class="bi bi-check-circle"></i> 비밀번호가 일치합니다
                        </div>
                        <div id="password-mismatch" style="display: none; margin-top: 5px; font-size: 12px; color: #ff6b6b;">
                            <i class="bi bi-exclamation-circle"></i> 비밀번호가 일치하지 않습니다
                        </div>
                    </div>
                    
                    <div class="button-group">
                        <button type="button" class="btn btn-secondary" id="prev-step-2-btn">이전</button>
                        <button type="button" class="btn btn-primary" id="next-step-2-btn">가입하기</button>
                    </div>
                </form>
            </div>
            
            <!-- 가입완료 스텝 -->
            <div class="step-content" id="step-3-content">
                <div class="signup-complete-box">
                    <div class="signup-complete-icon">
                        <i class="bi bi-check-circle"></i>
                    </div>
                    <h2 class="signup-complete-title">회원가입이 완료되었습니다!</h2>
                    <p class="signup-complete-message">
                        학습메이트의 회원이 되신 것을 환영합니다.<br>
                        다양한 학습 콘텐츠와 서비스를 이용해보세요.
                    </p>
                    <a href="<%= request.getContextPath() %>/user/login.do" class="btn btn-primary btn-lg" id="go-login-btn">로그인하기</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 다음 주소 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <!-- 회원가입 스크립트 -->
    <script>
        $(document).ready(function() {
            // 진행 단계 관련 요소
            const progressBar = $('#progress-bar');
            const steps = $('.step');
            
            // 각 단계별 콘텐츠
            const stepContents = $('.step-content');
            
            // 현재 단계 (1부터 시작)
            let currentStep = 1;
            
            // 타이머 변수
            let phoneTimerInterval;
            let emailTimerInterval;
            
            // 프로그레스 바 업데이트 함수
            function updateProgressBar() {
                const percent = ((currentStep - 1) / (steps.length - 1)) * 100;
                progressBar.css('width', percent + '%');
            }
            
            // 단계 변경 함수
            function goToStep(step) {
                // 페이지 상단으로 스크롤
                window.scrollTo(0, 0);
                
                // 이전 단계 비활성화
                steps.eq(currentStep - 1).removeClass('active');
                
                // 콘텐츠 페이드 아웃
                stepContents.eq(currentStep - 1).removeClass('active');
                
                // 단계 설정
                currentStep = step;
                
                // 현재까지의 단계 활성화 (이전 단계는 completed로 표시)
                steps.each(function(index) {
                    if (index < currentStep - 1) {
                        $(this).addClass('completed').removeClass('active');
                    } else if (index === currentStep - 1) {
                        $(this).addClass('active').removeClass('completed');
                    } else {
                        $(this).removeClass('active completed');
                    }
                });
                
                // 새 콘텐츠 페이드 인
                setTimeout(function() {
                    stepContents.eq(currentStep - 1).addClass('active');
                }, 300);
                
                // 프로그레스 바 업데이트
                updateProgressBar();
            }
            
            // 알림 메시지 표시 함수
            function showAlert(message, type = 'danger') {
                $('#alert-container').html(
                    `<div class="alert alert-${type}" role="alert">
                        ${message}
                    </div>`
                );
                
                // 자동 제거 (3초 후)
                setTimeout(function() {
                    $('#alert-container').empty();
                }, 3000);
            }
            
            // 로딩 스피너 표시/숨김 함수
            function showLoading(show = true) {
                if (show) {
                    $('#loading-spinner').css('display', 'flex');
                } else {
                    $('#loading-spinner').css('display', 'none');
                }
            }
            
            // 약관 관련 이벤트
            const checkAll = $('#check-all');
            const termsCheckboxes = $('.terms-checkbox');
            const requiredCheckboxes = $('.required-checkbox');
            
            // 전체 약관 동의 처리
            checkAll.on('change', function() {
                termsCheckboxes.prop('checked', this.checked);
            });
            
            // 개별 약관 변경 시 전체 동의 체크박스 상태 업데이트
            termsCheckboxes.on('change', function() {
                const allChecked = termsCheckboxes.length === termsCheckboxes.filter(':checked').length;
                checkAll.prop('checked', allChecked);
            });
            
            // 1단계에서 다음 버튼 클릭 (약관 동의 처리)
            $('#next-step-1-btn').on('click', function() {
                // 필수 약관 동의 체크
                const allRequiredChecked = requiredCheckboxes.length === requiredCheckboxes.filter(':checked').length;
                
                if (!allRequiredChecked) {
                    showAlert('필수 약관에 모두 동의해주세요.');
                    return;
                }
                
                // AJAX 요청 준비
                const terms1 = $('#terms-1').prop('checked') ? 'on' : 'off';
                const terms2 = $('#terms-2').prop('checked') ? 'on' : 'off';
                const terms3 = $('#terms-3').prop('checked') ? 'on' : 'off';
                const terms4 = $('#terms-4').prop('checked') ? 'on' : 'off';
                
                // 로딩 표시
                showLoading();
                
                // AJAX 요청
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'validateTerms',
                        terms1: terms1,
                        terms2: terms2,
                        terms3: terms3,
                        terms4: terms4
                    },
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            // 다음 단계로 이동
                            goToStep(2);
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showLoading(false);
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            });
            
            // 2단계에서 이전 버튼 클릭
            $('#prev-step-2-btn').on('click', function() {
                goToStep(1);
            });
            
            // 회원 유형 변경 시 학생증 인증 영역 표시/숨김
            $('input[name="userType"]').on('change', function() {
                if ($(this).val() === 'student') {
                    $('#student-verification').show();
                } else {
                    $('#student-verification').hide();
                }
            });
            
            // 학생증 이미지 업로드 및 미리보기
            $('#student-id-upload').on('change', function(e) {
                if (e.target.files.length > 0) {
                    const file = e.target.files[0];
                    
                    // 파일 크기 제한 (10MB)
                    if (file.size > 10 * 1024 * 1024) {
                        showAlert('파일 크기는 10MB 이하여야 합니다.');
                        return;
                    }
                    
                    // 이미지 미리보기
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#preview-image').attr('src', e.target.result);
                        $('#upload-preview').show();
                    };
                    reader.readAsDataURL(file);
                }
            });
            
            // 학생증 업로드 취소
            $('#cancel-upload-btn').on('click', function() {
                $('#student-id-upload').val('');
                $('#upload-preview').hide();
            });
            
            // 휴대폰 인증번호 전송
            $('#send-verification-btn').on('click', function() {
                const phone = $('#phone').val().trim();
                
                // 휴대폰 번호 유효성 검사
                if (phone.length !== 11 || !/^\d+$/.test(phone)) {
                    showAlert('올바른 휴대폰 번호를 입력해주세요.');
                    return;
                }
                
                // 중복 체크
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'checkPhoneDuplicate',
                        phone: phone
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            if (response.isDuplicate) {
                                showAlert(response.message);
                            } else {
                                // 인증번호 전송 요청
                                sendPhoneVerificationCode(phone);
                            }
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            });
            
            // 휴대폰 인증번호 전송 요청
            function sendPhoneVerificationCode(phone) {
                showLoading();
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'verifyPhone',
                        phone: phone
                    },
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            showAlert(response.message, 'success');
                            $('#phone-verification').css('display', 'flex');
                            
                            // 테스트용: 인증번호 자동 입력 (실제 서비스에선 제거)
                            $('#verification-code').val(response.code);
                            
                            // 인증 타이머 설정 (3분)
                            startPhoneVerificationTimer();
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showLoading(false);
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            }
            
            // 휴대폰 인증 타이머 시작
            function startPhoneVerificationTimer() {
                // 기존 타이머 제거
                if (phoneTimerInterval) {
                    clearInterval(phoneTimerInterval);
                }
                
                let timeLeft = 180; // 3분
                
                phoneTimerInterval = setInterval(function() {
                    if (timeLeft <= 0) {
                        clearInterval(phoneTimerInterval);
                        $('#verification-timer').text('00:00');
                        showAlert('인증 시간이 만료되었습니다. 다시 시도해주세요.');
                        $('#phone-verification').hide();
                    } else {
                        const minutes = Math.floor(timeLeft / 60);
                        const seconds = timeLeft % 60;
                        $('#verification-timer').text(
                            (minutes < 10 ? '0' + minutes : minutes) + ':' + 
                            (seconds < 10 ? '0' + seconds : seconds)
                        );
                        timeLeft--;
                    }
                }, 1000);
            }
            
            // 휴대폰 인증번호 확인
            $('#verify-phone-btn').on('click', function() {
                const code = $('#verification-code').val().trim();
                const phone = $('#phone').val().trim();
                
                if (code.length !== 6) {
                    showAlert('인증번호 6자리를 입력해주세요.');
                    return;
                }
                
                showLoading();
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'confirmPhoneCode',
                        code: code,
                        phone: phone
                    },
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            // 인증 완료
                            if (phoneTimerInterval) {
                                clearInterval(phoneTimerInterval);
                            }
                            
                            $('#phone-verification').hide();
                            $('#phone-verified').show();
                            $('#phone').prop('readonly', true);
                            $('#send-verification-btn').prop('disabled', true);
                            
                            showAlert(response.message, 'success');
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showLoading(false);
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            });
            
            // 이메일 인증번호 전송
            $('#send-email-verification-btn').on('click', function() {
                const email = $('#email').val().trim();
                
                // 이메일 유효성 검사
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    showAlert('올바른 이메일 주소를 입력해주세요.');
                    return;
                }
                
                // 중복 체크
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'checkEmailDuplicate',
                        email: email
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            if (response.isDuplicate) {
                                showAlert(response.message);
                            } else {
                                // 인증번호 전송 요청
                                sendEmailVerificationCode(email);
                            }
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            });
            
            // 이메일 인증번호 전송 요청
            function sendEmailVerificationCode(email) {
                showLoading();
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'verifyEmail',
                        email: email
                    },
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            showAlert(response.message, 'success');
                            $('#email-verification').css('display', 'flex');
                            
                            // 테스트용: 인증번호 자동 입력 (실제 서비스에선 제거)
                            $('#email-verification-code').val(response.code);
                            
                            // 인증 타이머 설정 (5분)
                            startEmailVerificationTimer();
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showLoading(false);
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            }
            
            // 이메일 인증 타이머 시작
            function startEmailVerificationTimer() {
                // 기존 타이머 제거
                if (emailTimerInterval) {
                    clearInterval(emailTimerInterval);
                }
                
                let timeLeft = 300; // 5분
                
                emailTimerInterval = setInterval(function() {
                    if (timeLeft <= 0) {
                        clearInterval(emailTimerInterval);
                        $('#email-verification-timer').text('00:00');
                        showAlert('인증 시간이 만료되었습니다. 다시 시도해주세요.');
                        $('#email-verification').hide();
                    } else {
                        const minutes = Math.floor(timeLeft / 60);
                        const seconds = timeLeft % 60;
                        $('#email-verification-timer').text(
                            (minutes < 10 ? '0' + minutes : minutes) + ':' + 
                            (seconds < 10 ? '0' + seconds : seconds)
                        );
                        timeLeft--;
                    }
                }, 1000);
            }
            
            // 이메일 인증번호 확인
            $('#verify-email-btn').on('click', function() {
                const code = $('#email-verification-code').val().trim();
                const email = $('#email').val().trim();
                
                if (code.length !== 6) {
                    showAlert('인증번호 6자리를 입력해주세요.');
                    return;
                }
                
                showLoading();
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: {
                        action: 'confirmEmailCode',
                        code: code,
                        email: email
                    },
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            // 인증 완료
                            if (emailTimerInterval) {
                                clearInterval(emailTimerInterval);
                            }
                            
                            $('#email-verification').hide();
                            $('#email-verified').show();
                            $('#email').prop('readonly', true);
                            $('#send-email-verification-btn').prop('disabled', true);
                            
                            showAlert(response.message, 'success');
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showLoading(false);
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            });
            
            // 주소 찾기 버튼 클릭
            $('#find-address-btn').on('click', function() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        $('#postcode').val(data.zonecode);
                        $('#address').val(data.roadAddress || data.jibunAddress);
                        $('#address-detail').focus();
                    }
                }).open();
            });
            
            // 비밀번호 강도 체크
            $('#password').on('input', function() {
                const pw = $(this).val();
                let strength = '';
                let color = '';
                
                if (pw.length === 0) {
                    strength = '안전도: 낮음';
                    color = '#888';
                } else if (pw.length < 8) {
                    strength = '안전도: 낮음';
                    color = '#ff6b6b';
                } else if (pw.length >= 8) {
                    const hasLetter = /[a-zA-Z]/.test(pw);
                    const hasNumber = /\d/.test(pw);
                    const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pw);
                    
                    if (hasLetter && hasNumber && hasSpecial) {
                        strength = '안전도: 높음';
                        color = '#4caf50';
                    } else if ((hasLetter && hasNumber) || (hasLetter && hasSpecial) || (hasNumber && hasSpecial)) {
                        strength = '안전도: 중간';
                        color = '#ffc107';
                    } else {
                        strength = '안전도: 낮음';
                        color = '#ff6b6b';
                    }
                }
                
                $('#password-strength').text(strength).css('color', color);
                
                // 비밀번호 확인 입력값이 있으면 일치 여부 확인
                if ($('#password-confirm').val().length > 0) {
                    checkPasswordMatch();
                }
            });
            
            // 비밀번호 일치 여부 확인
            $('#password-confirm').on('input', checkPasswordMatch);
            
            function checkPasswordMatch() {
                const password = $('#password').val();
                const confirmPassword = $('#password-confirm').val();
                
                if (password === confirmPassword) {
                    $('#password-match').show();
                    $('#password-mismatch').hide();
                } else {
                    $('#password-match').hide();
                    $('#password-mismatch').show();
                }
            }
            
            // 생년월일 입력값 제한 (숫자만)
            $('#birth-year').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            });
            
            $('#birth-month').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
                if (parseInt($(this).val()) > 12) $(this).val('12');
            });
            
            $('#birth-day').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
                if (parseInt($(this).val()) > 31) $(this).val('31');
            });
            
            // 휴대폰 번호 입력값 제한 (숫자만)
            $('#phone').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            });
            
            // 회원가입 완료 버튼 클릭
            $('#next-step-2-btn').on('click', function() {
                // 유효성 검사
                const name = $('#name').val().trim();
                const userType = $('input[name="userType"]:checked').val();
                const birthYear = $('#birth-year').val().trim();
                const birthMonth = $('#birth-month').val().trim();
                const birthDay = $('#birth-day').val().trim();
                const password = $('#password').val();
                const confirmPassword = $('#password-confirm').val();
                const postcode = $('#postcode').val().trim();
                const address = $('#address').val().trim();
                const addressDetail = $('#address-detail').val().trim();
                
                // 기본 입력값 체크
                if (!name || !birthYear || !birthMonth || !birthDay || !password || !postcode || !address || !addressDetail) {
                    showAlert('모든 필수 항목을 입력해주세요.');
                    return;
                }
                
                // 비밀번호 일치 확인
                if (password !== confirmPassword) {
                    showAlert('비밀번호가 일치하지 않습니다.');
                    return;
                }
                
                // 비밀번호 유효성 검사
                if (password.length < 8) {
                    showAlert('비밀번호는 8자 이상으로 설정해주세요.');
                    return;
                }
                
                // 휴대폰/이메일 인증 확인
                if ($('#phone-verified').css('display') === 'none') {
                    showAlert('휴대폰 인증을 완료해주세요.');
                    return;
                }
                
                if ($('#email-verified').css('display') === 'none') {
                    showAlert('이메일 인증을 완료해주세요.');
                    return;
                }
                
                // 학생회원 선택 시 학생증 업로드 확인
                if (userType === 'student' && $('#student-id-upload')[0].files.length === 0) {
                    showAlert('학생증 사진을 업로드해주세요.');
                    return;
                }
                
                // 회원가입 요청
                enrollUser();
            });
            
            // 회원가입 요청 함수
            function enrollUser() {
                showLoading();
                
                // FormData 객체 생성 (파일 업로드 포함)
                const formData = new FormData();
                
                // 일반 데이터 추가
                formData.append('action', 'enrollUser');
                formData.append('name', $('#name').val().trim());
                formData.append('userType', $('input[name="userType"]:checked').val());
                formData.append('birthYear', $('#birth-year').val().trim());
                formData.append('birthMonth', $('#birth-month').val().trim());
                formData.append('birthDay', $('#birth-day').val().trim());
                formData.append('postcode', $('#postcode').val().trim());
                formData.append('address', $('#address').val().trim());
                formData.append('addressDetail', $('#address-detail').val().trim());
                formData.append('password', $('#password').val());
                
                // 학생증 파일 추가
                if ($('input[name="userType"]:checked').val() === 'student') {
                    const studentIdFile = $('#student-id-upload')[0].files[0];
                    if (studentIdFile) {
                        formData.append('studentIdFile', studentIdFile);
                    }
                }
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/enroll.do',
                    type: 'POST',
                    data: formData,
                    processData: false, // FormData 처리 방지
                    contentType: false, // Content-Type 헤더 설정 방지
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            // 회원가입 성공, 3단계로 이동
                            goToStep(3);
                        } else {
                            showAlert(response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        showLoading(false);
                        showAlert('요청 처리 중 오류가 발생했습니다.');
                        console.error(error);
                    }
                });
            }
            
            // 메인으로 돌아가기 버튼
            $('#back-to-home-btn').on('click', function() {
                if (confirm('회원가입을 취소하시겠습니까?')) {
                    window.location.href = '<%= request.getContextPath() %>/';
                }
            });
            
            // 초기 프로그레스 바 설정
            updateProgressBar();
        });
    </script>
</body>
</html>