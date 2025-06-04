package com.niw.point.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor

public class PointRefundFileList {
	
	private String refundId;
	private String userId;
	private String userName;
	private Date refundDate;
	private String fileName;
	private int price;
	private String status;
	
}
