package com.niw.point.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class PointRefund {
	private String userId;
	private Date refundDate;
	private String refundType;
	private int fileId;
	private int refundPoint;
	private String refundAccount;
}
