package com.niw.market.model.service;

import static com.niw.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.niw.market.model.dao.MaterialDao;
import com.niw.market.model.dto.Material;
public enum MaterialService {
	SERVICE;

	
	private MaterialDao dao=MaterialDao.DAO;
	
	public int registMaterial(Material material) {
		Connection conn = getConnection();
		int result = dao.registMaterial(conn, material);
		if(result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		return result;
	}
//	public int materialCount() {
//		Connection conn = getConnection();
//		int totalData = dao.materialCount(conn);
//		close(conn);
//		return totalData;
			
//	}
	
//	public Material searchbyId(int materialId, boolean readResult) {
//		Connection conn = getConnection();
//		Material material = dao.searchById(conn, materialId);
//		List<Material> materials = dao.searchMaterialComment(conn,materialId);

		
//	}
	
}
