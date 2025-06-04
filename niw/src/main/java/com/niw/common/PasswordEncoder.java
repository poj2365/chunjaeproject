package com.niw.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class PasswordEncoder extends HttpServletRequestWrapper{
	
	public PasswordEncoder(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String ori) {
		if(ori.equals("password")||ori.equals("currentPwd")||ori.equals("newPwd")) {
			return getSHA512(super.getParameter(ori));
		}
		return super.getParameter(ori);
	}
	
	public String getSHA512(String oriVal) {
		//java.security패키지에 MessageDigest클래스를 이용
		//1. 알고리즘을 선택 ->SHA512방식으로 사용
		//2. 원본값을 byte배열로 변환
		//3. 반환된 알고리즘 인스턴스(MessageDigest)를 이용해서 암호화
		//   결과 byte배열을 반환함.
		//4. 문자열로 변환 -> Base64Encoder
		MessageDigest md=null;
		try {
			md=MessageDigest.getInstance("SHA-512");
		}catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		byte[] oriValArr=oriVal.getBytes();
		md.update(oriValArr);
		byte[] encOriValArr=md.digest();
		
		String encStr=Base64.getEncoder().encodeToString(encOriValArr);
		
		return encStr;
	}
	
	
	
}
