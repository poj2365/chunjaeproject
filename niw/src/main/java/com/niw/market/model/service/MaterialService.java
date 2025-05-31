package com.niw.market.model.service;

import static com.niw.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.niw.market.model.dao.MaterialDao;
import com.niw.market.model.dto.Material;

public enum MaterialService {
	SERVICE;

	private MaterialDao dao = MaterialDao.DAO;

	public int registMaterial(Material material) {
		Connection conn = getConnection();
		int result = dao.registMaterial(conn, material);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public Material searchByCategory(String category) {
		Connection conn = getConnection();
		Material material= null;
		close(conn);
		return material;
	}


	

	   public List<Material> getAllMaterials(int currentPage, int materialsPerPage) {
	        Connection conn = JDBCTemplate.getConnection();
	        List<Material> materials = null;
	        
	        try {
	            int startRow = (currentPage - 1) * materialsPerPage;
	            int endRow = currentPage * materialsPerPage;
	            materials = dao.selectAllMaterials(conn, startRow, endRow);
	        } finally {
	            JDBCTemplate.close(conn);
	        }
	        
	        return materials;
	    }
	    
	    /**
	     * 카테고리별 자료 목록 조회 (페이징)
	     */
	    public List<Material> getMaterialsByCategory(String category, String grade, String subject, 
	                                                int currentPage, int materialsPerPage) {
	        Connection conn = JDBCTemplate.getConnection();
	        List<Material> materials = null;
	        
	        try {
	            int startRow = (currentPage - 1) * materialsPerPage;
	            int endRow = currentPage * materialsPerPage;
	            materials = dao.selectByCategory(conn, category, grade, subject, startRow, endRow);
	        } finally {
	            JDBCTemplate.close(conn);
	        }
	        
	        return materials;
	    }
	    
	    /**
	     * 자료 상세 조회
	     */
	    public Material getMaterialDetail(int materialId) {
	        Connection conn = JDBCTemplate.getConnection();
	        Material material = null;
	        
	        try {
	            material = dao.selectMaterialDetail(conn, materialId);
	            if (material != null) {
	                // 조회수 증가
	                dao.incrementViewCount(conn, materialId);
	                JDBCTemplate.commit(conn);
	            }
	        } catch (Exception e) {
	            JDBCTemplate.rollback(conn);
	            e.printStackTrace();
	        } finally {
	            JDBCTemplate.close(conn);
	        }
	        
	        return material;
	    }
	    
	    /**
	     * 전체 자료 수 조회
	     */
	    public int getTotalMaterialCount() {
	        Connection conn = JDBCTemplate.getConnection();
	        int count = 0;
	        
	        try {
	            count = dao.countAllMaterials(conn);
	        } finally {
	            JDBCTemplate.close(conn);
	        }
	        
	        return count;
	    }
	    
	    /**
	     * 카테고리별 자료 수 조회
	     */
	    public int getTotalMaterialCountByCategory(String category, String grade, String subject) {
	        Connection conn = JDBCTemplate.getConnection();
	        int count = 0;
	        
	        try {
	            count = dao.countByCategory(conn, category, grade, subject);
	        } finally {
	            JDBCTemplate.close(conn);
	        }
	        
	        return count;
	    }
	    
	    /**
	     * 자료 구매
	     */
	    public boolean purchaseMaterial(String userId, int materialId, int purchasePrice) {
	        Connection conn = JDBCTemplate.getConnection();
	        boolean success = false;
	        
	        try {
	            // 이미 구매했는지 확인
	            if (dao.checkPurchase(conn, userId, materialId)) {
	                return false; // 이미 구매함
	            }
	            
	            // 구매 처리
	            int result = dao.insertPurchase(conn, userId, materialId, purchasePrice);
	            
	            if (result > 0) {
	                // 다운로드 수 증가
	                dao.incrementDownloadCount(conn, materialId);
	                JDBCTemplate.commit(conn);
	                success = true;
	            } else {
	                JDBCTemplate.rollback(conn);
	            }
	            
	        } catch (Exception e) {
	            JDBCTemplate.rollback(conn);
	            e.printStackTrace();
	        } finally {
	            JDBCTemplate.close(conn);
	        }
	        
	        return success;
	    }
	    
	    /**
	     * 구매 여부 확인
	     */
//	    public boolean isPurchased(String userId, int materialId) {
//	        Connection conn = getConnection();
//	        boolean isPurchased = false;
//	        
//	        try {
//	            isPurchased = dao.checkPurchase(conn, userId, materialId);
//	        } finally {
//	            close(conn);
//	        }
//	        
//	        return isPurchased;
//	    }
//	    
	    /**
	     * 페이지 정보 계산
	     */
	    public PageInfo calculatePageInfo(int currentPage, int totalCount, int itemsPerPage) {
	        int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
	        
	        // 페이지 범위 계산 (현재 페이지 기준 ±2)
	        int startPage = Math.max(1, currentPage - 2);
	        int endPage = Math.min(totalPages, currentPage + 2);
	        
	        // 시작 페이지가 1에서 너무 멀면 조정
	        if (endPage - startPage < 4 && totalPages > 5) {
	            if (startPage == 1) {
	                endPage = Math.min(5, totalPages);
	            } else if (endPage == totalPages) {
	                startPage = Math.max(1, totalPages - 4);
	            }
	        }
	        
	        return new PageInfo(currentPage, totalPages, startPage, endPage, totalCount);
	    }

}
