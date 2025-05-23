package com.niw.user.model.dto;


import java.sql.Date;

import lombok.Builder;

@Builder
public record User(
		String userId,
		String password,
		String userName,
		String userPhone,
		String userEmail,
		String userProfileImage,
		int userPoint,
		String userIntroduce,
		Date enrollDate,
		String userRole,
		String userAddress,
		Date userBirthDate

		) {
}
