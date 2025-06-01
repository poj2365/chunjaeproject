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

import com.niw.market.model.dto.Material;
import com.niw.user.model.dao.UserDao;

public enum MaterialDao {
	DAO;

	private Properties sqlProp = new Properties();

	{
		String path = UserDao.class.getResource("/sql/material_sql.properties").getPath();
		try (FileReader fr = new FileReader(path)) {
			sqlProp.load(fr);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public int registMaterial(Connection conn, Material material) {
		int result = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("registMaterial"))) {
			pstmt.setString(1, material.userId());
			pstmt.setString(2, material.instructorName());
			pstmt.setString(3, material.materialTitle());
			pstmt.setString(4, material.originalFileName());
			pstmt.setString(5, material.savedFileName());
			pstmt.setString(6, material.materialDiscription());
			pstmt.setInt(7, material.materialPrice());

			pstmt.setString(8, material.materialFilePath());
			pstmt.setString(9, material.materialCategory());
			pstmt.setString(10, material.materialGrade());
			pstmt.setString(11, material.materialSubject());
			pstmt.setInt(12, material.materialPage());
			String thumbnailFilePaths = String.join(",", material.thumbnailFilePaths());
			pstmt.setString(13, thumbnailFilePaths);
			pstmt.setString(14, material.instructorIntro());
			pstmt.setString(15, material.previewPath());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}



	   /**
     * ID로 자료 조회
     */
    public Material searchById(Connection conn, int materialId) {
        Material material = null;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("searchById"))) {
            pstmt.setInt(1, materialId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    material = getMaterial(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return material;
    }

    /**
     * 필터링된 자료 목록 조회
     */
    public List<Material> getMaterialListByFilter(Connection conn, String category, String grade, String subject, int startRow, int endRow) {
        List<Material> materials = new ArrayList<>();
        String sql = getSqlByFilter(category, grade, subject);
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int paramIndex = setFilterParameters(pstmt, category, grade, subject);
            pstmt.setInt(paramIndex++, endRow);
            pstmt.setInt(paramIndex, startRow);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    materials.add(getMaterial(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }

    /**
     * 필터별 자료 개수 조회
     */
    public int getTotalCountByFilter(Connection conn, String category, String grade, String subject) {
        int count = 0;
        String sql = getCountSqlByFilter(category, grade, subject);
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            setFilterParameters(pstmt, category, grade, subject);
            
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

    /**
     * 조회수 증가
     */
    public int increaseViewCount(Connection conn, int materialId) {
        int result = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("increaseViewCount"))) {
            pstmt.setInt(1, materialId);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 다운로드수 증가
     */
    public int increaseDownloadCount(Connection conn, int materialId) {
        int result = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("increaseDownloadCount"))) {
            pstmt.setInt(1, materialId);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 필터 조건에 따른 SQL 선택
     */
    private String getSqlByFilter(String category, String grade, String subject) {
        if (isNotEmpty(category) && isNotEmpty(grade) && isNotEmpty(subject)) {
            return sqlProp.getProperty("getMaterialListByAll");
        } else if (isNotEmpty(category) && isNotEmpty(grade)) {
            return sqlProp.getProperty("getMaterialListByCategoryAndGrade");
        } else if (isNotEmpty(category) && isNotEmpty(subject)) {
            return sqlProp.getProperty("getMaterialListByCategoryAndSubject");
        } else if (isNotEmpty(category)) {
            switch(category) {
                case "초등": return sqlProp.getProperty("getMaterialListByElementary");
                case "중등": return sqlProp.getProperty("getMaterialListByMiddle");
                case "고등": return sqlProp.getProperty("getMaterialListByHigh");
                default: return sqlProp.getProperty("getMaterialList");
            }
        } else {
            return sqlProp.getProperty("getMaterialList");
        }
    }

    /**
     * 필터 조건에 따른 COUNT SQL 선택
     */
    private String getCountSqlByFilter(String category, String grade, String subject) {
        if (isNotEmpty(category) && isNotEmpty(grade) && isNotEmpty(subject)) {
            return sqlProp.getProperty("getTotalCountByAll");
        } else if (isNotEmpty(category) && isNotEmpty(grade)) {
            return sqlProp.getProperty("getTotalCountByCategoryAndGrade");
        } else if (isNotEmpty(category) && isNotEmpty(subject)) {
            return sqlProp.getProperty("getTotalCountByCategoryAndSubject");
        } else if (isNotEmpty(category)) {
            switch(category) {
                case "초등": return sqlProp.getProperty("getTotalCountByElementary");
                case "중등": return sqlProp.getProperty("getTotalCountByMiddle");
                case "고등": return sqlProp.getProperty("getTotalCountByHigh");
                default: return sqlProp.getProperty("getTotalMaterialCount");
            }
        } else {
            return sqlProp.getProperty("getTotalMaterialCount");
        }
    }

    /**
     * 필터 파라미터 설정
     */
    private int setFilterParameters(PreparedStatement pstmt, String category, String grade, String subject) throws SQLException {
        int paramIndex = 1;
        
        if (isNotEmpty(category) && isNotEmpty(grade) && isNotEmpty(subject)) {
            pstmt.setString(paramIndex++, category);
            pstmt.setString(paramIndex++, grade);
            pstmt.setString(paramIndex++, subject);
        } else if (isNotEmpty(category) && isNotEmpty(grade)) {
            pstmt.setString(paramIndex++, category);
            pstmt.setString(paramIndex++, grade);
        } else if (isNotEmpty(category) && isNotEmpty(subject)) {
            pstmt.setString(paramIndex++, category);
            pstmt.setString(paramIndex++, subject);
        }
        // 단일 카테고리나 전체 조회의 경우 파라미터 없음
        
        return paramIndex;
    }

    /**
     * 문자열이 비어있지 않고 "전체"가 아닌지 확인
     */
    private boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty() && !"전체".equals(value);
    }

	public Material getMaterial(ResultSet rs) throws SQLException {
		String thumbnailFilePath = rs.getString("thumbnail_file_path");
		List<String> thumbnailFilePaths = Arrays.asList(thumbnailFilePath.split(","));
		return new Material(rs.getInt("material_id"), rs.getString("user_id"), rs.getString("instructor_name"),
				rs.getString("instructor_intro"), rs.getString("material_title"), rs.getString("original_file_name"),
				rs.getString("saved_file_name"), rs.getString("material_discription"), rs.getInt("material_price"),
				rs.getInt("material_page"), thumbnailFilePaths, "", rs.getString("material_file_path"),
				rs.getString("material_status"), rs.getString("material_category_primary"),
				rs.getString("material_category_secondary"), rs.getString("material_category_subject"),
				rs.getDate("material_created_date"), rs.getDate("material_updated_date"),
				rs.getInt("material_view_count"), rs.getInt("material_download_count"), rs.getDouble("material_rating"),
				rs.getInt("material_comment_count"));
	}

}
