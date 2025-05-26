package com.niw.market.model.dto;

import java.sql.Date;
import java.util.List;

public record Material(
		int materialId,
		String userId,
		String instructorName,
		String materialTitle,
		String materialDiscription,
		int materialPrice,
		List<String> thumbnailFilePaths,
		String materialFilePath,
		String materialType,
		String materialStatus,
		String materialCategoryPrimary,
		String materialCategorySecondary,
		String materialCategorySubject,
		Date materialCreatedDate,
		Date materialUpdatedDate
		) {

}
