package com.brexa.used.wish.vo;

public class WishVO {
	private String ino;
	private String mno;
	private String wno;
	
	// 기본생성자
	public WishVO() {
		super();
	}

	// 생성자
	public WishVO(String ino, String mno, String wno) {
		super();
		this.ino = ino;
		this.mno = mno;
		this.wno = wno;
	}

	// Getter
	public String getIno() {
		return ino;
	}

	public String getMno() {
		return mno;
	}

	public String getWno() {
		return wno;
	}

	// Setter
	public void setIno(String ino) {
		this.ino = ino;
	}

	public void setMno(String mno) {
		this.mno = mno;
	}

	public void setWno(String wno) {
		this.wno = wno;
	}
	
	
	
	
}
