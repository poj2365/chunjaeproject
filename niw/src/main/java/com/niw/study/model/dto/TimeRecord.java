package com.niw.study.model.dto;

import java.sql.Timestamp;

public record TimeRecord(int timeNo, String category, Timestamp startTime, Timestamp endTime, String totalTime, String userId) {

}
