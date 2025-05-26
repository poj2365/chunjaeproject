package com.niw.point.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Point {
	
	private long pointId;
	private String userId;
	private int pointAmount;
	private String pointType;
	private String pointDescription;
	private Date createdDate;
}
