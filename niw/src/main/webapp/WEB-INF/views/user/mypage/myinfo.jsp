<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User" %>
<%
    User loginUser = (User)session.getAttribute("loginUser");
%>

<style>
    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }
    
    .content-title {
        font-size: 24px;
        font-weight: bold;
        color: #333;
    }
    
    .content-section {
        margin-bottom: 30px;
    }
    
    .section-title {
        font-size: 18px;
        font-weight: bold;
        margin-bottom: 15px;
        color: #444;
    }
    
    .info-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
        table-layout: fixed; /* 테이블 레이아웃 고정 */
    }
    
    .info-table th,
    .info-table td {
        padding: 20px; /* 15px → 20px로 증가 */
        text-align: left;
        border-bottom: 1px solid #eee;
        vertical-align: middle; /* 수직 가운데 정렬 */
    }
    
    .info-table th {
        width: 200px; /* 180px → 200px로 증가 */
        background-color: var(--bs-primary-light);
        font-weight: 600; /* normal → 600으로 증가 */
        color: #444;
        font-size: 15px; /* 폰트 크기 명시적 지정 */
    }
    
    .info-table td {
        width: calc(100% - 200px); /* 나머지 영역 모두 사용 */
    }
    
    .info-table tr:last-child th,
    .info-table tr:last-child td {
        border-bottom: none;
    }
    
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
        padding: 15px 18px; /* 12px 15px → 15px 18px로 증가 */
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.2s;
        min-height: 50px; /* 최소 높이 지정 */
        box-sizing: border-box;
    }
    
    .form-input:focus {
        border-color: var(--bs-blind-dark);
        box-shadow: 0 0 0 3px rgba(36, 177, 181, 0.2);
        outline: none;
    }
    
    .form-input::placeholder {
        color: #ccc;
    }
    
    .form-input:disabled {
        background-color: #f5f6f7;
        cursor: not-allowed;
    }
</style>

<div class="content-header">
    <h2 class="content-title">회원정보 조회/수정</h2>
</div>

<div class="content-section">
    <h3 class="section-title">기본 정보</h3>
    <form id="edit-user-info" method="post" action="<%=request.getContextPath()%>/user/update.do">
        <table class="info-table">
            <tr>
                <th>회원 ID</th>
                <td>
                    <input type="text" class="form-input" value="<%=loginUser.userId()%>" disabled>
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" class="form-input" value="<%=loginUser.userName()%>" name="userName" disabled>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" class="form-input" value="<%=loginUser.userEmail()%>" name="email" disabled>
                </td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    <input type="tel" class="form-input" value="<%=loginUser.userPhone() != null ? loginUser.userPhone() : ""%>" name="phone" placeholder="010-1234-5678">
                </td>
            </tr>
            <tr>
                <th>회원 구분(권한)</th>
                <td><%=loginUser.userRole()%></td>
            </tr>
            <tr>
                <th>주소</th>
                <td>
                    <input type="text" class="form-input" value="<%=loginUser != null ? loginUser.userAddress() : ""%>" name="address" placeholder="주소를 입력하세요">
                </td>
            </tr>
        </table>
        
        <div style="text-align: right; margin-top: 20px;">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-check-circle me-1"></i>정보 저장하기
            </button>
        </div>
    </form>
</div>

<div class="content-section">
    <h3 class="section-title">비밀번호 변경</h3>
    <form id="change-password" method="post" action="<%=request.getContextPath()%>/user/changePassword.do">
        <div class="form-group">
            <label class="form-label">현재 비밀번호</label>
            <input type="password" class="form-input" name="currentPwd" placeholder="현재 비밀번호" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">새 비밀번호</label>
            <input type="password" class="form-input" name="newPwd" placeholder="새 비밀번호" required>
        </div>
        
        <div class="form-group">
            <label class="form-label">새 비밀번호 확인</label>
            <input type="password" class="form-input" name="newPwdCheck" placeholder="새 비밀번호 확인" required>
        </div>
        
        <div style="text-align: right;">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-lock me-1"></i>비밀번호 변경하기
            </button>
        </div>
    </form>
</div>

<script>

</script>