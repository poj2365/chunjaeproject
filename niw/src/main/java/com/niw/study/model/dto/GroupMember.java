package com.niw.study.model.dto;

import java.util.Date;

import lombok.Builder;

@Builder	    
public record GroupMember(
		int groupNumber,
		String userId,
		String role,
		String status,
		Date joinDate
		) {

}
