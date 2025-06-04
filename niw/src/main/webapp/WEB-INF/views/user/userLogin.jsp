<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
// 메시지 처리
String errorMessage = (String) request.getAttribute("errorMessage");
String successMessage = (String) request.getAttribute("successMessage");
String infoMessage = (String) request.getAttribute("infoMessage");
String username = request.getParameter("username");
String redirect = request.getParameter("redirect");

// 세션에서 사용자 정보 확인
Object user = session.getAttribute("user");

// 이미 로그인된 사용자 리다이렉트 처리
if (loginUser != null) {
	if (redirect != null && !redirect.isEmpty()) {
		response.sendRedirect(redirect);
	} else {
		response.sendRedirect(request.getContextPath() + "/");
	}
	return;
}
%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 - 학습메이트</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/login.css">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>


	<main class="bg-primary-light py-5">
		<div class="container login-animation">
			<div class="login-container">
				<div class="card login-card shadow-custom">
					<div
						class="login-header gradient-header text-center text-white position-relative"
						style="background: linear-gradient(135deg, var(--bs-blind-dark) 0%, var(--bs-blind-gray) 100%);">
						<div class="position-relative">
							<h2 class="fw-bold mb-2 fs-1">로그인</h2>
							<p class="mb-0 fs-6">학습메이트에 오신 것을 환영합니다! 😄</p>
						</div>
					</div>
					<div class="login-body">
						<!-- 메시지 표시 영역 -->
						<%
						if (errorMessage != null && !errorMessage.isEmpty()) {
						%>
						<div class="alert alert-danger alert-dismissible fade show mb-3"
							role="alert">
							<i class="bi bi-exclamation-triangle-fill me-2"></i>
							<%=errorMessage%>
							<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
						</div>
						<%
						}
						%>

						<%
						if (successMessage != null && !successMessage.isEmpty()) {
						%>
						<div class="alert alert-success alert-dismissible fade show mb-3"
							role="alert">
							<i class="bi bi-check-circle-fill me-2"></i>
							<%=successMessage%>
							<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
						</div>
						<%
						}
						%>

						<%
						if (infoMessage != null && !infoMessage.isEmpty()) {
						%>
						<div class="alert alert-info alert-dismissible fade show mb-3"
							role="alert">
							<i class="bi bi-info-circle-fill me-2"></i>
							<%=infoMessage%>
							<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
						</div>
						<%
						}
						%>

						<!-- 로그인 폼 -->
						<form id="loginForm"
							action="<%=request.getContextPath()%>/user/login.do"
							method="post">
							<!-- 리다이렉트 URL 유지 -->
							<%
							if (redirect != null && !redirect.isEmpty()) {
							%>
							<input type="hidden" name="redirect" value="<%=redirect%>" />
							<%
							}
							%>

							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="username"
									name="username" placeholder="아이디"
									value="<%=saveId != null ? saveId : ""%>" required
									autocomplete="username"> <label for="username">
									<i class="bi bi-person me-1"></i>아이디
								</label>
								<div class="invalid-feedback" id="username-error"
									style="display: none;"></div>
							</div>

							<div class="form-floating mb-3">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="비밀번호" required
									autocomplete="current-password"> <label for="password">
									<i class="bi bi-lock me-1"></i>비밀번호
								</label>
								<div class="invalid-feedback" id="password-error"
									style="display: none;"></div>
							</div>

							<div
								class="d-flex justify-content-between align-items-center mb-4">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="rememberMe"
										name="rememberMe" <%=saveId!=null ?"checked":"" %>> <label class="form-check-label"
										for="rememberMe"> 아이디 저장 </label>
								</div>
								<div class="login-options">
									<a href="<%=request.getContextPath()%>/useridpwfindview.do">아이디/비밀번호
										찾기</a>
								</div>
							</div>

							<div class="d-grid mb-4">
								<button class="btn btn-primary py-3 fw-bold fs-5" type="submit"
									id="loginBtn">
									<span class="login-btn-text"> <i
										class="bi bi-box-arrow-in-right me-2"></i>로그인
									</span> <span class="login-btn-loading d-none">
										<div class="spinner-border spinner-border-sm me-2"
											role="status">
											<span class="visually-hidden">Loading...</span>
										</div> 로그인 중...
									</span>
								</button>
							</div>

							<div class="login-divider">
								<span>또는</span>
							</div>

