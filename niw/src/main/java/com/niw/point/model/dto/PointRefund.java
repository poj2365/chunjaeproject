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
	
	private long refundId;
	private String userId;
	private Date refundDate;
	private String refundType;
	private long fileId;
	private int filePoint;
	private int refundPoint;
	private int refundAmount;
	private String refundBank;
	private String refundAccount;
	private String refundStatus;
}
