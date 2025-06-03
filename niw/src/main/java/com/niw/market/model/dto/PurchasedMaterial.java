package com.niw.market.model.dto;

import java.sql.Date;
import java.util.List;
import lombok.Builder;

@Builder
public record PurchasedMaterial(
        // Material 정보
        int materialId,
        String userId,
        String instructorName,
        String instructorIntro,
        String materialTitle,
        String originalFileName,
        String savedFileName,
        String materialDiscription,
        int materialPrice,
        int materialPage,
        List<String> thumbnailFilePaths,
        String previewPath,
        String materialFilePath,
        String materialStatus,
        String materialCategory,
        String materialGrade,
        String materialSubject,
        Date materialCreatedDate,
        Date materialUpdatedDate,
        int materialViewCount,
        int materialDownloadCount,
        double materialRating,
        int materialCommentCount,
        
        // Purchase 정보
        int purchaseId,
        int purchasePrice,
        String purchaseStatus,
        Date purchaseDate,
        Date downloadExpireDate
) {
    
    // 편의 메서드들
    public boolean isCompleted() {
        return "COMPLETED".equals(purchaseStatus);
    }
    
    public boolean isExpired() {
        if (downloadExpireDate == null) return false;
        return downloadExpireDate.before(new Date(System.currentTimeMillis()));
    }
    
    public boolean canDownload() {
        return isCompleted() && !isExpired();
    }
}