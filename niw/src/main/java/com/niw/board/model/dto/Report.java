package com.niw.board.model.dto;

import lombok.Builder;
 
@Builder
public record Report(
			int reportId,
			int articleId,
			String userId,
			String reportType,
			String reportContent,
			String boardType,
			String reportYn
		) {

}
