package com.niw.instructor.model.Enums;

public enum ApplicationStatus {
	WATING("신청접수"),
	REVIEWING("검토중"),
	APPROVED("승인완료"),
	REJECTED("승인거부"),
	CANCELLED("신청취소");
	
	private final String status;
	
	ApplicationStatus(String status){
		this.status=status;
	}
	
	public String getStatus() {
		return status;
	}
}
