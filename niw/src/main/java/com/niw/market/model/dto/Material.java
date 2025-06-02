package com.niw.market.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.Builder;

@Builder
public record Material(
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
		int materialCommentCount
		) {

    public static class MaterialListResult {
        private List<Material> materials;
        private int totalCount;
        private int totalPage;
        private int currentPage;
        private int pageSize;
        
        // Getters and Setters
        public List<Material> getMaterials() {
            return materials;
        }
        
        public void setMaterials(List<Material> materials) {
            this.materials = materials;
        }
        
        public int getTotalCount() {
            return totalCount;
        }
        
        public void setTotalCount(int totalCount) {
            this.totalCount = totalCount;
        }
        
        public int getTotalPage() {
            return totalPage;
        }
        
        public void setTotalPage(int totalPage) {
            this.totalPage = totalPage;
        }
        
        public int getCurrentPage() {
            return currentPage;
        }
        
        public void setCurrentPage(int currentPage) {
            this.currentPage = currentPage;
        }
        
        public int getPageSize() {
            return pageSize;
        }
        
        public void setPageSize(int pageSize) {
            this.pageSize = pageSize;
        }
        
        // 페이징 관련 편의 메서드들
        public boolean hasNextPage() {
            return currentPage < totalPage;
        }
        
        public boolean hasPreviousPage() {
            return currentPage > 1;
        }
        
        public int getStartPage(int pageBarSize) {
            return ((currentPage - 1) / pageBarSize) * pageBarSize + 1;
        }
        
        public int getEndPage(int pageBarSize) {
            int endPage = getStartPage(pageBarSize) + pageBarSize - 1;
            return Math.min(endPage, totalPage);
        }
    }

	
}
