package com.brexa.used.comm;

import java.util.Calendar;

public class Chaebun {
	public static final String MEMBER = "M"; // 멤버
	public static final String ITEM = "I"; // 상품
	public static final String WISH = "W"; // 찜
	public static final String REPORT = "R"; // 신고
	public static final String CHAT_MSG = "C"; // 채팅메세지
	public static final String CHAT_ROOM = "T"; // 채팅방
	
	public static String getDate() {
		System.out.println("Chaebun getDate() 함수진입 >>>");
		Calendar cal = Calendar.getInstance();
		String year = String.valueOf(cal.get(Calendar.YEAR));
		String month = String.valueOf(cal.get(Calendar.MONTH)+1);
		String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
		
		if(month.length()==1) {
			month = "0" + month;
		}
		if(day.length()==1) {
			day = "0" + day;
		}
		String date = year+month+day;
		System.out.println("date >> " + date);
		System.out.printf("%S %S %S", year,month,day);
		
		return date;
	}
	public static String getNo(int no) {
		System.out.println("Chaebun getNo() 함수진입 >>>");
		System.out.println("no >> " + no);
		
		String num = String.valueOf(no);
		if(num.length()==1) {
			num = "00" + num;
		}else if(num.length()==2){
			num = "0" + num;
		}
		return num;
	}
	// 회원 채번
	public static String getMember(int no) {
        String mno = Chaebun.MEMBER+Chaebun.getDate()+Chaebun.getNo(no);
        System.out.println("회원 채번 결과 >>>> " + mno);
        return mno;
	}
	
	// 상품 채번
	public static String getItem(int no) {
		String ino = Chaebun.ITEM+Chaebun.getDate()+Chaebun.getNo(no);
		System.out.println("상품 채번 결과 >>>> " + ino);
		return ino;
	}
	
	// 위시 채번
	public static String getWish(int no) {
		String wno = Chaebun.WISH+Chaebun.getDate()+Chaebun.getNo(no);
		System.out.println("위시 채번 결과 >>>> " + wno);
		return wno;
	}
	
	// 신고 채번
	public static String getReport(int no) {
		String rno = Chaebun.REPORT+Chaebun.getDate()+Chaebun.getNo(no);
		System.out.println("신고 채번 결과 >>>> " + rno);
		return rno;
	}
	
	// 신고 채번
	public static String getChatMsg(int no) {
		String cno = Chaebun.CHAT_MSG+Chaebun.getDate()+Chaebun.getNo(no);
		System.out.println("채팅 메세지 결과 >>>> " + cno);
		return cno;
	}
		
	// 신고 채번
	public static String getChatRoom(int no) {
		String tno = Chaebun.CHAT_ROOM+Chaebun.getDate()+Chaebun.getNo(no);
		System.out.println("채팅 방 결과 >>>> " + tno);
		return tno;
	}

//	public static void main(String args[]) {
//		System.out.println("Chaebun.getMno(1) >> " + Chaebun.getMno(1));
//	} 

}
