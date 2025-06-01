package com.niw.study.model.dto;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Builder;

@Builder
public record Calendar(int calendarNo, String calendarName, String calendarContent, Timestamp startTime, Timestamp endTime, String userId) {

}
