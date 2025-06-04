<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.user.model.dto.User"%>

<%
User loginUser= (User)session.getAttribute("loginUser");
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
    
    .section-title .badge {
        background-color: var(--bs-blind-dark);
        color: white;
        font-size: 14px;
        padding: 2px 10px;
        border-radius: 20px;
        margin-left: 10px;
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
        border-color: var(--bs-blind-dark);
        box-shadow: 0 0 0 3px rgba(36, 177, 181, 0.2);
        outline: none;
    }
    
    .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #444;
    }
    
    .tabs {
        display: flex;
        border-bottom: 1px solid #eee;
        margin-bottom: 20px;
        overflow-x: auto;
    }
    
    .tab-item {
        padding: 15px 20px;
        cursor: pointer;
        transition: all 0.2s;
        white-space: nowrap;
    }
    
    .tab-item:hover {
        color: var(--bs-blind-dark);
    }
    
    .tab-item.active {
        font-weight: bold;
        color: var(--bs-blind-dark);
        border-bottom: 2px solid var(--bs-blind-dark);
    }
    
    .point-history {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
    }
    
    .point-history th,
    .point-history td {
        padding: 15px;
        text-align: center;
        border-bottom: 1px solid #eee;
    }
    
    .point-history th {
        background-color: var(--bs-primary-light);
        font-weight: bold;
        color: #444;
    }
    
    .point-plus {
        color: var(--bs-blind-dark);
        font-weight: bold;
    }
    
    .point-minus {
        color: #ff6b6b;
        font-weight: bold;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    
    .page-item {
        margin: 0 5px;
    }
    
    .page-link {
        display: block;
        padding: 8px 12px;
        border-radius: 6px;
        transition: all 0.2s;
        text-decoration: none;
        color: #333;
    }
    
    .page-link:hover {
        background-color: #f5f6f7;
    }
    
    .page-item.active .page-link {
        background-color: var(--bs-blind-dark);
        color: white;
    }
    
    .info-table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 0 1px #eee;
    }
    
    .info-table th,
    .info-table td {
        padding: 15px;
        text-align: left;
        border-bottom: 1px solid #eee;
    }
    
    .info-table th {
        width: 180px;
        background-color: var(--bs-primary-light);
        font-weight: normal;
        color: #444;
    }
    
    .point-large {
        font-size: 24px;
        font-weight: bold;
        color: var(--bs-blind-dark);
    }
    td {
	  color: #222 !important;
	  background: #fff !important;
	  font-size: 18px !important;
	}
	.refund-table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eee;
    background: #fff;
    font-size: 16px;
    margin-bottom: 25px;
}
.refund-table th, .refund-table td {
    padding: 15px 10px;
    text-align: center;
    border-bottom: 1px solid #f0f0f0;
    vertical-align: middle;
}
.refund-table th {
    background: var(--bs-primary-light);
    color: #333;
    font-weight: bold;
    letter-spacing: 0.5px;
}
.refund-table td.point-minus {
    color: #ff6b6b;
    font-weight: bold;
}
.refund-table tr:last-child td {
    border-bottom: none;
}

/* 상태 뱃지 */
.badge {
    display: inline-block;
    padding: 5px 16px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: bold;
}
.status-pending {
    background: #fff8c0;
    color: #b19613;
    border: 1px solid #f4e192;
}
.status-done {
    background: #daf7e6;
    color: #27ae60;
    border: 1px solid #a7e9c6;
}
.status-reject {
    background: #ffe0e6;
    color: #d83a5e;
    border: 1px solid #ffb1c7;
}

