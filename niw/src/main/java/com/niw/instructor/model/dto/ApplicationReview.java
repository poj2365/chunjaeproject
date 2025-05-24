package com.niw.instructor.model.dto;

import java.sql.Date;

import com.niw.instructor.model.Enums.ApplicationStatus;

public record ApplicationReview(
		int reviewId,
	    int applicationId,
	    ApplicationStatus previousStatus,
	    ApplicationStatus newStatus,
	    String reviewerId,
	    String reviewComment,
	    Date reviewDate
	    ) {

}
