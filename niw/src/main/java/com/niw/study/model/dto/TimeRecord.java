package com.niw.study.model.dto;

import java.util.Date;

public record TimeRecord(int timeNo, String category, Date startTime, Date endTime, String totalTime, String userId) {

}
