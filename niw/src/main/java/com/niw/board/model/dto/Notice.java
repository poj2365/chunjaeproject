package com.niw.board.model.dto;

import lombok.Builder;

@Builder
public record Notice(
			int noticeId,
			String noticeTitle,
			String noticeContent
		) {

}
