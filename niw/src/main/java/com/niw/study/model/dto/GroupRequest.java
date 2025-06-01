package com.niw.study.model.dto;

import java.util.Date;

import lombok.Builder;

@Builder
public record GroupRequest(
		int requestId, String userId, String userName, String userAddress, String userPhone, String reason, int groupNumber,
		Date requestDate, String status
		) {

}
