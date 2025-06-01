//package com.niw.user.controller;
//
//import java.sql.CallableStatement;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Types;
//
//import com.niw.common.JDBCTemplate;
//
///**
// * 이메일 인증 서비스 (오라클용)
// * 데이터베이스 프로시저를 통해 인증번호 관리
// */
//public class EmailVerification {
//    
//    /**
//     * 기존 이메일 인증번호 삭제
//     * 
//     * @param email 이메일 주소
//     * @throws SQLException
//     */
//    public void deleteExistingVerification(String email) throws SQLException {
//        Connection conn = null;
//        CallableStatement cstmt = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            // 오라클 프로시저 호출: CALL SP_DELETE_EMAIL_VERIFICATION(?)
//            String sql = "{CALL SP_DELETE_EMAIL_VERIFICATION(?)}";
//            cstmt = conn.prepareCall(sql);
//            cstmt.setString(1, email);
//            
//            cstmt.execute();
//            
//        } catch (SQLException e) {
//            System.err.println("기존 인증번호 삭제 실패: " + email);
//            throw e;
//        } finally {
//            JDBCTemplate.close(cstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//    
//    /**
//     * 이메일 인증번호 저장
//     * 
//     * @param email 이메일 주소
//     * @param verificationCode 인증번호
//     * @return 저장 성공 여부
//     * @throws SQLException
//     */
//    public boolean saveVerificationCode(String email, String verificationCode) throws SQLException {
//        Connection conn = null;
//        CallableStatement cstmt = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            // 오라클 프로시저 호출: CALL SP_SAVE_EMAIL_VERIFICATION(?, ?, ?)
//            String sql = "{CALL SP_SAVE_EMAIL_VERIFICATION(?, ?, ?)}";
//            cstmt = conn.prepareCall(sql);
//            cstmt.setString(1, email);
//            cstmt.setString(2, verificationCode);
//            cstmt.registerOutParameter(3, Types.NUMERIC); // 오라클은 Types.NUMERIC 사용
//            
//            cstmt.execute();
//            
//            int resultCode = cstmt.getInt(3);
//            return resultCode == 1; // 1: 성공, 0: 실패
//            
//        } catch (SQLException e) {
//            System.err.println("인증번호 저장 실패: " + email);
//            throw e;
//        } finally {
//            JDBCTemplate.close(cstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//    
//    /**
//     * 이메일 인증번호 확인
//     * 
//     * @param email 이메일 주소
//     * @param verificationCode 입력된 인증번호
//     * @return 인증 성공 여부
//     * @throws SQLException
//     */
//    public boolean verifyCode(String email, String verificationCode) throws SQLException {
//        Connection conn = null;
//        CallableStatement cstmt = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            // 오라클 프로시저 호출: CALL SP_VERIFY_EMAIL_CODE(?, ?, ?)
//            String sql = "{CALL SP_VERIFY_EMAIL_CODE(?, ?, ?)}";
//            cstmt = conn.prepareCall(sql);
//            cstmt.setString(1, email);
//            cstmt.setString(2, verificationCode);
//            cstmt.registerOutParameter(3, Types.NUMERIC); // 오라클은 Types.NUMERIC 사용
//            
//            cstmt.execute();
//            
//            int resultCode = cstmt.getInt(3);
//            return resultCode == 1; // 1: 인증성공, 0: 인증실패(코드불일치/만료)
//            
//        } catch (SQLException e) {
//            System.err.println("인증번호 확인 실패: " + email);
//            throw e;
//        } finally {
//            JDBCTemplate.close(cstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//    
//    /**
//     * 특정 이메일의 인증번호 삭제
//     * 
//     * @param email 이메일 주소
//     * @throws SQLException
//     */
//    public void deleteVerificationCode(String email) throws SQLException {
//        deleteExistingVerification(email); // 동일한 로직 재사용
//    }
//    
//    /**
//     * 만료된 인증번호 일괄 삭제 (배치 작업용)
//     * 
//     * @return 삭제된 레코드 수
//     * @throws SQLException
//     */
//    public int deleteExpiredVerifications() throws SQLException {
//        Connection conn = null;
//        CallableStatement cstmt = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            // 오라클 프로시저 호출: CALL SP_DELETE_EXPIRED_VERIFICATIONS(?)
//            String sql = "{CALL SP_DELETE_EXPIRED_VERIFICATIONS(?)}";
//            cstmt = conn.prepareCall(sql);
//            cstmt.registerOutParameter(1, Types.NUMERIC); // 삭제된 레코드 수
//            
//            cstmt.execute();
//            
//            int deletedCount = cstmt.getInt(1);
//            System.out.println("만료된 인증번호 정리 완료: " + deletedCount + "건");
//            
//            return deletedCount;
//            
//        } catch (SQLException e) {
//            System.err.println("만료된 인증번호 정리 실패");
//            throw e;
//        } finally {
//            JDBCTemplate.close(cstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//    
//    /**
//     * 특정 이메일의 인증 상태 확인
//     * 
//     * @param email 이메일 주소
//     * @return EmailVerificationStatus 객체 (상태와 남은 시간 정보)
//     * @throws SQLException
//     */
//    public EmailVerificationStatus checkVerificationStatus(String email) throws SQLException {
//        Connection conn = null;
//        CallableStatement cstmt = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            // 오라클 프로시저 호출: CALL SP_CHECK_EMAIL_VERIFICATION_STATUS(?, ?, ?)
//            String sql = "{CALL SP_CHECK_EMAIL_VERIFICATION_STATUS(?, ?, ?)}";
//            cstmt = conn.prepareCall(sql);
//            cstmt.setString(1, email);
//            cstmt.registerOutParameter(2, Types.NUMERIC); // 상태
//            cstmt.registerOutParameter(3, Types.NUMERIC); // 남은 시간(분)
//            
//            cstmt.execute();
//            
//            int status = cstmt.getInt(2);
//            int remainingMinutes = cstmt.getInt(3);
//            
//            return new EmailVerificationStatus(status, remainingMinutes);
//            
//        } catch (SQLException e) {
//            System.err.println("인증 상태 확인 실패: " + email);
//            throw e;
//        } finally {
//            JDBCTemplate.close(cstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//    
//    /**
//     * 이메일 인증 상태 정보를 담는 클래스
//     */
//    public static class EmailVerificationStatus {
//        private int status;         // 0: 없음, 1: 유효, 2: 만료
//        private int remainingMinutes; // 남은 시간(분)
//        
//        public EmailVerificationStatus(int status, int remainingMinutes) {
//            this.status = status;
//            this.remainingMinutes = remainingMinutes;
//        }
//        
//        public int getStatus() {
//            return status;
//        }
//        
//        public int getRemainingMinutes() {
//            return remainingMinutes;
//        }
//        
//        public boolean isValid() {
//            return status == 1;
//        }
//        
//        public boolean isExpired() {
//            return status == 2;
//        }
//        
//        public boolean isNotFound() {
//            return status == 0;
//        }
//        
//        public String getStatusMessage() {
//            switch (status) {
//                case 0: return "인증번호가 없습니다";
//                case 1: return "인증번호가 유효합니다 (남은시간: " + remainingMinutes + "분)";
//                case 2: return "인증번호가 만료되었습니다";
//                default: return "알 수 없는 상태";
//            }
//        }
//    }
//    
// // EmailVerification 클래스에 추가할 메서드
//
//
//    public boolean savePasswordResetCode(String email, String verificationCode, String userId) throws SQLException {
//        Connection conn = null;
//        PreparedStatement pstmt = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            System.out.println("=== 비밀번호 찾기 인증번호 저장 ===");
//            System.out.println("이메일: " + email);
//            System.out.println("인증번호: " + verificationCode); 
//            System.out.println("사용자ID: " + userId);
//            
//            // 1. 기존 비밀번호 찾기 인증번호 삭제
//            String deleteSql = "DELETE FROM EMAIL_VERIFICATION WHERE EMAIL = ? AND VERIFICATION_TYPE = 'PASSWORD_RESET'";
//            pstmt = conn.prepareStatement(deleteSql);
//            pstmt.setString(1, email);
//            int deleteCount = pstmt.executeUpdate();
//            System.out.println("기존 인증번호 삭제: " + deleteCount + "건");
//            JDBCTemplate.close(pstmt);
//            
//            // 2. 새 인증번호 저장
//            String insertSql = "INSERT INTO EMAIL_VERIFICATION (EMAIL, VERIFICATION_CODE, VERIFICATION_TYPE, USER_ID, CREATED_AT, EXPIRES_AT) " +
//                              "VALUES (?, ?, 'PASSWORD_RESET', ?, SYSDATE, SYSDATE + INTERVAL '5' MINUTE)";
//            pstmt = conn.prepareStatement(insertSql);
//            pstmt.setString(1, email);
//            pstmt.setString(2, verificationCode);
//            pstmt.setString(3, userId);
//            
//            int result = pstmt.executeUpdate();
//            System.out.println("새 인증번호 저장 결과: " + result);
//            
//            if (result > 0) {
//                JDBCTemplate.commit(conn);
//                System.out.println("✅ 비밀번호 찾기 인증번호 저장 성공!");
//                return true;
//            } else {
//                JDBCTemplate.rollback(conn);
//                System.err.println("❌ 비밀번호 찾기 인증번호 저장 실패!");
//                return false;
//            }
//            
//        } catch (SQLException e) {
//            JDBCTemplate.rollback(conn);
//            System.err.println("❌ 비밀번호 찾기 인증번호 저장 오류: " + e.getMessage());
//            e.printStackTrace();
//            throw e;
//        } finally {
//            JDBCTemplate.close(pstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//
//    /**
//     * 비밀번호 찾기 인증번호 확인 및 사용자 아이디 반환
//     * 
//     * @param email 이메일 주소
//     * @param verificationCode 입력된 인증번호
//     * @return 인증 성공 시 사용자 아이디, 실패 시 null
//     * @throws SQLException
//     */
//    public String verifyPasswordResetCode(String email, String verificationCode) throws SQLException {
//        Connection conn = null;
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
//        
//        try {
//            conn = JDBCTemplate.getConnection();
//            
//            System.out.println("=== 비밀번호 찾기 인증번호 확인 ===");
//            System.out.println("이메일: " + email);
//            System.out.println("입력된 인증번호: " + verificationCode);
//            
//            // 1. 유효한 인증번호 확인 및 사용자 아이디 조회
//            String selectSql = "SELECT USER_ID FROM EMAIL_VERIFICATION " +
//                              "WHERE EMAIL = ? AND VERIFICATION_CODE = ? AND VERIFICATION_TYPE = 'PASSWORD_RESET' " +
//                              "AND EXPIRES_AT > SYSDATE";
//            pstmt = conn.prepareStatement(selectSql);
//            pstmt.setString(1, email);
//            pstmt.setString(2, verificationCode);
//            rs = pstmt.executeQuery();
//            
//            if (rs.next()) {
//                String userId = rs.getString("USER_ID");
//                System.out.println("✅ 인증 성공! 사용자 ID: " + userId);
//                
//                // 2. 인증 성공 시 해당 레코드 삭제
//                JDBCTemplate.close(rs);
//                JDBCTemplate.close(pstmt);
//                
//                String deleteSql = "DELETE FROM EMAIL_VERIFICATION WHERE EMAIL = ? AND VERIFICATION_TYPE = 'PASSWORD_RESET'";
//                pstmt = conn.prepareStatement(deleteSql);
//                pstmt.setString(1, email);
//                int deleteResult = pstmt.executeUpdate();
//                
//                System.out.println("사용된 인증번호 삭제: " + deleteResult + "건");
//                
//                JDBCTemplate.commit(conn);
//                return userId;
//                
//            } else {
//                System.out.println("❌ 인증 실패! (만료되었거나 일치하지 않음)");
//                
//                // 디버깅을 위해 해당 이메일의 모든 레코드 조회
//                debugEmailVerification(email, conn);
//                return null;
//            }
//            
//        } catch (SQLException e) {
//            JDBCTemplate.rollback(conn);
//            System.err.println("❌ 비밀번호 찾기 인증번호 확인 오류: " + e.getMessage());
//            e.printStackTrace();
//            throw e;
//        } finally {
//            JDBCTemplate.close(rs);
//            JDBCTemplate.close(pstmt);
//            JDBCTemplate.close(conn);
//        }
//    }
//
//    /**
//     * 디버깅용: 특정 이메일의 인증번호 레코드 조회
//     */
//    private void debugEmailVerification(String email, Connection conn) {
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
//        
//        try {
//            String sql = "SELECT EMAIL, VERIFICATION_CODE, VERIFICATION_TYPE, USER_ID, " +
//                        "TO_CHAR(CREATED_AT, 'YYYY-MM-DD HH24:MI:SS') AS CREATED_TIME, " +
//                        "TO_CHAR(EXPIRES_AT, 'YYYY-MM-DD HH24:MI:SS') AS EXPIRES_TIME, " +
//                        "TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS CURRENT_TIME, " +
//                        "CASE WHEN EXPIRES_AT > SYSDATE THEN 'VALID' ELSE 'EXPIRED' END AS STATUS " +
//                        "FROM EMAIL_VERIFICATION WHERE EMAIL = ? ORDER BY CREATED_AT DESC";
//            pstmt = conn.prepareStatement(sql);
//            pstmt.setString(1, email);
//            rs = pstmt.executeQuery();
//            
//            System.out.println("========== " + email + " 인증번호 레코드 조회 ==========");
//            int count = 0;
//            while (rs.next()) {
//                count++;
//                System.out.println("[" + count + "] 코드: " + rs.getString("VERIFICATION_CODE") + 
//                                 " | 타입: " + rs.getString("VERIFICATION_TYPE") + 
//                                 " | 사용자: " + rs.getString("USER_ID"));
//                System.out.println("    생성시간: " + rs.getString("CREATED_TIME") + 
//                                 " | 만료시간: " + rs.getString("EXPIRES_TIME"));
//                System.out.println("    현재시간: " + rs.getString("CURRENT_TIME") + 
//                                 " | 상태: " + rs.getString("STATUS"));
//                System.out.println("    ---");
//            }
//            if (count == 0) {
//                System.out.println("    해당 이메일의 인증번호가 없습니다.");
//            }
//            System.out.println("================================================");
//            
//        } catch (SQLException e) {
//            System.err.println("디버깅 조회 오류: " + e.getMessage());
//        } finally {
//            JDBCTemplate.close(rs);
//            JDBCTemplate.close(pstmt);
//        }
//    }
//}




