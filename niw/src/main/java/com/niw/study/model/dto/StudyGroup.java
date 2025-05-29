package com.niw.study.model.dto;

import java.util.Date;

import lombok.Builder;

@Builder
public record StudyGroup(int groupNumber, 
		String groupName, String userId, String groupType, String joinType, Date createDate, 
		String description, int groupLimit, String status ) {

}
