package com.niw.market.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.market.model.dao.PurchasedMaterialDao;
import com.niw.market.model.dao.PurchasedMaterialDao.PurchaseStats;
import com.niw.market.model.dto.PurchasedMaterial;

public enum PurchasedMaterialService {
    SERVICE;
    
    private PurchasedMaterialDao dao = PurchasedMaterialDao.DAO;
    
    /**
     * 사용자가 구매한 자료 목록 조회 (페이징)
     */
    public List<PurchasedMaterial> getPurchasedMaterialList(String userId, int cPage, int pageSize) {
        if (userId == null) {
            return List.of();
        }
        
        Connection conn = JDBCTemplate.getConnection();
        List<PurchasedMaterial> materials = List.of();
        
        try {
            // 페이징 계산
        	
            int startRow = (cPage - 1) * pageSize + 1;
            int endRow = cPage * pageSize;
            
            // 자료 목록 조회
            materials = dao.getPurchasedMaterialList(conn, userId, startRow, endRow);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return materials;
    }
    
    /**
     * 사용자가 구매한 자료 총 개수
     */
    
    public int getPurchasedMaterialCount(String userId) {
        if (userId == null) {
            return 0;
        }
        
        Connection conn = JDBCTemplate.getConnection();
        int totalCount = 0;
        
        try {
            totalCount = dao.getPurchasedMaterialCount(conn, userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return totalCount;
    }
    
    /**
     * 사용자의 구매 통계 조회
     */
    
    public PurchaseStats getPurchaseStats(String userId) {
        if (userId == null) {
            return new PurchaseStats(0, 0, 0, 0);
        }
        
        Connection conn = JDBCTemplate.getConnection();
        PurchaseStats stats = new PurchaseStats(0, 0, 0, 0);
        
        try {
            stats = dao.getPurchaseStats(conn, userId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return stats;
    }
    
    /**
     * 전체 페이지 수 계산
     */
    public int getTotalPage(int totalCount, int pageSize) {
        return (int) Math.ceil((double) totalCount / pageSize);
    }
    
    /**
     * 페이지바 시작 페이지 계산
     */
    public int getStartPage(int currentPage, int pageBarSize) {
        return ((currentPage - 1) / pageBarSize) * pageBarSize + 1;
    }
    
    /**
     * 페이지바 끝 페이지 계산
     */
    public int getEndPage(int currentPage, int pageBarSize, int totalPage) {
        int startPage = getStartPage(currentPage, pageBarSize);
        int endPage = startPage + pageBarSize - 1;
        return Math.min(endPage, totalPage);
    }
}