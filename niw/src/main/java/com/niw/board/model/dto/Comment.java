package com.niw.board.model.dto;

import java.sql.Timestamp;

import lombok.Builder;

@Builder
public record Comment(
			int commentId,
			String userId,
			int articleId,
			String commentContent,
			int commentLikes,
			int commentDislikes,
			Timestamp commentDateTime,
			int commentModified,
			int commentDelete,
			int commentRef,
			int commentLevel
		) {

}