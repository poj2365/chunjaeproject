package com.niw.instructor.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.instructor.model.Enums.ApplicationStatus;
import com.niw.instructor.model.dao.InstructorApplicationDao;
import com.niw.instructor.model.dto.ApplicationReview;
import com.niw.instructor.model.dto.InstructorApplication;
import com.niw.instructor.model.dto.PortfolioFile;

public enum InstructorApplicationService {
    SERVICE;
    
    private InstructorApplicationDao dao = InstructorApplicationDao.DAO;
    
    /**
     * 신청서 목록 조회 결과 클래스
     */
    public static class ApplicationListResult {
        private List<InstructorApplication> applications;
        private int totalCount;
        private int currentPage;
        private int totalPage;
        
        public ApplicationListResult(List<InstructorApplication> applications, int totalCount, int currentPage, int pageSize) {
            this.applications = applications;
            this.totalCount = totalCount;
            this.currentPage = currentPage;
            this.totalPage = (int) Math.ceil((double) totalCount / pageSize);
        }
        
        public List<InstructorApplication> getApplications() { return applications; }
        public int getTotalCount() { return totalCount; }
        public int getCurrentPage() { return currentPage; }
        public int getTotalPage() { return totalPage; }
        
        public int getStartPage(int pageBarSize) {
            return ((currentPage - 1) / pageBarSize) * pageBarSize + 1;
        }
        
        public int getEndPage(int pageBarSize) {
            int endPage = getStartPage(pageBarSize) + pageBarSize - 1;
            return Math.min(endPage, totalPage);
        }
    }
    
    /**
     * 기존 신청 메소드
     */
    public int instructorApply(InstructorApplication instructorApplication) {
        Connection conn = JDBCTemplate.getConnection();
        int result = 0;
        
        try {
            result = dao.instructorApply(conn, instructorApplication);
            
            if (result > 0) {
                JDBCTemplate.commit(conn);
            } else {
                JDBCTemplate.rollback(conn);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            JDBCTemplate.rollback(conn);
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return result;
    }
    
    /**
     * 신청서 목록 조회 (필터별)
     */
    public ApplicationListResult getApplicationList(String status, int cPage, int pageSize) {
        Connection conn = JDBCTemplate.getConnection();
        List<InstructorApplication> applications = null;
        int totalCount = 0;
        
        try {
            // 페이징 계산
            int startRow = (cPage - 1) * pageSize + 1;
            int endRow = cPage * pageSize;
            
            // 상태별로 조회
            if (status == null || status.equals("전체")) {
                applications = dao.getApplicationList(conn, startRow, endRow);
                totalCount = dao.getTotalApplicationCount(conn);
            } else {
                applications = dao.getApplicationListByStatus(conn, status, startRow, endRow);
                totalCount = dao.getTotalCountByStatus(conn, status);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return new ApplicationListResult(applications, totalCount, cPage, pageSize);
    }
    
    /**
     * 신청서 상세 조회
     */
    public InstructorApplication getApplicationDetail(int applicationId) {
        Connection conn = JDBCTemplate.getConnection();
        InstructorApplication application = null;
        
        try {
            application = dao.getApplicationById(conn, applicationId);
            
            if (application != null) {
                // 포트폴리오 파일들도 함께 조회
                List<PortfolioFile> portfolioFiles = dao.getPortfolioFilesByApplicationId(conn, applicationId);
                
                // 신청서에 포트폴리오 파일들 설정 (Record이므로 새로 생성)
                application = new InstructorApplication(
                    application.applicationId(),
                    application.userId(),
                    application.instructorName(),
                    application.bankName(),
                    application.accountHolder(),
                    application.accountNumber(),
                    application.introduction(),
                    portfolioFiles,  // 새로 조회한 파일들
                    application.applicationStatus(),
                    application.applicationDate(),
                    application.updateDate()
                );
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return application;
    }
    
    /**
     * 신청서 승인/반려 처리
     */
    public boolean processApplication(int applicationId, ApplicationStatus newStatus, String reviewerId, String reviewComment) {
        Connection conn = JDBCTemplate.getConnection();
        boolean success = false;
        
        try {
            // 기존 신청서 조회
            InstructorApplication application = dao.getApplicationById(conn, applicationId);
            if (application == null) {
                return false;
            }
            
            ApplicationStatus previousStatus = application.applicationStatus();
            
            // 상태 업데이트
            int updateResult = dao.updateApplicationStatus(conn, applicationId, newStatus);
            
            if (updateResult > 0) {
                // 승인인 경우 사용자 권한도 업데이트
                if (newStatus == ApplicationStatus.APPROVED) {
                    dao.updateUserRole(conn, application.userId());
                }
                
                // 검토 내역 추가
                ApplicationReview review = new ApplicationReview(
                    0, applicationId, previousStatus, newStatus, 
                    reviewerId, reviewComment, null
                );
                dao.insertApplicationReview(conn, review);
                
                JDBCTemplate.commit(conn);
                success = true;
            } else {
                JDBCTemplate.rollback(conn);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            JDBCTemplate.rollback(conn);
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return success;
    }
    
    /**
     * 페이징 유틸리티 메소드들
     */
    public int getStartPage(int cPage, int pageBarSize) {
        return ((cPage - 1) / pageBarSize) * pageBarSize + 1;
    }
    
    public int getEndPage(int cPage, int pageBarSize, int totalPage) {
        int endPage = getStartPage(cPage, pageBarSize) + pageBarSize - 1;
        return Math.min(endPage, totalPage);
    }
}