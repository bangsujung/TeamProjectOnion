package com.brexa.used.report.vo;

public class ReportVO {
	private String mid; // 신고 당한 사람의 아이디를 담기 위해 추가
	private String mno;
	private String rno;
	private int rcnt;
	
	// 기본 생성자
	public ReportVO() {
		super();
	}

	// 생성자
	public ReportVO(String mno, String rno, int rcnt) {
		super();
		this.mno = mno;
		this.rno = rno;
		this.rcnt = rcnt;
	}

	// Getter
	public String getMid() {
		return mid;
	}
	
	public String getMno() {
		return mno;
	}

	public String getRno() {
		return rno;
	}

	public int getRcnt() {
		return rcnt;
	}

	// Setter
	public void setMid(String mid) {
		this.mid = mid;
	}
	
	public void setMno(String mno) {
		this.mno = mno;
	}

	public void setRno(String rno) {
		this.rno = rno;
	}

	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}
	
	
	
}
