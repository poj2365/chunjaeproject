package com.niw.market.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import com.niw.market.model.dto.PurchasedMaterial;
import com.niw.user.model.dao.UserDao;

public enum PurchasedMaterialDao {
    DAO;

    private Properties sqlProp = new Properties();

    {
        String path = UserDao.class.getResource("/sql/purchase_material_sql.properties").getPath();
        try (FileReader fr = new FileReader(path)) {
            sqlProp.load(fr);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    
    public List<PurchasedMaterial> getPurchasedMaterialList(Connection conn, String userId, int startRow, int endRow) {
        List<PurchasedMaterial> materials = new ArrayList<>();
        
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getPurchasedMaterialList"))) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, endRow);
            pstmt.setInt(3, startRow);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    materials.add(getPurchasedMaterial(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }

  
    public int getPurchasedMaterialCount(Connection conn, String userId) {
        int count = 0;
        
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getPurchasedMaterialCount"))) {
            pstmt.setString(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }


    public PurchaseStats getPurchaseStats(Connection conn, String userId) {
        PurchaseStats stats = new PurchaseStats(0, 0, 0, 0);
        
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getPurchaseStats"))) {
            pstmt.setString(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    stats = new PurchaseStats(
                        rs.getInt("TOTAL_COUNT"),
                        rs.getInt("TOTAL_AMOUNT"),
                        rs.getInt("TOTAL_DOWNLOADS"),
                        rs.getInt("TOTAL_REVIEWS")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

  
    private PurchasedMaterial getPurchasedMaterial(ResultSet rs) throws SQLException {
        String thumbnailFilePath = rs.getString("THUMBNAIL_FILE_PATH");
        List<String> thumbnailFilePaths = new ArrayList<>();
        if (thumbnailFilePath != null && !thumbnailFilePath.isEmpty()) {
            thumbnailFilePaths = Arrays.asList(thumbnailFilePath.split(","));
        }
        
        return PurchasedMaterial.builder()
            // Material 정보
            .materialId(rs.getInt("MATERIAL_ID"))
            .userId(rs.getString("USER_ID"))
            .instructorName(rs.getString("INSTRUCTOR_NAME"))
            .instructorIntro(rs.getString("INSTRUCTOR_INTRO"))
            .materialTitle(rs.getString("MATERIAL_TITLE"))
            .originalFileName(rs.getString("ORIGINAL_FILE_NAME"))
            .savedFileName(rs.getString("SAVED_FILE_NAME"))
            .materialDiscription(rs.getString("MATERIAL_DISCRIPTION"))
            .materialPrice(rs.getInt("MATERIAL_PRICE"))
            .materialPage(rs.getInt("MATERIAL_PAGE"))
            .thumbnailFilePaths(thumbnailFilePaths)
            .previewPath(rs.getString("PREVIEW_PATH"))
            .materialFilePath(rs.getString("MATERIAL_FILE_PATH"))
            .materialStatus(rs.getString("MATERIAL_STATUS"))
            .materialCategory(rs.getString("MATERIAL_CATEGORY_PRIMARY"))
            .materialGrade(rs.getString("MATERIAL_CATEGORY_SECONDARY"))
            .materialSubject(rs.getString("MATERIAL_CATEGORY_SUBJECT"))
            .materialCreatedDate(rs.getDate("MATERIAL_CREATED_DATE"))
            .materialUpdatedDate(rs.getDate("MATERIAL_UPDATED_DATE"))
            .materialViewCount(rs.getInt("MATERIAL_VIEW_COUNT"))
            .materialDownloadCount(rs.getInt("MATERIAL_DOWNLOAD_COUNT"))
            .materialRating(rs.getDouble("MATERIAL_RATING"))
            .materialCommentCount(rs.getInt("MATERIAL_COMMENT_COUNT"))
            
           
            .purchaseId(rs.getInt("PURCHASE_ID"))
            .purchasePrice(rs.getInt("PURCHASE_PRICE"))
            .purchaseStatus(rs.getString("PURCHASE_STATUS"))
            .purchaseDate(rs.getDate("PURCHASE_DATE"))
            .downloadExpireDate(rs.getDate("DOWNLOAD_EXPIRE_DATE"))
            .build();
    }

   
    public static record PurchaseStats(
        int totalCount,
        int totalAmount,
        int totalDownloads,
        int totalReviews
    ) {}
}