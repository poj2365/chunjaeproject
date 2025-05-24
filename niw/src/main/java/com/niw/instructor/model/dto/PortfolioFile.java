package com.niw.instructor.model.dto;

import java.sql.Date;


public record PortfolioFile(
		int portfolioId,
		int applicationId,
		String originalFileName,
		String storedFilename,
		String filePath,
		int fileSize,
		String fileType,
		String fileExtension,
		Date uploadDate
		) {

}
