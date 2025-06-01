package com.niw.study.model.dto;

import java.sql.Timestamp;
import java.util.Date;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Message {
	private int chatId;
	private String type;
	private String sender;
	private String message;
	private int groupNumber;
	private Timestamp sendTime;
	
	public String toJson() {
		return new Gson().toJson(this);
	}

}
