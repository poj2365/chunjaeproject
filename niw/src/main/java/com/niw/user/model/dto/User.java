package com.niw.user.model.dto;

import java.sql.Date;

public record User(
	    String userId,              // 회원 ID (Primary Key)
	    String userPwd,             // 비밀번호
	    String userName,            // 회원 이름
	    String userPhone,           // 전화번호
	    String userEmail,           // 이메일
	    String userProfileImg,      // 프로필 이미지 경로
	    String userGrade,           // 회원 등급 (STUDENT, INSTRUCTOR, ADMIN 등)
	    int userPoint,              // 포인트
	    Date userCreateDate,        // 생성일
	    Date userUpdateDate         // 수정일
	) {}
