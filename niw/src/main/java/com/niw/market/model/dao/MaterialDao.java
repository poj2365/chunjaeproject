package com.niw.market.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
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
		try(PreparedStatement pstmt = conn.prepareStatement(sqlProp.getProperty("registMaterial"))) {
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
			
			String thumbnailFilePaths=String.join(",", material.thumbnailFilePaths());
			pstmt.setString(13, thumbnailFilePaths);
			pstmt.setString(14, material.instructorIntro());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

}