<!-- 							<div class="row g-2 mb-4">
								<div class="col-6">
									<button type="button"
										class="btn w-100 btn-google d-flex align-items-center justify-content-center"
										onclick="socialLogin('google')">
										<img
											src="https://img.icons8.com/?size=100&id=V5cGWnc9R4xj&format=png&color=000000"
											alt="구글" style="height: 20px;" class="me-2"> 구글 로그인
									</button>
								</div>
								<div class="col-6">
									<button type="button"
										class="btn w-100 btn-naver d-flex align-items-center justify-content-center"
										onclick="socialLogin('naver')">
										<img
											src="https://mblogthumb-phinf.pstatic.net/MjAyMjEyMTVfMTE0/MDAxNjcxMDkwNjU3NTkw.KoGra3iQfkuqnbSFoQ7PA3YMqnExItsdfOLk960Rxnkg.umx5uLYTj2TEMhx7rMA5uNxvyJD2T42OSeSFsxNUQygg.PNG.y2kwooga/%EB%84%A4%EC%9D%B4%EB%B2%84_AI-04.png?type=w800"
											alt="네이버" style="height: 25px;" class="me-2"> 네이버 로그인
									</button>
								</div>
							</div> -->

							<div class="text-center login-options">
								<p class="mb-0">
									아직 회원이 아니신가요? <a
										href="<%=request.getContextPath()%>/auth/register<%if (redirect != null && !redirect.isEmpty()) {%>?redirect=<%=redirect%><%}%>"
										class="fw-bold text-primary">회원가입</a>
								</p>
								<span></span>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- JavaScript -->
	<script>
 // 로그인 폼 검증 및 제출
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        // 이미 제출 중이면 중복 제출 방지
        if (this.dataset.submitting === 'true') {
            e.preventDefault();
            return false;
        }
        
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();
        
        // 기존 에러 메시지 제거
        clearAllErrors();
        
        let hasError = false;
        
        // 클라이언트 사이드 검증
        if (!username) {
            showFieldError('username', '아이디를 입력해주세요.');
            hasError = true;
        } else if (username.length < 3) {
            showFieldError('username', '아이디는 3자 이상 입력해주세요.');
            hasError = true;
        }
        
        if (!password) {
            showFieldError('password', '비밀번호를 입력해주세요.');
            hasError = true;
        } else if (password.length < 4) {
            showFieldError('password', '비밀번호는 4자 이상 입력해주세요.');
            hasError = true;
        }
        
        if (hasError) {
            e.preventDefault();
            return false;
        }
        
        // 제출 플래그 설정 및 로딩 상태 표시
	setTimeout(() => {
  		 this.dataset.submitting = 'true';
   		 showLoginLoading(true);
		}, 500);
        
        // 타임아웃 설정 (30초)
        const timeoutId = setTimeout(() => {
            showLoginLoading(false);
            this.dataset.submitting = 'false';
            showGlobalError('로그인 요청 시간이 초과되었습니다. 다시 시도해주세요.');
        }, 30000);
        
        // 폼 제출 전 타임아웃 ID 저장
        this.dataset.timeoutId = timeoutId;
    });

    // 필드 에러 표시
    function showFieldError(fieldName, message) {
        const field = document.getElementById(fieldName);
        const errorDiv = document.getElementById(fieldName + '-error');
        
        // 필드에 에러 클래스 추가
        field.classList.add('is-invalid');
        
        // 에러 메시지 표시
        errorDiv.textContent = message;
        errorDiv.style.display = 'block';
        
        // 포커스 이동
        field.focus();
    }

    // 필드 에러 제거
    function clearFieldError(fieldName) {
        const field = document.getElementById(fieldName);
        const errorDiv = document.getElementById(fieldName + '-error');
        
        field.classList.remove('is-invalid');
        errorDiv.style.display = 'none';
        errorDiv.textContent = '';
    }

    // 모든 에러 제거
    function clearAllErrors() {
        clearFieldError('username');
        clearFieldError('password');
        // 전역 에러 메시지도 제거
        const globalError = document.getElementById('global-error');
        if (globalError) {
            globalError.remove();
        }
    }

    // 전역 에러 메시지 표시
    function showGlobalError(message) {
        // 기존 전역 에러 제거
        const existingError = document.getElementById('global-error');
        if (existingError) {
            existingError.remove();
        }
        
        // 새 에러 메시지 생성
        const errorDiv = document.createElement('div');
        errorDiv.id = 'global-error';
        errorDiv.className = 'alert alert-danger alert-dismissible fade show mb-3';
        errorDiv.innerHTML = `
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        // 폼 상단에 삽입
        const form = document.getElementById('loginForm');
        form.insertBefore(errorDiv, form.firstChild);
    }

    // 입력 시 에러 제거
    document.getElementById('username').addEventListener('input', function() {
        clearFieldError('username');
    });

    document.getElementById('password').addEventListener('input', function() {
        clearFieldError('password');
    });

    // 로딩 상태 표시/숨김
    function showLoginLoading(show) {
        const btn = document.getElementById('loginBtn');
        const textSpan = btn.querySelector('.login-btn-text');
        const loadingSpan = btn.querySelector('.login-btn-loading');
        
        if (show) {
            btn.disabled = true;
            textSpan.classList.add('d-none');
            loadingSpan.classList.remove('d-none');
        } else {
            btn.disabled = false;
            textSpan.classList.remove('d-none');
            loadingSpan.classList.add('d-none');
        }
    }

    // 소셜 로그인
    function socialLogin(provider) {
        const redirect = new URLSearchParams(window.location.search).get('redirect') || '';
        const url = '<%=request.getContextPath()%>/auth/social/' + provider + 
                   (redirect ? '?redirect=' + encodeURIComponent(redirect) : '');
        window.location.href = url;
    }

    // 페이지 로드 완료 시 상태 초기화
    window.addEventListener('load', function() {
        const form = document.getElementById('loginForm');
        if (form) {
            form.dataset.submitting = 'false';
            showLoginLoading(false);
            
            // 기존 타임아웃 제거
            if (form.dataset.timeoutId) {
                clearTimeout(parseInt(form.dataset.timeoutId));
                delete form.dataset.timeoutId;
            }
        }
    });

    // 페이지를 떠날 때 타임아웃 정리
    window.addEventListener('beforeunload', function() {
        const form = document.getElementById('loginForm');
        if (form && form.dataset.timeoutId) {
            clearTimeout(parseInt(form.dataset.timeoutId));
        }
    });

    // Enter 키 처리
    document.addEventListener('keypress', function(e) {
        if (e.key === 'Enter' && e.target.matches('#username, #password')) {
            // 이미 제출 중이면 무시
            const form = document.getElementById('loginForm');
            if (form.dataset.submitting === 'true') {
                e.preventDefault();
                return;
            }
            
            if (e.target.id === 'username') {
                document.getElementById('password').focus();
            } else {
                // 폼 제출 이벤트 발생
                const submitEvent = new Event('submit', { cancelable: true });
                form.dispatchEvent(submitEvent);
            }
        }
    });

    // 자동 포커스 (에러가 없는 경우에만)
    window.addEventListener('DOMContentLoaded', function() {
        const hasErrors = document.querySelector('.alert-danger');
        if (!hasErrors) {
            const usernameField = document.getElementById('username');
            if (!usernameField.value.trim()) {
                usernameField.focus();
            } else {
                document.getElementById('password').focus();
            }
        }
    });

    // 알림 자동 숨김 (5초 후)
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            setTimeout(function() {
                if (alert.classList.contains('show')) {
                    alert.classList.remove('show');
                    setTimeout(function() {
                        alert.remove();
                    }, 150);
                }
            }, 5000);
        });
        
        // 폼 상태 초기화
        const form = document.getElementById('loginForm');
        if (form) {
            form.dataset.submitting = 'false';
        }
    });

    // 페이지 가시성 변경 시 상태 체크
    document.addEventListener('visibilitychange', function() {
        if (!document.hidden) {
            // 페이지가 다시 보일 때 상태 초기화
            const form = document.getElementById('loginForm');
            if (form && form.dataset.submitting === 'true') {
                // 너무 오래 제출 상태였다면 초기화
                setTimeout(() => {
                    if (form.dataset.submitting === 'true') {
                        form.dataset.submitting = 'false';
                        showLoginLoading(false);
                        showGlobalError('로그인 처리 중 문제가 발생했습니다. 다시 시도해주세요.');
                    }
                }, 1000);
            }
        }
    });
    </script>
</body>
</html>