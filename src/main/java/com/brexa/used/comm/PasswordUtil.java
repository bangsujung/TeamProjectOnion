package com.brexa.used.comm;

import java.security.SecureRandom;

public class PasswordUtil {
	public static String makeTempPassword() {
		final String ALPA = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; // 응용
		final String NUMBERS = "0123456789";
		
		// 알파벳 + 숫자 조합
		String all = ALPA+NUMBERS;
		// 난수 셍성 객체 생성
		SecureRandom random = new SecureRandom();
		// 문자열 객체 생성
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i<6; i++) {
			sb.append(PasswordUtil.getRandomChar(all, random)); // 알파벳 + 숫자 조합 6자리
		}
		System.out.println("sb >>" + sb.toString());
		//sb.append()
		return sb.toString();
	}
	// 문자열에서 랜덤으로 문자 하나 가져오는 기능
	private static String getRandomChar(String str, SecureRandom random) {
		return String.valueOf(str.charAt(random.nextInt(str.length())));
	}
	public static void main(String args[]) {
		System.out.println(PasswordUtil.makeTempPassword());
	}
}

