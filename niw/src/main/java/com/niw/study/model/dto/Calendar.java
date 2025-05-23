package com.niw.study.model.dto;

import java.util.Date;

import lombok.Builder;

@Builder
public record Calendar( String calendarName, String calendarContent, Date startTime, Date endTime, String userId) {

}
