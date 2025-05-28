package com.niw.board.model.dto;

import java.sql.Timestamp;

import lombok.Builder;

@Builder
public record Article(
			int articleId,
			String userId,
			String articleTitle,
			String articleContent,
			Timestamp articleDateTime,
			Timestamp articleModifiedTime,
			int articleViews,
			int articleLikes,
			int articleDislikes,
			int articleCategory,
			int articleDelete,
			int commentCount
		) {

}
