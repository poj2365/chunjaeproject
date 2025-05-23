package com.niw.instructor.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class InstructorApplication{
	private String userId;
	private String instructorName;
	
	private String bankName;
	private String accountHolder;
	private String accountNumber;
	
	private String introduction;
	
	private List<String> portFolio;
	
	private String applicationStatus;
	private Date applicationDate;
	private Date reviewDate;
	private String reviewComment;


	
}