/* 버튼 스타일 */
.btn-sm {
    padding: 6px 12px;
    font-size: 14px;
    border-radius: 8px;
    margin-bottom: 2px;
}
.btn-success {
    background: #27ae60;
    color: #fff;
    border: none;
    transition: background 0.15s;
}
.btn-success:hover { background: #219150; }
.btn-danger {
    background: #e74c3c;
    color: #fff;
    border: none;
    transition: background 0.15s;
}
.btn-danger:hover { background: #c44132; }
.btn-outline-secondary {
    background: #f5f6f7;
    color: #aaa;
    border: 1px solid #eee;
}
.btn-outline-secondary:disabled {
    opacity: 0.7;
    cursor: not-allowed;
}
.me-1 { margin-right: 6px; }

/* 반응형 */
@media (max-width: 768px) {
    .refund-table, .refund-table th, .refund-table td {
        font-size: 14px;
        padding: 8px 4px;
    }
    .refund-table th, .refund-table td {
        white-space: nowrap;
    }
}
</style>

 <h2 class="content-title">환불 요청 기록</h2>

<!-- 환불 요청 관리 테이블 (관리자용) -->
<div class="content-section">
    <h3 class="section-title">환불 요청 관리</h3>
    <table class="refund-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>회원ID</th>
                <th>이름</th>
                <th>요청일</th>
                <th>환불 포인트</th>
                <th>은행</th>
                <th>계좌번호</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody id="refundPointList">
           
        </tbody>
    </table>
</div>

<style>
/* 환불 요청 테이블 전용 스타일 */

</style>

<script>
	$(document).ready(function() {
	    $.get('<%=request.getContextPath()%>/admin/adminpage/refundlist.do', function(data) {
			console.log(data);
	        // data가 배열 형태로 올 때
	        renderRefundList(data);
	    });
	});
	
	function renderRefundList(list) {
	    const tbody = document.getElementById('refundPointList');
	    tbody.innerHTML = ''; // tbody 비우기

	    if (!list || list.length === 0) {
	        const tr = document.createElement('tr');
	        const td = document.createElement('td');
	        td.colSpan = 9;
	        td.style.textAlign = 'center';
	        td.style.padding = '40px';
	        td.textContent = '데이터가 없습니다.';
	        tr.appendChild(td);
	        tbody.appendChild(tr);
	        return;
	    }

	    list.forEach((row, idx) => {
	        const tr = document.createElement('tr');

	        // 1. 번호
	        const tdNum = document.createElement('td');
	        tdNum.textContent = idx + 1;
	        tr.appendChild(tdNum);

	        // 2. 유저ID
	        const tdUserId = document.createElement('td');
	        tdUserId.textContent = row.userId;
	        tr.appendChild(tdUserId);

	        // 3. 이름
	        const tdUserName = document.createElement('td');
	        tdUserName.textContent = row.userName;
	        tr.appendChild(tdUserName);

	        // 4. 환불날짜
	        const tdDate = document.createElement('td');
	        tdDate.textContent = row.refundDate;
	        tr.appendChild(tdDate);

	        // 5. 포인트 (콤마 + P)
	        const tdPoint = document.createElement('td');
	        tdPoint.className = 'point-minus';
	        tdPoint.style.textAlign = 'right';
	        tdPoint.textContent =  Number((row.pointAmount)*-1).toLocaleString() + 'P';
	        tr.appendChild(tdPoint);

	        // 6. 은행명
	        const tdBank = document.createElement('td');
	        tdBank.textContent = row.bank;
	        tr.appendChild(tdBank);

	        // 7. 계좌번호
	        const tdAccount = document.createElement('td');
	        tdAccount.textContent = row.banckAccount;
	        tr.appendChild(tdAccount);

	        // 8. 상태 뱃지
	        const tdStatus = document.createElement('td');
	        const span = document.createElement('span');
	        if (row.status === 'WAIT') {
	            span.className = 'badge status-pending';
	            span.textContent = '대기';
	        } else if (row.status === 'APPROVED') {
	            span.className = 'badge status-done';
	            span.textContent = '승인';
	        } else {
	            span.className = 'badge status-reject';
	            span.textContent = '거절';
	        }
	        tdStatus.appendChild(span);
	        tr.appendChild(tdStatus);

	        // 9. 버튼
	        const tdBtn = document.createElement('td');
	        if (row.status === 'WAIT') {
	            const acceptBtn = document.createElement('button');
	            acceptBtn.className = 'btn btn-success btn-sm me-1';
	            acceptBtn.textContent = '수락';
	            acceptBtn.dataset.id = row.refundId;
	            acceptBtn.dataset.userid = row.userId;         
	            acceptBtn.dataset.amount = row.pointAmount;
	            

	            const rejectBtn = document.createElement('button');
	            rejectBtn.className = 'btn btn-danger btn-sm';
	            rejectBtn.textContent = '거절';
	            rejectBtn.dataset.id = row.refundId;
	            acceptBtn.dataset.userid = row.userId;         
	            acceptBtn.dataset.amount = row.pointAmount;

	            tdBtn.appendChild(acceptBtn);
	            tdBtn.appendChild(rejectBtn);
	        } else {
	            const doneBtn = document.createElement('button');
	            doneBtn.className = 'btn btn-outline-secondary btn-sm';
	            doneBtn.textContent = '처리완료';
	            doneBtn.disabled = true;
	            tdBtn.appendChild(doneBtn);
	        }
	        tr.appendChild(tdBtn);

	    
	        tbody.appendChild(tr);
	    });
	}
	
	document.getElementById('refundPointList').addEventListener('click', function(e) {
	    if (e.target.classList.contains('btn-success')) {
	        // 수락 버튼
	        const refundId = e.target.dataset.id;
	        const userId = e.target.dataset.userid;
	        const pointAmount = e.target.dataset.amount;
	        console.log(refundId);
	        console.log(userId);
	        console.log(pointAmount);
	        
	        if (confirm('해당 환불을 승인하시겠습니까?')) {
	            approveRefund(refundId,userId,pointAmount);
	        }
	    }
	    if (e.target.classList.contains('btn-danger')) {
	        // 거절 버튼
	        const refundId = e.target.dataset.id;
	        const userId = e.target.dataset.userid;
	        const pointAmount = e.target.dataset.amount;
	        if (confirm('해당 환불을 거절하시겠습니까?')) {
	            rejectRefund(refundId,userId,pointAmount);
	        }
	    }
	});
	
	function approveRefund(refundId,userId,pointAmount) {
	    $.ajax({
	        url: '<%=request.getContextPath()%>/admin/approvePointRefund.do', 
	        method: 'POST',
	        data: { refundId: refundId, userId: userId, pointAmount: pointAmount},
	        success: function(result) {
	            if(result === "success") {
	                alert('승인 완료!');
	                
	                location.reload(); 
	            } else {
	                alert('승인 실패!');
	            }
	        },
	        error: function() {
	            alert('서버 오류!');
	        }
	    });
	}
	
	function rejectRefund(refundId) {
	    $.ajax({
	        url: '<%=request.getContextPath()%>/admin/rejectPointRefund.do', 
	        method: 'POST',
	        data: { refundId: refundId, userId: userId, pointAmount: pointAmount },
	        success: function(result) {
	            if(result === "success") {
	                alert('거절 완료!');
	                location.reload(); 
	            } else {
	                alert('거절 실패!');
	            }
	        },
	        error: function() {
	            alert('서버 오류!');
	        }
	    });
	}

</script>
