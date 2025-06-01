package com.niw.market.model.service;

import java.sql.Connection;
import java.util.List;

import com.niw.common.JDBCTemplate;
import com.niw.market.model.dao.MaterialDao;
import com.niw.market.model.dto.Material;

public enum MaterialService {
    SERVICE;
    
    private MaterialDao dao = MaterialDao.DAO;
    
    /**
     * 자료 등록
     */
    public int registMaterial(Material material) {
        Connection conn = JDBCTemplate.getConnection();
        int result = 0;
        
        try {
            result = dao.registMaterial(conn, material);
            
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
     * 자료 상세 조회 (조회수 증가 포함)
     */
    public Material getMaterialDetail(int materialId) {
        Connection conn = JDBCTemplate.getConnection();
        Material material = null;
        
        try {
            // 자료 조회
            material = dao.searchById(conn, materialId);
            
            if (material != null) {
                // 조회수 증가
                int updateResult = dao.increaseViewCount(conn, materialId);
                
                if (updateResult > 0) {
                    JDBCTemplate.commit(conn);
                    // 조회수가 증가된 자료 다시 조회
                    material = dao.searchById(conn, materialId);
                } else {
                    JDBCTemplate.rollback(conn);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            JDBCTemplate.rollback(conn);
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return material;
    }
    
    /**
     * 자료 조회 (조회수 증가 없음)
     */
    public Material getMaterialById(int materialId) {
        Connection conn = JDBCTemplate.getConnection();
        Material material = null;
        
        try {
            material = dao.searchById(conn, materialId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return material;
    }
    
  
    public MaterialListResult getMaterialList(String category, String grade, String subject, int currentPage, int pageSize) {
        Connection conn = JDBCTemplate.getConnection();
        MaterialListResult result = new MaterialListResult();
        
        try {
            
            int totalCount = dao.getTotalCountByFilter(conn, category, grade, subject);
            
            
            int totalPage = (int) Math.ceil((double) totalCount / pageSize);
            if (totalPage == 0) totalPage = 1;
            
       
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPage) currentPage = totalPage;
            
            int startRow = (currentPage - 1) * pageSize + 1;
            int endRow = currentPage * pageSize;
            
           
            List<Material> materials = dao.getMaterialListByFilter(conn, category, grade, subject, startRow, endRow);
            
          
            result.setMaterials(materials);
            result.setTotalCount(totalCount);
            result.setTotalPage(totalPage);
            result.setCurrentPage(currentPage);
            result.setPageSize(pageSize);
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTemplate.close(conn);
        }
        
        return result;
    }
    
    
    public MaterialListResult getAllMaterialList(int currentPage, int pageSize) {
        return getMaterialList("전체", "전체", "전체", currentPage, pageSize);
    }
    

    public MaterialListResult getMaterialListByCategory(String category, int currentPage, int pageSize) {
        return getMaterialList(category, "전체", "전체", currentPage, pageSize);
    }
    
 
    public boolean increaseViewCount(int materialId) {
        Connection conn = JDBCTemplate.getConnection();
        boolean result = false;
        
        try {
            int updateResult = dao.increaseViewCount(conn, materialId);
            
            if (updateResult > 0) {
                JDBCTemplate.commit(conn);
                result = true;
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
    
    
    public boolean increaseDownloadCount(int materialId) {
        Connection conn = JDBCTemplate.getConnection();
        boolean result = false;
        
        try {
            int updateResult = dao.increaseDownloadCount(conn, materialId);
            
            if (updateResult > 0) {
                JDBCTemplate.commit(conn);
                result = true;
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
    
 
    public static class MaterialListResult {
        private List<Material> materials;
        private int totalCount;
        private int totalPage;
        private int currentPage;
        private int pageSize;
        
   
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