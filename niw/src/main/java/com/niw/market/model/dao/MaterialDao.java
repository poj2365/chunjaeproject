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

	public Material searchById(Connection conn, int materialId) {
		Material material = null;
		try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("searchById"))) {
			pstmt.setInt(1, materialId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {

				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return material;
	}

	   // 전체 자료 목록 조회
    public List<Material> getMaterialList(Connection conn, int startRow, int endRow) {
        List<Material> materials = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getMaterialList"))) {
            pstmt.setInt(1, endRow);
            pstmt.setInt(2, startRow);
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

    // 카테고리별 자료 목록 조회
    public List<Material> getMaterialListByCategory(Connection conn, String category, int startRow, int endRow) {
        List<Material> materials = new ArrayList<>();
        String sql = "";
        
        switch(category) {
            case "초등":
                sql = sqlProp.getProperty("getMaterialListByElementary");
                break;
            case "중등":
                sql = sqlProp.getProperty("getMaterialListByMiddle");
                break;
            case "고등":
                sql = sqlProp.getProperty("getMaterialListByHigh");
                break;
            default:
                sql = sqlProp.getProperty("getMaterialList");
        }
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, endRow);
            pstmt.setInt(2, startRow);
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

    // 카테고리, 학년, 과목별 자료 목록 조회
    public List<Material> getMaterialListByFilter(Connection conn, String category, String grade, String subject, int startRow, int endRow) {
        List<Material> materials = new ArrayList<>();
        String sql = "";
        
        if (category != null && !category.equals("전체") && grade != null && !grade.equals("전체") && subject != null && !subject.equals("전체")) {
            sql = sqlProp.getProperty("getMaterialListByAll");
        } else if (category != null && !category.equals("전체") && grade != null && !grade.equals("전체")) {
            sql = sqlProp.getProperty("getMaterialListByCategoryAndGrade");
        } else if (category != null && !category.equals("전체") && subject != null && !subject.equals("전체")) {
            sql = sqlProp.getProperty("getMaterialListByCategoryAndSubject");
        } else if (category != null && !category.equals("전체")) {
            return getMaterialListByCategory(conn, category, startRow, endRow);
        } else {
            return getMaterialList(conn, startRow, endRow);
        }
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            
            if (sql.equals(sqlProp.getProperty("getMaterialListByAll"))) {
                pstmt.setString(paramIndex++, category);
                pstmt.setString(paramIndex++, grade);
                pstmt.setString(paramIndex++, subject);
            } else if (sql.equals(sqlProp.getProperty("getMaterialListByCategoryAndGrade"))) {
                pstmt.setString(paramIndex++, category);
                pstmt.setString(paramIndex++, grade);
            } else if (sql.equals(sqlProp.getProperty("getMaterialListByCategoryAndSubject"))) {
                pstmt.setString(paramIndex++, category);
                pstmt.setString(paramIndex++, subject);
            }
            
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

    // 전체 자료 개수 조회
    public int getTotalMaterialCount(Connection conn) {
        int count = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("getTotalMaterialCount"))) {
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

    // 카테고리별 자료 개수 조회
    public int getTotalCountByCategory(Connection conn, String category) {
        int count = 0;
        String sql = "";
        
        switch(category) {
            case "초등":
                sql = sqlProp.getProperty("getTotalCountByElementary");
                break;
            case "중등":
                sql = sqlProp.getProperty("getTotalCountByMiddle");
                break;
            case "고등":
                sql = sqlProp.getProperty("getTotalCountByHigh");
                break;
            default:
                sql = sqlProp.getProperty("getTotalMaterialCount");
        }
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

    // 필터별 자료 개수 조회
    public int getTotalCountByFilter(Connection conn, String category, String grade, String subject) {
        int count = 0;
        String sql = "";
        
        if (category != null && !category.equals("전체") && grade != null && !grade.equals("전체") && subject != null && !subject.equals("전체")) {
            sql = sqlProp.getProperty("getTotalCountByAll");
        } else if (category != null && !category.equals("전체") && grade != null && !grade.equals("전체")) {
            sql = sqlProp.getProperty("getTotalCountByCategoryAndGrade");
        } else if (category != null && !category.equals("전체") && subject != null && !subject.equals("전체")) {
            sql = sqlProp.getProperty("getTotalCountByCategoryAndSubject");
        } else if (category != null && !category.equals("전체")) {
            return getTotalCountByCategory(conn, category);
        } else {
            return getTotalMaterialCount(conn);
        }
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            
            if (sql.equals(sqlProp.getProperty("getTotalCountByAll"))) {
                pstmt.setString(paramIndex++, category);
                pstmt.setString(paramIndex++, grade);
                pstmt.setString(paramIndex, subject);
            } else if (sql.equals(sqlProp.getProperty("getTotalCountByCategoryAndGrade"))) {
                pstmt.setString(paramIndex++, category);
                pstmt.setString(paramIndex, grade);
            } else if (sql.equals(sqlProp.getProperty("getTotalCountByCategoryAndSubject"))) {
                pstmt.setString(paramIndex++, category);
                pstmt.setString(paramIndex, subject);
            }
            
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

	public Material getMaterial(ResultSet rs) throws SQLException {
		String thumbnailFilePath = rs.getString("thumbnail_file_path");
		List<String> thumbnailFilePaths = Arrays.asList(thumbnailFilePath.split(","));
		return new Material(rs.getInt("material_id"), rs.getString("user_id"), rs.getString("instructor_name"),
				rs.getString("instructor_intro"), rs.getString("material_title"), rs.getString("original_file_name"),
				rs.getString("saved_file_name"), rs.getString("material_discription"), rs.getInt("material_price"),
				rs.getInt("material_page"), thumbnailFilePaths, "", rs.getString("material_file_path"),
				rs.getString("material_status"), rs.getString("material_category_primary"),
				rs.getString("material_category_secondary"), rs.getString("material_categroy_subject"),
				rs.getDate("material_created_date"), rs.getDate("material_updated_date"),
				rs.getInt("material_view_count"), rs.getInt("material_download_count"), rs.getDouble("material_rating"),
				rs.getInt("material_comment_count"));
	}

}