package com.niw.user.controller;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import com.niw.common.JDBCTemplate;

/**
 * 이메일 인증 서비스 (혼합 버전)
 * 회원가입: 프로시저 사용 (기존 방식 유지)
 * 비밀번호 찾기: 일반 SQL 사용 (안정성 확보)
 */
public class EmailVerification {
    
    /**
     * 기존 이메일 인증번호 삭제 (프로시저 사용)
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
     * 이메일 인증번호 저장 (회원가입용 - 프로시저 사용)
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
            System.err.println("회원가입 인증번호 저장 실패: " + email);
            throw e;
        } finally {
            JDBCTemplate.close(cstmt);
            JDBCTemplate.close(conn);
        }
    }
    /**
     * 이메일 인증번호 확인 (회원가입용 - 일반 SQL 사용으로 변경)
     */
    public boolean verifyCode(String email, String verificationCode) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            System.out.println("=== 회원가입 인증번호 확인 ===");
            System.out.println("이메일: " + email);
            System.out.println("입력된 인증번호: " + verificationCode);
            
            // 1. 유효한 회원가입 인증번호 확인
            String selectSql = "SELECT COUNT(*) as CNT FROM EMAIL_VERIFICATION " +
                              "WHERE EMAIL = ? AND VERIFICATION_CODE = ? AND VERIFICATION_TYPE = 'SIGNUP' " +
                              "AND EXPIRES_AT > SYSDATE";
            pstmt = conn.prepareStatement(selectSql);
            pstmt.setString(1, email);
            pstmt.setString(2, verificationCode);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt("CNT");
                System.out.println("유효한 인증번호 개수: " + count);
                
