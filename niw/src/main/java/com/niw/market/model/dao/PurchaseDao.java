package com.niw.market.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.niw.market.model.dto.Purchase;
import com.niw.user.model.dao.UserDao;

public enum PurchaseDao {
    DAO;
    
    private Properties sqlProp = new Properties();

    {
        String path = UserDao.class.getResource("/sql/purchase_sql.properties").getPath();
        try (FileReader fr = new FileReader(path)) {
            sqlProp.load(fr);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * 구매 여부 확인
     */
    public boolean isPurchased(Connection conn, String userId, int materialId) {
        boolean isPurchased = false;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("checkPurchase"))) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, materialId);
            try (ResultSet rs = pstmt.executeQuery()) {
                isPurchased = rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isPurchased;
    }
    
    /**
     * 여러 자료의 구매 여부 한번에 확인
     */
    public List<Integer> getPurchasedMaterialIds(Connection conn, String userId, List<Integer> materialIds) {
        List<Integer> purchasedIds = new ArrayList<>();
        
        if (materialIds.isEmpty()) return purchasedIds;
        
        // IN 절을 위한 동적 쿼리 생성
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT MATERIAL_ID FROM PURCHASE WHERE USER_ID = ? AND MATERIAL_ID IN (");
        for (int i = 0; i < materialIds.size(); i++) {
            if (i > 0) sql.append(",");
            sql.append("?");
        }
        sql.append(") AND PURCHASE_STATUS = 'COMPLETED'");
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            pstmt.setString(1, userId);
            for (int i = 0; i < materialIds.size(); i++) {
                pstmt.setInt(i + 2, materialIds.get(i));
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    purchasedIds.add(rs.getInt("MATERIAL_ID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return purchasedIds;
    }
    
    /**
     * 구매 정보 조회
     */
    public Purchase getPurchaseInfo(Connection conn, String userId, int materialId) {
        Purchase purchase = null;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getPurchaseInfo"))) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, materialId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    purchase = new Purchase(
                        rs.getInt("PURCHASE_ID"),
                        rs.getString("USER_ID"),
                        rs.getInt("MATERIAL_ID"),
                        rs.getInt("PURCHASE_PRICE"),
                        rs.getString("PURCHASE_STATUS"),
                        rs.getDate("PURCHASE_DATE"),
                        rs.getDate("DOWNLOAD_EXPIRE_DATE")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return purchase;
    }
    
    /**
     * 구매 등록
     */
    
    public int insertPurchase(Connection conn, Purchase purchase) {
        int result = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("insertPurchase"))) {
            pstmt.setString(1, purchase.userId());
            pstmt.setInt(2, purchase.materialId());
            pstmt.setInt(3, purchase.purchasePrice());
            pstmt.setString(4, purchase.purchaseStatus());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}