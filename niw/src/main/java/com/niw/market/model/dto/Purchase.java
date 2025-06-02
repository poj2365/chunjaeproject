package com.niw.market.model.dto;

import java.sql.Date;
import lombok.Builder;

@Builder
public record Purchase(
        int purchaseId,           // 구매 ID
        String userId,            // 구매자 ID
        int materialId,           // 자료 ID
        int purchasePrice,        // 구매 가격
        String purchaseStatus,    // 구매 상태 (COMPLETED, CANCELLED, REFUNDED)
        Date purchaseDate,        // 구매 일시
        Date downloadExpireDate   // 다운로드 만료일 (선택사항)
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