                if (count > 0) {
                    System.out.println("✅ 회원가입 인증 성공!");
                    
                    // 2. 인증 성공 시 해당 레코드 삭제
                    JDBCTemplate.close(rs);
                    JDBCTemplate.close(pstmt);
                    
                    String deleteSql = "DELETE FROM EMAIL_VERIFICATION " +
                                      "WHERE EMAIL = ? AND VERIFICATION_CODE = ? AND VERIFICATION_TYPE = 'SIGNUP' " +
                                      "AND EXPIRES_AT > SYSDATE";
                    pstmt = conn.prepareStatement(deleteSql);
                    pstmt.setString(1, email);
                    pstmt.setString(2, verificationCode);
                    int deleteResult = pstmt.executeUpdate();
                    
                    System.out.println("사용된 인증번호 삭제: " + deleteResult + "건");
                    
                    JDBCTemplate.commit(conn);
                    return true;
                    
                } else {
                    System.out.println("❌ 회원가입 인증 실패! (만료되었거나 일치하지 않음)");
                    
                    // 디버깅을 위해 해당 이메일의 모든 레코드 조회
                    debugEmailVerification(email, conn);
                    return false;
                }
                
            } else {
                System.out.println("❌ 회원가입 인증 실패! (쿼리 결과 없음)");
                return false;
            }
            
        } catch (SQLException e) {
            JDBCTemplate.rollback(conn);
            System.err.println("❌ 회원가입 인증번호 확인 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            JDBCTemplate.close(rs);
            JDBCTemplate.close(pstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 특정 이메일의 인증번호 삭제 (프로시저 사용)
     */
    public void deleteVerificationCode(String email) throws SQLException {
        deleteExistingVerification(email); // 동일한 로직 재사용
    }
    
    /**
     * 만료된 인증번호 일괄 삭제 (배치 작업용 - 프로시저 사용)
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
     * 특정 이메일의 인증 상태 확인 (프로시저 사용)
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
    
    // ========== 비밀번호 찾기 관련 메서드들 (일반 SQL 사용) ==========
    
    /**
     * 비밀번호 찾기용 인증번호 저장 (일반 SQL 사용)
     */
    public boolean savePasswordResetCode(String email, String verificationCode, String userId) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            System.out.println("=== 비밀번호 찾기 인증번호 저장 ===");
            System.out.println("이메일: " + email);
            System.out.println("인증번호: " + verificationCode); 
            System.out.println("사용자ID: " + userId);
            
            // 1. 기존 비밀번호 찾기 인증번호 삭제
            String deleteSql = "DELETE FROM EMAIL_VERIFICATION WHERE EMAIL = ? AND VERIFICATION_TYPE = 'PASSWORD_RESET'";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setString(1, email);
            int deleteCount = pstmt.executeUpdate();
            System.out.println("기존 인증번호 삭제: " + deleteCount + "건");
            JDBCTemplate.close(pstmt);
            
            // 2. 새 인증번호 저장
            String insertSql = "INSERT INTO EMAIL_VERIFICATION (EMAIL, VERIFICATION_CODE, VERIFICATION_TYPE, USER_ID, CREATED_AT, EXPIRES_AT) " +
                              "VALUES (?, ?, 'PASSWORD_RESET', ?, SYSDATE, SYSDATE + INTERVAL '5' MINUTE)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, email);
            pstmt.setString(2, verificationCode);
            pstmt.setString(3, userId);
            
            int result = pstmt.executeUpdate();
            System.out.println("새 인증번호 저장 결과: " + result);
            
            if (result > 0) {
                JDBCTemplate.commit(conn);
                System.out.println("✅ 비밀번호 찾기 인증번호 저장 성공!");
                return true;
            } else {
                JDBCTemplate.rollback(conn);
                System.err.println("❌ 비밀번호 찾기 인증번호 저장 실패!");
                return false;
            }
            
        } catch (SQLException e) {
            JDBCTemplate.rollback(conn);
            System.err.println("❌ 비밀번호 찾기 인증번호 저장 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            JDBCTemplate.close(pstmt);
            JDBCTemplate.close(conn);
        }
    }

    /**
     * 비밀번호 찾기 인증번호 확인 및 사용자 아이디 반환 (일반 SQL 사용)
     */
    public String verifyPasswordResetCode(String email, String verificationCode) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = JDBCTemplate.getConnection();
            
            System.out.println("=== 비밀번호 찾기 인증번호 확인 ===");
            System.out.println("이메일: " + email);
            System.out.println("입력된 인증번호: " + verificationCode);
            
            // 1. 유효한 인증번호 확인 및 사용자 아이디 조회
            String selectSql = "SELECT USER_ID FROM EMAIL_VERIFICATION " +
                              "WHERE EMAIL = ? AND VERIFICATION_CODE = ? AND VERIFICATION_TYPE = 'PASSWORD_RESET' " +
                              "AND EXPIRES_AT > SYSDATE";
            pstmt = conn.prepareStatement(selectSql);
            pstmt.setString(1, email);
            pstmt.setString(2, verificationCode);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String userId = rs.getString("USER_ID");
                System.out.println("✅ 인증 성공! 사용자 ID: " + userId);
                
                // 2. 인증 성공 시 해당 레코드 삭제
                JDBCTemplate.close(rs);
                JDBCTemplate.close(pstmt);
                
                String deleteSql = "DELETE FROM EMAIL_VERIFICATION WHERE EMAIL = ? AND VERIFICATION_TYPE = 'PASSWORD_RESET'";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setString(1, email);
                int deleteResult = pstmt.executeUpdate();
                
                System.out.println("사용된 인증번호 삭제: " + deleteResult + "건");
                
                JDBCTemplate.commit(conn);
                return userId;
                
            } else {
                System.out.println("❌ 인증 실패! (만료되었거나 일치하지 않음)");
                
                // 디버깅을 위해 해당 이메일의 모든 레코드 조회
                debugEmailVerification(email, conn);
                return null;
            }
            
        } catch (SQLException e) {
            JDBCTemplate.rollback(conn);
            System.err.println("❌ 비밀번호 찾기 인증번호 확인 오류: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            JDBCTemplate.close(rs);
            JDBCTemplate.close(pstmt);
            JDBCTemplate.close(conn);
        }
    }
    
    /**
     * 디버깅용: 특정 이메일의 인증번호 레코드 조회
     */
    private void debugEmailVerification(String email, Connection conn) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            String sql = "SELECT EMAIL, VERIFICATION_CODE, VERIFICATION_TYPE, USER_ID, " +
                        "TO_CHAR(CREATED_AT, 'YYYY-MM-DD HH24:MI:SS') AS CREATED_TIME, " +
                        "TO_CHAR(EXPIRES_AT, 'YYYY-MM-DD HH24:MI:SS') AS EXPIRES_TIME, " +
                        "TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS CURRENT_TIME, " +
                        "CASE WHEN EXPIRES_AT > SYSDATE THEN 'VALID' ELSE 'EXPIRED' END AS STATUS " +
                        "FROM EMAIL_VERIFICATION WHERE EMAIL = ? ORDER BY CREATED_AT DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            System.out.println("========== " + email + " 인증번호 레코드 조회 ==========");
            int count = 0;
            while (rs.next()) {
                count++;
                System.out.println("[" + count + "] 코드: " + rs.getString("VERIFICATION_CODE") + 
                                 " | 타입: " + rs.getString("VERIFICATION_TYPE") + 
                                 " | 사용자: " + rs.getString("USER_ID"));
                System.out.println("    생성시간: " + rs.getString("CREATED_TIME") + 
                                 " | 만료시간: " + rs.getString("EXPIRES_TIME"));
                System.out.println("    현재시간: " + rs.getString("CURRENT_TIME") + 
                                 " | 상태: " + rs.getString("STATUS"));
                System.out.println("    ---");
            }
            if (count == 0) {
                System.out.println("    해당 이메일의 인증번호가 없습니다.");
            }
            System.out.println("================================================");
            
        } catch (SQLException e) {
            System.err.println("디버깅 조회 오류: " + e.getMessage());
        } finally {
            JDBCTemplate.close(rs);
            JDBCTemplate.close(pstmt);
        }
    }
}