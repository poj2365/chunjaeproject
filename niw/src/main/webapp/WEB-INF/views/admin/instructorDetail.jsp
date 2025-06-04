<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.niw.instructor.model.dto.InstructorApplication" %>
<%@ page import="com.niw.instructor.model.dto.PortfolioFile" %>
<%@ page import="com.niw.instructor.model.Enums.ApplicationStatus" %>
<%@include file="/WEB-INF/views/common/header.jsp" %>

<%
    InstructorApplication instructorApp = (InstructorApplication)request.getAttribute("application");
    if (instructorApp == null) {
        response.sendRedirect(request.getContextPath() + "/admin/adminpage/instructor.do");
        return;
    }
%>

<style>
    .detail-container {
        max-width: 1000px;
        margin: 30px auto;
        padding: 0 20px;
    }
    
    .detail-header {
        background-color: white;
        border-radius: 10px;
        padding: 30px;
        margin-bottom: 30px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .detail-title {
        font-size: 28px;
        font-weight: bold;
        color: #333;
        margin-bottom: 10px;
    }
    
    .detail-subtitle {
        color: #666;
        font-size: 16px;
    }
    
    .status-badge {
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: 500;
        display: inline-block;
        margin-left: 15px;
    }
    
    .status-pending {
        background-color: #fff3cd;
        color: #856404;
        border: 1px solid #ffeaa7;
    }
    
    .status-approved {
        background-color: #d1e7dd;
        color: #0f5132;
        border: 1px solid #badbcc;
    }
    
    .status-rejected {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f1aeb5;
    }
    
    .detail-content {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 30px;
        margin-bottom: 30px;
    }
    
    .detail-section {
        background-color: white;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .section-title {
        font-size: 18px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid var(--bs-blind-dark);
    }
    
    .info-item {
        margin-bottom: 15px;
    }
    
    .info-label {
        font-weight: 600;
        color: #555;
        margin-bottom: 5px;
        font-size: 14px;
    }
    
    .info-value {
        color: #333;
        font-size: 16px;
        padding: 8px 12px;
        background-color: #f8f9fa;
        border-radius: 5px;
        border: 1px solid #e9ecef;
    }
    
    .portfolio-section {
        background-color: white;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }
    
    .portfolio-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }
    
    .portfolio-item {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 15px;
        background-color: #f8f9fa;
        transition: all 0.2s;
    }
    
    .portfolio-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    
    .portfolio-filename {
        font-weight: 600;
        color: #333;
        margin-bottom: 8px;
        word-break: break-all;
    }
    
    .portfolio-info {
        font-size: 12px;
        color: #666;
        margin-bottom: 10px;
    }
    
    .portfolio-download {
        background-color: var(--bs-blind-dark);
        color: white;
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
        width: 100%;
        transition: all 0.2s;
    }
    
    .portfolio-download:hover {
        background-color: var(--bs-blind-gray);
    }
    
    .introduction-section {
        grid-column: 1 / -1;
    }
    
    .introduction-text {
        background-color: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 5px;
        padding: 15px;
        min-height: 100px;
        line-height: 1.6;
        color: #333;
        white-space: pre-wrap;
    }
    
    .action-section {
        background-color: white;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
        margin-top: 20px;
    }
    
    .btn-action {
        padding: 12px 30px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s;
        min-width: 120px;
    }
    
    .btn-approve {
        background-color: #198754;
        color: white;
    }
    
    .btn-approve:hover {
        background-color: #157347;
    }
    
    .btn-reject {
        background-color: #dc3545;
        color: white;
    }
    
    .btn-reject:hover {
        background-color: #bb2d3b;
    }
    
    .btn-close {
        background-color: #6c757d;
        color: white;
    }
    
    .btn-close:hover {
        background-color: #5c636a;
    }
    
    .empty-portfolio {
        text-align: center;
        padding: 40px 20px;
        color: #888;
    }
    
    .empty-portfolio i {
        font-size: 48px;
        margin-bottom: 15px;
        color: #ddd;
    }
    
    @media (max-width: 768px) {
        .detail-content {
            grid-template-columns: 1fr;
            gap: 20px;
        }
        
        .portfolio-grid {
            grid-template-columns: 1fr;
        }
        
        .action-buttons {
            flex-direction: column;
            align-items: center;
        }
        
        .btn-action {
            width: 100%;
            max-width: 200px;
        }
    }
</style>

<div class="detail-container">
    <!-- 헤더 -->
    <div class="detail-header">
        <h1 class="detail-title">
            강사 권한 신청서 상세
            <%
            String statusClass = "";
            String statusText = "";
            switch(instructorApp.applicationStatus()) {
                case WATING:
                    statusClass = "status-pending";
                    statusText = "대기 중";
                    break;
                case APPROVED:
                    statusClass = "status-approved";
                    statusText = "승인됨";
                    break;
                case REJECTED:
                    statusClass = "status-rejected";
                    statusText = "반려됨";
                    break;
            }
            %>
            <span class="status-badge <%=statusClass%>"><%=statusText%></span>
        </h1>
        <p class="detail-subtitle">신청일: <%=instructorApp.applicationDate()%> | 신청 ID: <%=instructorApp.applicationId()%></p>
    </div>

    <!-- 상세 정보 -->
    <div class="detail-content">
        <!-- 신청자 정보 -->
        <div class="detail-section">
            <h3 class="section-title">신청자 정보</h3>
            <div class="info-item">
                <div class="info-label">사용자 ID</div>
                <div class="info-value"><%=instructorApp.userId()%></div>
            </div>
            <div class="info-item">
                <div class="info-label">강사명</div>
                <div class="info-value"><%=instructorApp.instructorName()%></div>
            </div>
            <div class="info-item">
                <div class="info-label">신청일</div>
                <div class="info-value"><%=instructorApp.applicationDate()%></div>
            </div>
            <%
            if (instructorApp.updateDate() != null) {
            %>
            <div class="info-item">
                <div class="info-label">처리일</div>
                <div class="info-value"><%=instructorApp.updateDate()%></div>
            </div>
            <%
            }
            %>
        </div>

        <!-- 계좌 정보 -->
        <div class="detail-section">
            <h3 class="section-title">정산 계좌 정보</h3>
            <div class="info-item">
                <div class="info-label">은행명</div>
                <div class="info-value"><%=instructorApp.bankName()%></div>
            </div>
            <div class="info-item">
                <div class="info-label">예금주</div>
                <div class="info-value"><%=instructorApp.accountHolder()%></div>
            </div>
            <div class="info-item">
                <div class="info-label">계좌번호</div>
                <div class="info-value"><%=instructorApp.accountNumber()%></div>
            </div>
        </div>

        <!-- 자기소개 -->
        <div class="detail-section introduction-section">
            <h3 class="section-title">강사 소개</h3>
            <div class="introduction-text">
                <%
                if (instructorApp.introduction() != null && !instructorApp.introduction().trim().isEmpty()) {
                    out.print(instructorApp.introduction());
                } else {
                    out.print("자기소개가 작성되지 않았습니다.");
                }
                %>
            </div>
        </div>
    </div>

    <!-- 포트폴리오 파일 -->
    <div class="portfolio-section">
        <h3 class="section-title">포트폴리오 파일</h3>
        <%
        if (instructorApp.porfolioFiles() != null && !instructorApp.porfolioFiles().isEmpty()) {
        %>
            <div class="portfolio-grid">
                <%
                for (PortfolioFile file : instructorApp.porfolioFiles()) {
                %>
                    <div class="portfolio-item">
                        <div class="portfolio-filename"><%=file.originalFileName()%></div>
                        <div class="portfolio-info">
                            크기: <%=String.format("%.1f KB", file.fileSize() / 1024.0)%><br>
                            타입: <%=file.fileType()%><br>
                            업로드: <%=file.uploadDate()%>
                        </div>
                        <button class="portfolio-download" onclick="downloadFile('<%=file.filePath()%>', '<%=file.originalFileName()%>')">
                            <i class="bi bi-download"></i> 다운로드
                        </button>
                    </div>
                <%
                }
                %>
            </div>
        <%
        } else {
        %>
            <div class="empty-portfolio">
                <i class="bi bi-file-earmark-x"></i>
                <p>업로드된 포트폴리오 파일이 없습니다.</p>
            </div>
        <%
        }
        %>
    </div>

    <!-- 액션 버튼 -->
    <div class="action-section">
        <h3 class="section-title">처리 액션</h3>
        <%
        if (instructorApp.applicationStatus() == ApplicationStatus.WATING) {
        %>
            <p>이 신청서를 검토하고 승인 또는 반려 처리하세요.</p>
            <div class="action-buttons">
                <button class="btn-action btn-approve" onclick="approveApplication()">
                    <i class="bi bi-check-circle"></i> 승인
                </button>
                <button class="btn-action btn-reject" onclick="rejectApplication()">
                    <i class="bi bi-x-circle"></i> 반려
                </button>
                <button class="btn-action btn-close" onclick="window.close()">
                    <i class="bi bi-arrow-left"></i> 닫기
                </button>
            </div>
        <%
        } else {
        %>
            <p>이 신청서는 이미 처리되었습니다.</p>
            <div class="action-buttons">
                <button class="btn-action btn-close" onclick="window.close()">
                    <i class="bi bi-arrow-left"></i> 닫기
                </button>
            </div>
        <%
        }
        %>
    </div>
</div>

<script>
// 포트폴리오 파일 다운로드
function downloadFile(filePath, fileName) {
    // 실제 파일 다운로드 구현
    // 서버에서 파일 다운로드 서블릿을 만들어야 함
    alert('파일 다운로드: ' + fileName + '\n경로: ' + filePath);
    // window.open('<%=request.getContextPath()%>/admin/instructor/downloadFile.do?path=' + encodeURIComponent(filePath));
}

// 승인 처리
function approveApplication() {
    var reviewComment = prompt('<%=instructorApp.instructorName()%> 강사의 권한 요청을 승인하시겠습니까?\n\n승인 사유를 입력해주세요:', '자격 요건을 충족하여 승인합니다.');
    
    if (reviewComment !== null && reviewComment.trim() !== '') {
        processApplication('approve', reviewComment);
    }
}

// 반려 처리
function rejectApplication() {
    var reviewComment = prompt('<%=instructorApp.instructorName()%> 강사의 권한 요청을 반려하시겠습니까?\n\n반려 사유를 입력해주세요:', '');
    
    if (reviewComment !== null && reviewComment.trim() !== '') {
        processApplication('reject', reviewComment);
    }
}

// 승인/반려 처리 공통 함수
function processApplication(action, reviewComment) {
    $.ajax({
        url: '<%=request.getContextPath()%>/admin/instructor/approval.do',
        type: 'POST',
        data: {
            applicationId: <%=instructorApp.applicationId()%>,
            action: action,
            reviewComment: reviewComment
        },
        success: function(response) {
            if (response.success) {
                alert(response.message);
                // 부모 창 새로고침 후 현재 창 닫기
                if (window.opener) {
                    window.opener.loadInstructorPage(window.opener.currentPage || 1);
                }
                window.close();
            } else {
                alert('오류: ' + response.message);
            }
        },
        error: function() {
            alert('서버 오류가 발생했습니다.');
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>