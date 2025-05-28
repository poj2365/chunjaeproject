package com.niw.point.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@AllArgsConstructor
@Builder

public class PointHistory {
	
	private Date date;
	private String content;
	private int changePoint;
	private int myPoint;
	
}
