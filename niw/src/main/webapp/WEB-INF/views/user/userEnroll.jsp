<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습메이트 - 회원가입</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/common.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources//css/header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/footer.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/enroll.css">
    
    <!-- 회원가입 페이지용 추가 스타일 -->
    <style>
        :root {
            --bs-primary: #24b1b5;
            --bs-primary-rgb: 36, 177, 181;
            --bs-primary-hover: #1e9599;
            --bs-primary-light: #e3f6f7;
            --bs-accent: #ff7d4d;
        }
        
        /* 아이디 입력창 크기 조정 */
        #userid {
            width: 95% !important;
            max-width: 590px !important;
            min-width: 340px !important;
            border-radius: 6px !important;
        }
    </style>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- 헤더 포함 -->
    <%@ include file="../common/header.jsp" %>
    
    <!-- 로딩 스피너 -->
    <div class="spinner-container" id="loading-spinner">
        <div class="spinner"></div>
    </div>
    
    <div class="signup-container">
        <!-- 로고 영역 -->
        <div class="logo-section">
            <div class="logo-placeholder">
                <span class="logo-text">학습메이트</span>
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
                            <p><strong>제1조 (목적)</strong><br>
                            이 약관은 학습메이트(이하 "회사"라 함)가 제공하는 온라인 서비스(이하 "서비스"라 함)의 이용조건 및 절차, 회사와 회원 간의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
                            
                            <p><strong>제2조 (정의)</strong><br>
                            1. "서비스"라 함은 회사가 제공하는 학습 관련 온라인 플랫폼 및 관련 서비스를 의미합니다.<br>
                            2. "회원"이라 함은 회사의 서비스에 접속하여 이 약관에 따라 회사와 이용계약를 체결하고 회사가 제공하는 서비스를 이용하는 고객을 말합니다.</p>
                            
                            <p><strong>제3조 (약관의 효력 및 변경)</strong><br>
                            1. 이 약관은 서비스를 이용하고자 하는 모든 회원에 대하여 그 효력을 발생합니다.<br>
                            2. 회사는 필요하다고 인정되는 경우 이 약관을 변경할 수 있으며, 변경된 약관은 서비스 내 공지사항을 통해 공지됩니다.</p>
                        </div>
                    </div>
                    
                    <div class="checkbox-item">
                        <input type="checkbox" id="terms-2" class="checkbox-input terms-checkbox required-checkbox">
                        <label for="terms-2" class="checkbox-label required">개인정보 수집 및 이용 동의</label>
                    </div>
                    
                    <div class="terms-container">
                        <h3 class="terms-title">개인정보 수집 및 이용 안내</h3>
                        <div class="terms-text">
                            <p><strong>수집하는 개인정보 항목</strong><br>
                            - 필수항목: 이름, 이메일, 휴대폰번호, 생년월일, 주소, 비밀번호<br>
                            - 선택항목: 마케팅 수신 동의</p>
                            
                            <p><strong>개인정보 수집 및 이용목적</strong><br>
                            - 회원 가입 및 관리<br>
                            - 서비스 제공 및 운영<br>
                            - 고객 상담 및 불만처리</p>
                            
                            <p><strong>개인정보 보유 및 이용기간</strong><br>
                            회원 탈퇴 시까지 보유하며, 탈퇴 시 즉시 파기합니다.</p>
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
                
				<form id="signup-form" method="post">
                    <!-- 아이디 입력 및 중복검사 -->
                    <div class="form-group">
                        <label for="userid" class="form-label">아이디</label>
                        <div style="display: flex; align-items: center; width: 100%;">
                            <input type="text" id="userid" name="userid" class="form-input" placeholder="영문, 숫자, _ 사용하여 4-20자 입력가능합니다." required>
                        </div>
                        <div id="userid-verified" style="display: none; margin-top: 10px;">
                            <span class="verified-badge"><i class="bi bi-check-circle"></i> 사용 가능한 아이디입니다</span>
                        </div>
                        <div class="invalid-feedback" id="userid-error"></div>
                    </div>
                    
                    <!-- 이름 입력 -->
                    <div class="form-group">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" id="name" name="name" class="form-input" placeholder="이름을 입력하세요" required>
                        <div class="invalid-feedback" id="name-error"></div>
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
                        <div class="invalid-feedback" id="birth-error"></div>
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
                            <div class="verification-timer" id="email-verification-timer">05:00</div>
                        </div>
                        <div id="email-verified" style="display: none; margin-top: 10px;">
                            <span class="verified-badge"><i class="bi bi-check-circle"></i> 인증완료</span>
                        </div>
                        <div class="invalid-feedback" id="email-error"></div>
                    </div>
                    
                    <!-- 주소 입력 -->
                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <div class="input-group">
                            <input type="text" id="postcode" name="postcode" class="form-input" placeholder="우편번호" readonly required>
                            <button type="button" class="btn btn-secondary" id="find-address-btn">주소 찾기</button>
                        </div>
                        <div class="address-inputs">
                            <input type="text" id="address" name="address" class="form-input" placeholder="기본주소" readonly required>
                            <input type="text" id="address-detail" name="addressDetail" class="form-input" placeholder="상세주소 입력" required>
                        </div>
                        <div class="invalid-feedback" id="address-error"></div>
                    </div>
                    
                    <!-- 비밀번호 설정 -->
                    <div class="form-group">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" id="password" name="password" class="form-input" placeholder="영문, 숫자, 특수문자 조합 8-20자" required>
                        <div style="margin-top: 5px; font-size: 12px;">
                            <span id="password-strength" class="password-strength">안전도: 낮음</span>
                        </div>
                        <div class="invalid-feedback" id="password-error"></div>
                    </div>
                    
                    <div class="form-group">
                        <label for="password-confirm" class="form-label">비밀번호 확인</label>
                        <input type="password" id="password-confirm" name="password-confirm" class="form-input" placeholder="비밀번호 재입력" required>
                        <div id="password-match" style="display: none; margin-top: 5px; font-size: 12px; color: #28a745;">
                            <i class="bi bi-check-circle"></i> 비밀번호가 일치합니다
                        </div>
                        <div id="password-mismatch" style="display: none; margin-top: 5px; font-size: 12px; color: #dc3545;">
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
    
    <!-- 풋터 포함 -->
    <%@ include file="../common/footer.jsp" %>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- 다음 주소 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <!-- 회원가입 스크립트 -->
    <script>
    $("#userid").keyup(((request)=>e=>{
        console.log(request);
        if(request) clearTimeout(request);
        request=setTimeout(()=>{
            console.log(request);
            const userId=e.target.value.trim();
            
            // 길이 체크 먼저 (4자 미만이면 요청하지 않음)
            if(userId.length < 4) {
                $(e.target).next().remove();
                return;
            }
            
            //디바운서 -> 특정 딜레이시간을 발생시켜서 로직실행을 지연시킴
            fetch("<%=request.getContextPath()%>/user/checkUserId.do?id="+userId)
            .then(response=>{
                if(response.ok){
                    return response.json();
                }else{
                    alert("요청실패"+response.status);
                }
            }).then(data=>{
                $(e.target).next().remove();
                console.log(data);
                if(data.result){
                    $(e.target).after($("<span>").text("사용할 수 있는 아이디").css({
                        "color":"green",
                        "margin-left":"10px",
                        "display":"inline-flex",
                        "align-items":"center",
                        "font-size":"14px",
                        "font-weight":"500"
                    }));
                }else{
                    $(e.target).after($("<span>").text("사용할 수 없는 아이디").css({
                        "color":"red",
                        "margin-left":"10px",
                        "display":"inline-flex",
                        "align-items":"center",
                        "font-size":"14px",
                        "font-weight":"500"
                    }));
                }
            })
        },300);
    })());
    
        $(document).ready(function() {
            // 아이디 입력창 크기 강제 적용 (여러 번 시도)
            function applyUserIdStyle() {
                $('#userid').css({
                    'width': '95%',
                    'max-width': '590px',
                    'border-radius': '6px',
                    'min-width': '340px'
                });
            }
            
            applyUserIdStyle();
            setTimeout(applyUserIdStyle, 100);
            setTimeout(applyUserIdStyle, 500);
            
            // 진행 단계 관련 요소
            const progressBar = $('#progress-bar');
            const steps = $('.step');
            
            // 각 단계별 콘텐츠
            const stepContents = $('.step-content');
            
            // 현재 단계 (1부터 시작)
            let currentStep = 1;
            
            // 타이머 변수
            let emailTimerInterval;
            
            // 이메일 인증 완료 여부
            let isEmailVerified = false;
            
            // 기존 이메일/사용자 목록 (실제로는 서버에서 가져와야 함)
            const existingEmails = [
                'test@example.com',
                'user@test.com',
                'admin@example.org'
            ];
            
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
            
            // 유효성 검사 함수들
            function validateUserId(userid) {
                if (!userid || userid.trim().length < 4) {
                    return '아이디는 4자 이상 입력해주세요.';
                }
                if (userid.length > 20) {
                    return '아이디는 20자 이하로 입력해주세요.';
                }
                if (!/^[a-zA-Z0-9_]+$/.test(userid)) {
                    return '아이디는 영문, 숫자, _만 사용 가능합니다.';
                }
                return null;
            }
            
            function validateName(name) {
                if (!name || name.trim().length < 2) {
                    return '이름은 2자 이상 입력해주세요.';
                }
                if (!/^[가-힣a-zA-Z\s]+$/.test(name)) {
                    return '이름은 한글 또는 영문만 입력 가능합니다.';
                }
                return null;
            }
            
            function validateEmail(email) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!email) {
                    return '이메일을 입력해주세요.';
                }
                if (!emailRegex.test(email)) {
                    return '올바른 이메일 형식을 입력해주세요.';
                }
                if (existingEmails.includes(email.toLowerCase())) {
                    return '이미 사용중인 이메일입니다.';
                }
                return null;
            }
            
            function validateBirth(year, month, day) {
                if (!year || !month || !day) {
                    return '생년월일을 모두 입력해주세요.';
                }
                
                const currentYear = new Date().getFullYear();
                const birthYear = parseInt(year);
                const birthMonth = parseInt(month);
                const birthDay = parseInt(day);
                
                if (birthYear < 1900 || birthYear > currentYear) {
                    return '올바른 년도를 입력해주세요.';
                }
                if (birthMonth < 1 || birthMonth > 12) {
                    return '올바른 월을 입력해주세요.';
                }
                if (birthDay < 1 || birthDay > 31) {
                    return '올바른 일을 입력해주세요.';
                }
                
                // 실제 날짜 유효성 검사
                const birthDate = new Date(birthYear, birthMonth - 1, birthDay);
                if (birthDate.getFullYear() !== birthYear || 
                    birthDate.getMonth() !== birthMonth - 1 || 
                    birthDate.getDate() !== birthDay) {
                    return '존재하지 않는 날짜입니다.';
                }
                
                // 만 14세 이상 검사
                const today = new Date();
                const age = today.getFullYear() - birthYear;
                if (age < 14 || (age === 14 && today < new Date(today.getFullYear(), birthMonth - 1, birthDay))) {
                    return '만 14세 이상만 가입 가능합니다.';
                }
                
                return null;
            }
            
            function validatePassword(password) {
                if (!password) {
                    return '비밀번호를 입력해주세요.';
                }
                if (password.length < 8 || password.length > 20) {
                    return '비밀번호는 8-20자로 입력해주세요.';
                }
                
                const hasLetter = /[a-zA-Z]/.test(password);
                const hasNumber = /\d/.test(password);
                const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
                
                if (!(hasLetter && hasNumber && hasSpecial)) {
                    return '영문, 숫자, 특수문자를 모두 포함해야 합니다.';
                }
                
                return null;
            }
            
            // 실시간 유효성 검사
            $('#userid').on('input', function() {
                // 허용되지 않는 문자 제거 (영문, 숫자, _ 만 허용)
                $(this).val($(this).val().replace(/[^a-zA-Z0-9_]/g, ''));
            });
            
            $('#userid').on('blur', function() {
                const userid = $(this).val().trim();
                const error = validateUserId(userid);
                if (error) {
                    $(this).addClass('is-invalid');
                    $('#userid-error').text(error).show();
                } else {
                    $(this).removeClass('is-invalid').addClass('valid');
                    $('#userid-error').hide();
                }
            });
            
            $('#name').on('blur', function() {
                const name = $(this).val().trim();
                const error = validateName(name);
                if (error) {
                    $(this).addClass('is-invalid');
                    $('#name-error').text(error).show();
                } else {
                    $(this).removeClass('is-invalid').addClass('valid');
                    $('#name-error').hide();
                }
            });
            
            $('#email').on('blur', function() {
                const email = $(this).val().trim();
                const error = validateEmail(email);
                if (error) {
                    $(this).addClass('is-invalid');
                    $('#email-error').text(error).show();
                } else {
                    $(this).removeClass('is-invalid').addClass('valid');
                    $('#email-error').hide();
                }
            });
            
            $('#birth-year, #birth-month, #birth-day').on('blur', function() {
                const year = $('#birth-year').val().trim();
                const month = $('#birth-month').val().trim();
                const day = $('#birth-day').val().trim();
                
                if (year && month && day) {
                    const error = validateBirth(year, month, day);
                    if (error) {
                        $('#birth-year, #birth-month, #birth-day').addClass('is-invalid');
                        $('#birth-error').text(error).show();
                    } else {
                        $('#birth-year, #birth-month, #birth-day').removeClass('is-invalid').addClass('valid');
                        $('#birth-error').hide();
                    }
                }
            });
            
            $('#password').on('blur', function() {
                const password = $(this).val();
                const error = validatePassword(password);
                if (error) {
                    $(this).addClass('is-invalid');
                    $('#password-error').text(error).show();
                } else {
                    $(this).removeClass('is-invalid').addClass('valid');
                    $('#password-error').hide();
                }
            });
            
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
                
                // 다음 단계로 이동
                goToStep(2);
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
            
            // 이메일 인증번호 전송
            $('#send-email-verification-btn').on('click', function() {
                const email = $('#email').val().trim();
                const error = validateEmail(email);
                
                if (error) {
                    showAlert(error);
                    return;
                }
                
                // 서버로 인증번호 발송 요청
                sendEmailVerificationCode(email);
            });
            
            // 이메일 인증번호 전송 요청
            function sendEmailVerificationCode(email) {
                showLoading();
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/sendEmailVerification.do',
                    type: 'POST',
                    data: {
                        email: email
                    },
                    dataType: 'json',
                    success: function(response) {
                        showLoading(false);
                        
                        if (response.success) {
                            showAlert('인증번호가 발송되었습니다.', 'success');
                            $('#email-verification').css('display', 'flex');
                            
                            // 인증 타이머 시작 (5분)
                            startEmailVerificationTimer();
                            
                            // 이메일 입력란 비활성화
                            $('#email').prop('readonly', true);
                            $('#send-email-verification-btn').prop('disabled', true);
                        } else {
                            showAlert(response.message || '인증번호 발송에 실패했습니다.');
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
                        $('#email').prop('readonly', false);
                        $('#send-email-verification-btn').prop('disabled', false);
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
                    url: '<%= request.getContextPath() %>/user/verifyEmailCode.do',
                    type: 'POST',
                    data: {
                        email: email,
                        code: code
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
                            isEmailVerified = true;
                            
                            showAlert('이메일 인증이 완료되었습니다.', 'success');
                        } else {
                            showAlert(response.message || '인증번호가 일치하지 않습니다.');
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
                    color = '#dc3545';
                } else if (pw.length >= 8) {
                    const hasLetter = /[a-zA-Z]/.test(pw);
                    const hasNumber = /\d/.test(pw);
                    const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pw);
                    
                    if (hasLetter && hasNumber && hasSpecial) {
                        strength = '안전도: 높음';
                        color = '#28a745';
                    } else if ((hasLetter && hasNumber) || (hasLetter && hasSpecial) || (hasNumber && hasSpecial)) {
                        strength = '안전도: 중간';
                        color = '#ffc107';
                    } else {
                        strength = '안전도: 낮음';
                        color = '#dc3545';
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
            
            // 회원가입 완료 버튼 클릭
          $('#next-step-2-btn').on('click', function(e) {
    			e.preventDefault(); 
                // 전체 유효성 검사
                if (!validateForm()) {
                    return;
                }
          
                // 회원가입 요청
                enrollUser();
            }); 
            
            // 전체 폼 유효성 검사
            function validateForm() {
                let isValid = true;
                
                // 아이디 검사
                const userid = $('#userid').val().trim();
                const useridError = validateUserId(userid);
                if (useridError) {
                    showAlert(useridError);
                    $('#userid').focus();
                    return false;
                }
                
                // 이름 검사
                const name = $('#name').val().trim();
                const nameError = validateName(name);
                if (nameError) {
                    showAlert(nameError);
                    $('#name').focus();
                    return false;
                }
                
                // 생년월일 검사
                const year = $('#birth-year').val().trim();
                const month = $('#birth-month').val().trim();
                const day = $('#birth-day').val().trim();
                const birthError = validateBirth(year, month, day);
                if (birthError) {
                    showAlert(birthError);
                    $('#birth-year').focus();
                    return false;
                }
                
                // 이메일 인증 확인
                if (!isEmailVerified) {
                    showAlert('이메일 인증을 완료해주세요.');
                    return false;
                }
                
                // 주소 확인
                if (!$('#postcode').val() || !$('#address').val() || !$('#address-detail').val().trim()) {
                    showAlert('주소를 모두 입력해주세요.');
                    $('#find-address-btn').focus();
                    return false;
                }
                
                // 비밀번호 검사
                const password = $('#password').val();
                const passwordError = validatePassword(password);
                if (passwordError) {
                    showAlert(passwordError);
                    $('#password').focus();
                    return false;
                }
                
                // 비밀번호 일치 확인
                if (password !== $('#password-confirm').val()) {
                    showAlert('비밀번호가 일치하지 않습니다.');
                    $('#password-confirm').focus();
                    return false;
                }
                
                // 학생회원 선택 시 학생증 업로드 확인
                const userType = $('input[name="userType"]:checked').val();
                if (userType === 'student' && $('#student-id-upload')[0].files.length === 0) {
                    showAlert('학생증 사진을 업로드해주세요.');
                    return false;
                }
                
                return true;
            }
            
            // 회원가입 요청 함수
            function enrollUser() {
            	//디버깅용 콘솔출력
            	console.log("=== enrollUser 함수 시작 ===");
                console.log("userid 값:", $('#userid').val());
                console.log("name 값:", $('#name').val());
                console.log("email 값:", $('#email').val());
                console.log("userType 값:", $('input[name="userType"]:checked').val());
               
                showLoading();
                
                // FormData 객체 생성 (파일 업로드 포함)
                const formData = new FormData();
                
                
                // 일반 데이터 추가
                formData.append('userid', $('#userid').val().trim());
                formData.append('name', $('#name').val().trim());
                formData.append('userType', $('input[name="userType"]:checked').val());
                formData.append('birthYear', $('#birth-year').val().trim());
                formData.append('birthMonth', $('#birth-month').val().trim());
                formData.append('birthDay', $('#birth-day').val().trim());
                formData.append('email', $('#email').val().trim());
                formData.append('postcode', $('#postcode').val().trim());
                formData.append('address', $('#address').val().trim());
                formData.append('addressDetail', $('#address-detail').val().trim());
                formData.append('password', $('#password').val());
                
                // 약관 동의 정보
                formData.append('terms1', $('#terms-1').prop('checked') ? 'Y' : 'N');
                formData.append('terms2', $('#terms-2').prop('checked') ? 'Y' : 'N');
                formData.append('terms3', $('#terms-3').prop('checked') ? 'Y' : 'N');
                formData.append('terms4', $('#terms-4').prop('checked') ? 'Y' : 'N');
                
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
                            // 회원가입 성공, 3단계로 이동
                            goToStep(3);
                        } else {
                            showAlert(response.message || '회원가입에 실패했습니다.');
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