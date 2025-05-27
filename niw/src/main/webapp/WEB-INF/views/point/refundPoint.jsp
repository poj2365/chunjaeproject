<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
if (loginUser == null) {
	response.sendRedirect(request.getContextPath() + "/user/loginview.do");
	return;
}
%>

<style>
    .mypage-container {
        max-width: 1400px;
        margin: 30px auto;
        display: flex;
        gap: 30px;
        padding: 0 20px;
    }

    .sidebar {
        width: 260px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 20px 0;
        flex-shrink: 0;
    }

    .profile-section {
        padding: 0 20px 20px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }

    .profile-pic {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: #f0f0f0;
        margin: 0 auto 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 3px solid var(--bs-primary-light);
    }

    .user-id {
        font-weight: bold;
        margin-bottom: 5px;
        font-size: 18px;
        color: #333;
    }

    .user-name, .point-info {
        color: #666;
        margin-bottom: 10px;
    }

    .menu-section {
        padding: 20px 0;
    }

    .menu-title {
        padding: 0 20px;
        margin-bottom: 10px;
        font-size: 14px;
        color: #888;
        font-weight: bold;
    }

    .menu-item {
        padding: 12px 20px;
        transition: 0.2s;
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .menu-item:hover,
    .menu-item.active {
        background-color: var(--bs-primary-light);
        color: var(--bs-blind-dark);
    }

    .menu-item.active {
        border-left: 3px solid var(--bs-blind-dark);
        font-weight: bold;
    }

    .main-content {
        flex: 1;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 30px;
        min-height: 450px;
    }

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
        table-layout: fixed;
    }

    .info-table th,
    .info-table td {
        padding: 20px;
        text-align: left;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }

    .info-table th {
        width: 200px;
        background-color: var(--bs-primary-light);
        font-weight: 600;
        color: #444;
    }

    .form-input {
        width: 100%;
        padding: 15px 18px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 16px;
        transition: 0.2s;
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

    @media (max-width: 768px) {
        .mypage-container {
            flex-direction: column;
        }
        .sidebar {
            width: 100%;
        }
    }
</style>

<!-- 메인 컨테이너 -->
<div class="mypage-container">
    <!-- 사이드바 영역 -->
    <div class="sidebar">
        <div class="profile-section">
            <div class="profile-pic">
                <i class="bi bi-person-circle" style="font-size: 60px; color: #ccc;"></i>
            </div>
            <div class="user-id"><%=loginUser.userId()%></div>
            <div class="user-name"><%=loginUser.userName()%></div>
            <div class="point-info">포인트: <%=loginUser.userPoint()%>P</div>
        </div>
        <div class="menu-section">
            <div class="menu-title">내 계정</div>
            <ul>
                <li class="menu-item active" data-tab="info">
                    <i class="bi bi-person"></i>회원정보 조회/수정
                </li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">내 활동</div>
            <ul>
                <li class="menu-item" data-tab="activity">
                    <i class="bi bi-clock-history"></i>활동 내역
                </li>
                <li class="menu-item" data-tab="point">
                    <i class="bi bi-coin"></i>포인트 내역
                </li>
                <li class="menu-item" data-tab="materials">
                    <i class="bi bi-file-earmark-text"></i>구매한 학습자료
                </li>
            </ul>
        </div>
        <div class="menu-section">
            <div class="menu-title">판매 관리</div>
            <ul>
                <li class="menu-item" data-tab="sales">
                    <i class="bi bi-shop"></i>학습자료 판매 관리
                </li>
            </ul>
        </div>
    </div>
    
    <!-- 메인 컨텐츠 영역 -->
    <div class="main-content">
<div class="content-header">
    <h2 class="content-title">환불 신청</h2>
</div>

<div class="content-section">
    <h3 class="section-title">기본 정보</h3>
    <form id="edit-user-info">
        <table class="info-table">
            <tr>
                <th>회원 ID</th>
                <td>
                    <input type="text" class="form-input" value="<%=loginUser.userId()%>" disabled>
                </td>
            </tr>
            <tr id="row-refund-id" style="display: ;" >
                <th>환불 요청일</th>
                <td>
                    <input type="date" name="refundDate" id="refundDateInput" class="form-input" disabled>
                </td>
            </tr>
            <tr>
                <th>환불 유형</th>
                <td>
                    <input type="radio"  name="refundType" value="file" ><label>자료</label>
                    <input type="radio"  name="refundType" value="point" ><label>포인트(P)</label>
                </td>
            </tr>
            
            <tr id="row-document-id" style="display:;">
				  <th>학습 자료 ID</th>
				  <td>
				    <select name="fileId" class="form-input">
				      <option value="1">파일 A</option>
				      <option value="2">파일 B</option>
				      <option value="3">파일 C</option>
				    </select>
				  </td>
				</tr>
            <tr id="row-dpoint-id" style="display:none;">
                <th>자료 환불 포인트 금액</th>
                <td>
                    <input type="number" name = "refundPoint" class="form-input" value="" placeholder="1000">
                </td>
            </tr>
               <tr id="row-point-id" style="display:none;">
                <th>환불 포인트 금액</th>
                <td>
                    <input type="number"  name = "refundPoint" class="form-input" min=1000 placeholder="1000">
                </td>
            </tr>
            <tr id="row-bankAccount-id" style="display:none ;">
                <th>환불 계좌</th>
                <td>
                    <select name="bank" class="form-input" style="width: 20%;">
				      <option value="국민">국민</option>
				      <option value="기업">기업</option>
				      <option value="농협">농협</option>
				      <option value="신한">신한</option>
				      <option value="토스뱅크">토스뱅크</option>
				    </select> 
				    <input type="number" id="accountNumber" name="accountNumber" class="form-input" style="width: 78%;" placeholder="계좌번호 입력">
				</td>      
            </tr>   
        </table>
        
        
        <div style="text-align: right; margin-top: 20px;">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-check-circle me-1"></i>환불 신청하기
            </button>
        </div>
    </form>
</div>

</div>
</div>

<script>
	
	document.addEventListener('DOMContentLoaded', function () {
	  const refundTypeRadios = document.querySelectorAll('input[name="refundType"]');
	
	  const documentRow = document.getElementById('row-document-id');
	  const dPointRow = document.getElementById('row-dpoint-id');
	  const pointRow = document.getElementById('row-point-id');
	  const bankAccount = document.getElementById('row-bankAccount-id');
	
	  documentRow.style.display = 'none';
	  dPointRow.style.display = 'none';
	  pointRow.style.display = 'none';
	  bankAccount.style.display ='none';
	
	  refundTypeRadios.forEach(radio => {
	    radio.addEventListener('change', () => {
	      if (radio.value === 'file') {
	        documentRow.style.display = '';
	        dPointRow.style.display = '';
	        pointRow.style.display = 'none';
	        bankAccount.style.display='none';
	      } else if (radio.value === 'point') {
	        documentRow.style.display = 'none';
	        dPointRow.style.display = 'none';
	        pointRow.style.display = '';
	        bankAccount.style.display='';
	      }
	    });
	  });
	  
	  
	
	  // 환불 요청일 자동 설정
	  const dateInput = document.getElementById('refundDateInput');
	  if (dateInput) {
	    const today = new Date().toISOString().split('T')[0];
	    dateInput.value = today;
	  }
	});
</script>
