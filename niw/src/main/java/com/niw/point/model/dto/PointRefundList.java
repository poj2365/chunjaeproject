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
public class PointRefundList {
	private String refundId;
	private String userId;
	private String userName;
	private Date refundDate;
	private int pointAmount;
	private String bank;
	private String banckAccount;
	private String status;
}
