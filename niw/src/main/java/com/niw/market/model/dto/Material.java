package com.niw.market.model.dto;

import java.sql.Date;
import java.util.List;


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
	

	
}
