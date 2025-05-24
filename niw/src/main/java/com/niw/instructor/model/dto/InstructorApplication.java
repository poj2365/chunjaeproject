package com.niw.instructor.model.dto;

import java.sql.Date;
import java.util.List;

import com.niw.instructor.model.Enums.ApplicationStatus;




public record InstructorApplication(
	int applicationId,
	String userId,
	String instructorName,
	
	String bankName,
	String accountHolder,
	String accountNumber,
	
	String introduction,
	
	List<PortfolioFile> porfolioFiles,
	
	ApplicationStatus applicationStatus,
	Date applicationDate,
	Date updateDate
	 ){}
