<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<%@ include file="/WEB-INF/views/common/header.jsp"%>

 <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/find.css">

<body>
    <div class="container">
        <!-- 로고 영역 -->
        <div class="logo-section">
            <div style="width: 200px; height: 80px; background-color: var(--bs-primary-light); border-radius: 10px; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
                <span style="color: var(--bs-primary); font-size: 24px; font-weight: bold;">학습메이트</span>
            </div>
            <h1>아이디/비밀번호 찾기</h1>
        </div>
        
        <!-- 찾기 카드 -->
        <div class="find-card">
            <!-- 탭 메뉴 -->
            <div class="tabs">
                <div class="tab-item active" data-tab="find-id">아이디 찾기</div>
                <div class="tab-item" data-tab="find-password">비밀번호 찾기</div>
            </div>
            
            <!-- 아이디 찾기 탭 -->
            <div class="tab-content active" id="find-id-tab">
                <form id="find-id-form" action="<%=request.getContextPath()%>/user/idpwfind.do" method="post">
                    <input type="hidden" name="action" value="findId">
                    
                    <!-- 이름 입력 -->
                    <div class="form-group">
                        <label for="id-name" class="form-label">이름</label>
                        <input type="text" id="id-name" name="name" class="form-input" placeholder="이름을 입력하세요" required>
                    </div>
                    
                    <!-- 생년월일 입력 -->
                    <div class="form-group">
                        <label class="form-label">생년월일</label>
                        <div class="birth-inputs">
                            <input type="text" id="id-birth-year" name="birthYear" class="form-input" placeholder="년(4자리)" maxlength="4" required>
                            <div class="birth-separator">-</div>
                            <input type="text" id="id-birth-month" name="birthMonth" class="form-input" placeholder="월" maxlength="2" required>
                            <div class="birth-separator">-</div>
                            <input type="text" id="id-birth-day" name="birthDay" class="form-input" placeholder="일" maxlength="2" required>
                        </div>
                    </div>
                    
                    <!-- 휴대폰 번호 입력 영역 -->
                    <div class="form-group" id="id-phone-section">
                        <label for="id-phone" class="form-label">휴대폰 번호</label>
                        <input type="tel" id="id-phone" name="phone" class="form-input" placeholder="'-' 없이 숫자만 입력" maxlength="11">
                    </div>
                    
                    <!-- 이메일 입력 영역 -->
                    <div class="form-group" id="id-email-section">
                        <label for="id-email" class="form-label">이메일</label>
                        <input type="email" id="id-email" name="email" class="form-input" placeholder="이메일 주소 입력">
                    </div>
                    
                    <!-- 아이디 찾기 결과 -->
                    <div class="result-section" id="id-result-section">
                        <div class="result-title">아이디 찾기 결과</div>
                        <div class="result-message">
                            회원님의 정보와 일치하는 아이디 정보입니다.
                        </div>
                        <div class="result-info" id="found-id-display">
                            ${foundUserId != null ? foundUserId : 'hong***dong'}
                        </div>
                        <div class="elapsed-timer">
                            가입일: ${joinDate != null ? joinDate : '2022년 05월 10일'}
                        </div>
                        <div class="button-group" style="margin-top: 20px;">
                            <button type="button" class="btn btn-secondary" id="find-another-id-btn">다른 아이디 찾기</button>
                            <button type="button" class="btn btn-primary" id="go-to-find-pw-btn">비밀번호 찾기</button>
                        </div>
                    </div>
                    
                    <button type="button" class="btn btn-primary btn-block" id="find-id-submit-btn" name="findIdSubmit">아이디 찾기</button>
                </form>
            </div>
            
            <!-- 비밀번호 찾기 탭 -->
            <div class="tab-content" id="find-password-tab">
                <form id="find-password-form" action="userIdPwFind" method="post">
                    <input type="hidden" name="action" value="findPassword">
                    
                    <!-- 아이디 입력 -->
                    <div class="form-group">
                        <label for="pw-user-id" class="form-label">아이디</label>
                        <input type="text" id="pw-user-id" name="userId" class="form-input" placeholder="아이디를 입력하세요" required>
                    </div>
                    
                    <!-- 이름 입력 -->
                    <div class="form-group">
                        <label for="pw-name" class="form-label">이름</label>
                        <input type="text" id="pw-name" name="name" class="form-input" placeholder="이름을 입력하세요" required>
                    </div>
                    
                    <!-- 생년월일 입력 -->
                    <div class="form-group">
                        <label class="form-label">생년월일</label>
                        <div class="birth-inputs">
                            <input type="text" id="pw-birth-year" name="birthYear" class="form-input" placeholder="년(4자리)" maxlength="4" required>
                            <div class="birth-separator">-</div>
                            <input type="text" id="pw-birth-month" name="birthMonth" class="form-input" placeholder="월" maxlength="2" required>
                            <div class="birth-separator">-</div>
                            <input type="text" id="pw-birth-day" name="birthDay" class="form-input" placeholder="일" maxlength="2" required>
                        </div>
                    </div>
                    
                    <!-- 이메일 인증 설명 -->
                    <div class="verification-info">
                        <div class="verification-info-title">이메일 인증</div>
                        <div class="verification-info-text">회원정보에 등록된 이메일로 인증번호를 발송합니다.</div>
                    </div>
                    
                    <!-- 이메일 인증 버튼 -->
                    <div class="form-group">
                        <button type="button" class="btn btn-primary btn-block" id="pw-send-email-btn" name="sendEmailCode">인증번호 전송</button>
                    </div>
                    
                    <!-- 인증번호 입력 영역 -->
                    <div class="verification-section" id="pw-email-code-section">
                        <div class="form-group">
                            <label for="pw-email-code" class="form-label">인증번호</label>
                            <div class="input-group">
                                <input type="text" id="pw-email-code" name="emailCode" class="form-input" placeholder="인증번호 6자리 입력" maxlength="6">
                                <button type="button" class="btn btn-primary" id="pw-verify-email-btn" name="verifyEmailCode">확인</button>
                                <div id="pw-email-timer" class="verification-timer">05:00</div>
                            </div>
                            <div id="pw-email-verified" style="display: none; margin-top: 10px;">
                                <span class="verified-badge"><i class="bi bi-check-circle"></i> 인증완료</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 새 비밀번호 설정 -->
                    <div class="new-password-section" id="new-password-section">
                        <div class="form-group">
                            <label for="new-password" class="form-label">새 비밀번호</label>
                            <input type="password" id="new-password" name="newPassword" class="form-input" placeholder="영문, 숫자, 특수문자 조합 8-20자" required>
                            <div style="margin-top: 5px; font-size: 12px; color: #888;">
                                <span id="password-strength" class="password-strength">안전도: 낮음</span>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="new-password-confirm" class="form-label">새 비밀번호 확인</label>
                            <input type="password" id="new-password-confirm" name="confirmPassword" class="form-input" placeholder="비밀번호 재입력" required>
                            <div id="password-match" style="display: none; margin-top: 5px; font-size: 12px; color: var(--bs-primary);">
                                <i class="bi bi-check-circle"></i> 비밀번호가 일치합니다
                            </div>
                            <div id="password-mismatch" style="display: none; margin-top: 5px; font-size: 12px; color: #ff6b6b;">
                                <i class="bi bi-exclamation-circle"></i> 비밀번호가 일치하지 않습니다
                            </div>
                        </div>
                        
                        <button type="button" class="btn btn-primary btn-block" id="change-pw-btn" name="changePassword">비밀번호 변경</button>
                    </div>
                    
                    <!-- 비밀번호 재설정 결과 -->
                    <div class="result-section" id="pw-result-section">
                        <div class="result-title">비밀번호 재설정 완료</div>
                        <div class="result-message">
                            비밀번호가 성공적으로 변경되었습니다.<br>
                            새 비밀번호로 로그인해주세요.
                        </div>
                        <div class="button-group" style="margin-top: 20px;">
                            <button type="button" class="btn btn-primary" id="go-to-login-btn" name="goToLogin">로그인 하기</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- 하단 링크 -->
        <div class="bottom-links">
            <a href="<%=request.getContextPath() %>/user/loginview.do">로그인</a>
            <span>|</span>
            <a href="<%=request.getContextPath() %>/user/enrollview.do">회원가입</a>
            <span>|</span>
            <a href="index.jsp">메인화면</a>
        </div>
    </div>
    
    <!-- jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // 타이머 변수
            let emailTimerInterval;
            
            // 탭 전환 기능
            $('.tab-item').on('click', function() {
                // 탭 활성화
                $('.tab-item').removeClass('active');
                $(this).addClass('active');
                
                // 탭 콘텐츠 표시
                const tabId = $(this).data('tab') + '-tab';
                $('.tab-content').removeClass('active');
                $('#' + tabId).addClass('active');
                
                // 결과 영역 초기화
                $('#id-result-section').hide();
                $('#pw-result-section').hide();
                $('#new-password-section').hide();
                
                // 폼 초기화
                $('#find-id-form')[0].reset();
                $('#find-password-form')[0].reset();
                $('#pw-email-code-section').hide();
                $('#pw-email-verified').hide();
                
                // 타이머 정리
                if (emailTimerInterval) {
                    clearInterval(emailTimerInterval);
                }
            });
            
            // 서버에서 전달된 결과 처리
            <% if(request.getAttribute("foundUserId") != null) { %>
                $('#id-result-section').show();
                $('#find-id-submit-btn').hide();
            <% } %>
            
            <% if(request.getAttribute("passwordChanged") != null) { %>
                $('#pw-result-section').show();
                $('#new-password-section').hide();
            <% } %>
            
            <% if(request.getAttribute("emailVerified") != null) { %>
                $('#new-password-section').show();
                $('#pw-email-verified').show();
                $('#pw-email-code').prop('disabled', true);
                $('#pw-verify-email-btn').prop('disabled', true);
                $('#pw-send-email-btn').prop('disabled', true);
            <% } %>
            
            // 아이디 찾기 폼 제출 (Ajax 처리)
            $('#find-id-submit-btn').on('click', function(e) {
                e.preventDefault();
                
                const name = $('#id-name').val().trim();
                const email = $('#id-email').val().trim();
                
                if (!name || !email) {
                    alert('이름과 이메일을 모두 입력해주세요.');
                    return;
                }
                
                console.log('Name:', name);
                console.log('Email:', email);
                
                $.ajax({
                    url: '<%=request.getContextPath()%>/user/idpwfind.do',
                    type: 'POST',
                    data: {
                        name: name,
                        email: email
                    },
                    dataType: 'json',
                    success: function(data) {
                        if (data.success) {
                            $('#found-id-display').text(data.userId);
                            $('#id-result-section').show();
                            $('#find-id-submit-btn').hide();
                        } else {
                            alert(data.message || '일치하는 회원 정보가 없습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
            
            // 비밀번호 찾기 - 이메일 인증번호 전송
            $('#pw-send-email-btn').on('click', function() {
                const userId = $('#pw-user-id').val().trim();
                const name = $('#pw-name').val().trim();
                const birthYear = $('#pw-birth-year').val().trim();
                const birthMonth = $('#pw-birth-month').val().trim();
                const birthDay = $('#pw-birth-day').val().trim();
                
                // 필수 정보 확인
                if (!userId || !name || !birthYear || !birthMonth || !birthDay) {
                    alert('아이디, 이름, 생년월일을 모두 입력해주세요.');
                    return;
                }
                
                $.ajax({
                    url: '<%= request.getContextPath() %>/user/sendPasswordResetEmail.do',
                    type: 'POST',
                    data: {
                        action: 'sendEmailCode',
                        userId: userId,
                        name: name,
                        birthYear: birthYear,
                        birthMonth: birthMonth,
                        birthDay: birthDay
                    },
                    dataType: 'json',
                    success: function(data) {
                    	console.log(userId);
                        if (data.success) {
                            alert('등록된 이메일로 인증번호가 전송되었습니다.');
                            $('#pw-email-code-section').show();
                            startEmailTimer();
                        } else {
                            alert(data.message || '회원 정보를 확인할 수 없습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
            
            // 이메일 타이머 함수
            function startEmailTimer() {
                let timeLeft = 300; // 5분
                emailTimerInterval = setInterval(function() {
                    if (timeLeft <= 0) {
                        clearInterval(emailTimerInterval);
                        $('#pw-email-timer').text('00:00');
                        alert('인증 시간이 만료되었습니다. 다시 시도해주세요.');
                    } else {
                        const minutes = Math.floor(timeLeft / 60);
                        const seconds = timeLeft % 60;
                        const formattedTime = (minutes < 10 ? '0' + minutes : minutes) + ':' + (seconds < 10 ? '0' + seconds : seconds);
                        $('#pw-email-timer').text(formattedTime);
                        timeLeft--;
                    }
                }, 1000);
            }
            
            // 인증번호 확인 버튼
            $('#pw-verify-email-btn').on('click', function() {
                const verificationCode = $('#pw-email-code').val().trim();
                
                if (!verificationCode) {
                    alert('인증번호를 입력해주세요.');
                    return;
                }
                
                $.ajax({
                    url: '<%=request.getContextPath()%>/user/idpwfind.do',
                    type: 'POST',
                    data: {
                        action: 'verifyEmailCode',
                        emailCode: verificationCode
                    },
                    dataType: 'json',
                    success: function(data) {
                        if (data.success) {
                            $('#pw-email-verified').show();
                            $('#new-password-section').show();
                            
                            // 인증 영역 비활성화
                            $('#pw-email-code').prop('disabled', true);
                            $('#pw-verify-email-btn').prop('disabled', true);
                            $('#pw-send-email-btn').prop('disabled', true);
                            
                            // 타이머 정리
                            if (emailTimerInterval) {
                                clearInterval(emailTimerInterval);
                            }
                            
                            alert('인증이 완료되었습니다. 새 비밀번호를 설정해주세요.');
                        } else {
                            alert(data.message || '인증번호가 일치하지 않습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
            
            // 비밀번호 강도 체크
            $('#new-password').on('input', function() {
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
                if ($('#new-password-confirm').val().length > 0) {
                    checkPasswordMatch();
                }
            });
            
            // 비밀번호 일치 여부 확인
            $('#new-password-confirm').on('input', checkPasswordMatch);
            
            function checkPasswordMatch() {
                const password = $('#new-password').val();
                const confirmPassword = $('#new-password-confirm').val();
                
                if (password === confirmPassword && confirmPassword.length > 0) {
                    $('#password-match').show();
                    $('#password-mismatch').hide();
                } else if (confirmPassword.length > 0) {
                    $('#password-match').hide();
                    $('#password-mismatch').show();
                } else {
                    $('#password-match').hide();
                    $('#password-mismatch').hide();
                }
            }
            
            // 비밀번호 변경 버튼
            $('#change-pw-btn').on('click', function() {
                const pw = $('#new-password').val();
                const confirmPw = $('#new-password-confirm').val();
                
                if (!pw) {
                    alert('새 비밀번호를 입력해주세요.');
                    return;
                }
                
                if (pw.length < 8) {
                    alert('비밀번호는 8자 이상이어야 합니다.');
                    return;
                }
                
                if (pw !== confirmPw) {
                    alert('비밀번호가 일치하지 않습니다.');
                    return;
                }
                
                $.ajax({
                    url: 'userIdPwFind',
                    type: 'POST',
                    data: {
                        action: 'changePassword',
                        newPassword: pw,
                        confirmPassword: confirmPw
                    },
                    dataType: 'json',
                    success: function(data) {
                        if (data.success) {
                            $('#pw-result-section').show();
                            $('#new-password-section').hide();
                            alert('비밀번호가 성공적으로 변경되었습니다.');
                        } else {
                            alert(data.message || '비밀번호 변경에 실패했습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error);
                        alert('오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
            
            // 다른 아이디 찾기 버튼
            $('#find-another-id-btn').on('click', function() {
                $('#id-result-section').hide();
                $('#find-id-form')[0].reset();
                $('#find-id-submit-btn').show();
            });
            
            // 비밀번호 찾기로 이동 버튼
            $('#go-to-find-pw-btn').on('click', function() {
                // 비밀번호 찾기 탭으로 전환
                $('.tab-item').removeClass('active');
                $('.tab-item[data-tab="find-password"]').addClass('active');
                
                $('.tab-content').removeClass('active');
                $('#find-password-tab').addClass('active');
                
                // 아이디 정보 자동 입력
                $('#pw-user-id').val($('#found-id-display').text());
            });
            
            // 로그인 페이지로 이동 버튼
            $('#go-to-login-btn').on('click', function() {
                window.location.href = '<%=request.getContextPath()%>/user/loginview.do';
            });
            
            // 생년월일 입력값 제한 (숫자만)
            $('#id-birth-year, #pw-birth-year').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            });
            
            $('#id-birth-month, #pw-birth-month').on('input', function() {
                let value = $(this).val().replace(/[^0-9]/g, '');
                if (parseInt(value) > 12) value = '12';
                $(this).val(value);
            });
            
            $('#id-birth-day, #pw-birth-day').on('input', function() {
                let value = $(this).val().replace(/[^0-9]/g, '');
                if (parseInt(value) > 31) value = '31';
                $(this).val(value);
            });
            
            // 휴대폰 번호 입력값 제한 (숫자만)
            $('#id-phone').on('input', function() {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            });
        });
    </script>
</body>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>