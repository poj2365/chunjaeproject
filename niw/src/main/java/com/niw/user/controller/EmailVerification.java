package com.niw.user.controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import com.niw.common.JDBCTemplate;

/**
 * 이메일 인증 서비스 (오라클용)
 * 데이터베이스 프로시저를 통해 인증번호 관리
 */
public class EmailVerification {
    
    /**
     * 기존 이메일 인증번호 삭제
     * 
     * @param email 이메일 주소
     * @throws SQLException
     */
    public void deleteExistingVerification(String email) throws SQLException {
        Connection conn = null;
        CallableStatement cstmt = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            // 오라클 프로시저 호출: CALL SP_DELETE_EMAIL_VERIFICATION(?)
            String sql = "{CALL SP_DELETE_EMAIL_VERIFICATION(?)}";
            cstmt = conn.prepareCall(sql);
            cstmt.setString(1, email);
            
            cstmt.execute();
            
        } catch (SQLException e) {
            System.err.println("기존 인증번호 삭제 실패: " + email);
            throw e;
        } finally {
            JDBCTemplate.close(cstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 이메일 인증번호 저장
     * 
     * @param email 이메일 주소
     * @param verificationCode 인증번호
     * @return 저장 성공 여부
     * @throws SQLException
     */
    public boolean saveVerificationCode(String email, String verificationCode) throws SQLException {
        Connection conn = null;
        CallableStatement cstmt = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            // 오라클 프로시저 호출: CALL SP_SAVE_EMAIL_VERIFICATION(?, ?, ?)
            String sql = "{CALL SP_SAVE_EMAIL_VERIFICATION(?, ?, ?)}";
            cstmt = conn.prepareCall(sql);
            cstmt.setString(1, email);
            cstmt.setString(2, verificationCode);
            cstmt.registerOutParameter(3, Types.NUMERIC); // 오라클은 Types.NUMERIC 사용
            
            cstmt.execute();
            
            int resultCode = cstmt.getInt(3);
            return resultCode == 1; // 1: 성공, 0: 실패
            
        } catch (SQLException e) {
            System.err.println("인증번호 저장 실패: " + email);
            throw e;
        } finally {
            JDBCTemplate.close(cstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 이메일 인증번호 확인
     * 
     * @param email 이메일 주소
     * @param verificationCode 입력된 인증번호
     * @return 인증 성공 여부
     * @throws SQLException
     */
    public boolean verifyCode(String email, String verificationCode) throws SQLException {
        Connection conn = null;
        CallableStatement cstmt = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            // 오라클 프로시저 호출: CALL SP_VERIFY_EMAIL_CODE(?, ?, ?)
            String sql = "{CALL SP_VERIFY_EMAIL_CODE(?, ?, ?)}";
            cstmt = conn.prepareCall(sql);
            cstmt.setString(1, email);
            cstmt.setString(2, verificationCode);
            cstmt.registerOutParameter(3, Types.NUMERIC); // 오라클은 Types.NUMERIC 사용
            
            cstmt.execute();
            
            int resultCode = cstmt.getInt(3);
            return resultCode == 1; // 1: 인증성공, 0: 인증실패(코드불일치/만료)
            
        } catch (SQLException e) {
            System.err.println("인증번호 확인 실패: " + email);
            throw e;
        } finally {
            JDBCTemplate.close(cstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 특정 이메일의 인증번호 삭제
     * 
     * @param email 이메일 주소
     * @throws SQLException
     */
    public void deleteVerificationCode(String email) throws SQLException {
        deleteExistingVerification(email); // 동일한 로직 재사용
    }
    
    /**
     * 만료된 인증번호 일괄 삭제 (배치 작업용)
     * 
     * @return 삭제된 레코드 수
     * @throws SQLException
     */
    public int deleteExpiredVerifications() throws SQLException {
        Connection conn = null;
        CallableStatement cstmt = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            // 오라클 프로시저 호출: CALL SP_DELETE_EXPIRED_VERIFICATIONS(?)
            String sql = "{CALL SP_DELETE_EXPIRED_VERIFICATIONS(?)}";
            cstmt = conn.prepareCall(sql);
            cstmt.registerOutParameter(1, Types.NUMERIC); // 삭제된 레코드 수
            
            cstmt.execute();
            
            int deletedCount = cstmt.getInt(1);
            System.out.println("만료된 인증번호 정리 완료: " + deletedCount + "건");
            
            return deletedCount;
            
        } catch (SQLException e) {
            System.err.println("만료된 인증번호 정리 실패");
            throw e;
        } finally {
            JDBCTemplate.close(cstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 특정 이메일의 인증 상태 확인
     * 
     * @param email 이메일 주소
     * @return EmailVerificationStatus 객체 (상태와 남은 시간 정보)
     * @throws SQLException
     */
    public EmailVerificationStatus checkVerificationStatus(String email) throws SQLException {
        Connection conn = null;
        CallableStatement cstmt = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            // 오라클 프로시저 호출: CALL SP_CHECK_EMAIL_VERIFICATION_STATUS(?, ?, ?)
            String sql = "{CALL SP_CHECK_EMAIL_VERIFICATION_STATUS(?, ?, ?)}";
            cstmt = conn.prepareCall(sql);
            cstmt.setString(1, email);
            cstmt.registerOutParameter(2, Types.NUMERIC); // 상태
            cstmt.registerOutParameter(3, Types.NUMERIC); // 남은 시간(분)
            
            cstmt.execute();
            
            int status = cstmt.getInt(2);
            int remainingMinutes = cstmt.getInt(3);
            
            return new EmailVerificationStatus(status, remainingMinutes);
            
        } catch (SQLException e) {
            System.err.println("인증 상태 확인 실패: " + email);
            throw e;
        } finally {
            JDBCTemplate.close(cstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 이메일 인증 상태 정보를 담는 클래스
     */
    public static class EmailVerificationStatus {
        private int status;         // 0: 없음, 1: 유효, 2: 만료
        private int remainingMinutes; // 남은 시간(분)
        
        public EmailVerificationStatus(int status, int remainingMinutes) {
            this.status = status;
            this.remainingMinutes = remainingMinutes;
        }
        
        public int getStatus() {
            return status;
        }
        
        public int getRemainingMinutes() {
            return remainingMinutes;
        }
        
        public boolean isValid() {
            return status == 1;
        }
        
        public boolean isExpired() {
            return status == 2;
        }
        
        public boolean isNotFound() {
            return status == 0;
        }
        
        public String getStatusMessage() {
            switch (status) {
                case 0: return "인증번호가 없습니다";
                case 1: return "인증번호가 유효합니다 (남은시간: " + remainingMinutes + "분)";
                case 2: return "인증번호가 만료되었습니다";
                default: return "알 수 없는 상태";
            }
        }
    }
}