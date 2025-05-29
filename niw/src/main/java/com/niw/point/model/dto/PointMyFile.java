package com.niw.point.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class PointMyFile {
	
	private String materialName;
	private long materialId;
	private int materialPrice;

}
