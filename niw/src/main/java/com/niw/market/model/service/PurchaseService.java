package com.niw.market.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.market.model.dao.PurchaseDao;
import com.niw.market.model.dto.Purchase;

public enum PurchaseService {
    SERVICE;
    
    private PurchaseDao dao = PurchaseDao.DAO;
    
    /**
     * 구매 여부 확인
     */
    public boolean isPurchased(String userId, int materialId) {
        if (userId == null) return false;
        
        Connection conn = JDBCTemplate.getConnection();
        boolean isPurchased = false;
        
        try {
            isPurchased = dao.isPurchased(conn, userId, materialId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return isPurchased;
    }
    
    /**
     * 여러 자료의 구매 여부 한번에 확인
     */
    public List<Integer> getPurchasedMaterialIds(String userId, List<Integer> materialIds) {
        if (userId == null || materialIds.isEmpty()) return List.of();
        
        Connection conn = JDBCTemplate.getConnection();
        List<Integer> purchasedIds = List.of();
        
        try {
            purchasedIds = dao.getPurchasedMaterialIds(conn, userId, materialIds);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return purchasedIds;
    }
    
    /**
     * 구매 정보 조회
     */
    public Purchase getPurchaseInfo(String userId, int materialId) {
        Connection conn = JDBCTemplate.getConnection();
        Purchase purchase = null;
        
        try {
            purchase = dao.getPurchaseInfo(conn, userId, materialId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return purchase;
    }
    
    /**
     * 구매 등록
     */
    public int registerPurchase(Purchase purchase) {
        Connection conn = JDBCTemplate.getConnection();
        int result = 0;
        
        try {
            result = dao.insertPurchase(conn, purchase);
            
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
     * 구매 가능 여부 확인 (이미 구매했는지 체크)
     */
    public boolean canPurchase(String userId, int materialId) {
        return !isPurchased(userId, materialId);
    }
}