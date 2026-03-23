package com.brexa.used.member.vo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

public class MemberVO {
	private String mno;
	private String mname;
	private String mid;
	private String mpw;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mbirth;
	private String mphone;
	private String mmail;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date minsertdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mupdatedate;
	private String mdeleteyn;
	
	// 기본생성자
	public MemberVO() {
		super();
	}

	// 생성자
	public MemberVO(String mno, String mname, String mid, String mpw, Date mbirth, String mphone, String mmail,
			Date minsertdate, Date mupdatedate, String mdeleteyn) {
		super();
		this.mno = mno;
		this.mname = mname;
		this.mid = mid;
		this.mpw = mpw;
		this.mbirth = mbirth;
		this.mphone = mphone;
		this.mmail = mmail;
		this.minsertdate = minsertdate;
		this.mupdatedate = mupdatedate;
		this.mdeleteyn = mdeleteyn;
	}
	
	// getter
	public String getMno() {
		return mno;
	}

	public String getMname() {
		return mname;
	}

	public String getMid() {
		return mid;
	}

	public String getMpw() {
		return mpw;
	}

	public Date getMbirth() {
		return mbirth;
	}

	public String getMphone() {
		return mphone;
	}

	public String getMmail() {
		return mmail;
	}

	public Date getMinsertdate() {
		return minsertdate;
	}

	public Date getMupdatedate() {
		return mupdatedate;
	}

	public String getMdeleteyn() {
		return mdeleteyn;
	}

	// setter
	public void setMno(String mno) {
		this.mno = mno;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public void setMpw(String mpw) {
		this.mpw = mpw;
	}

	public void setMbirth(Date mbirth) {
		this.mbirth = mbirth;
	}

	public void setMphone(String mphone) {
		this.mphone = mphone;
	}

	public void setMmail(String mmail) {
		this.mmail = mmail;
	}

	public void setMinsertdate(Date minsertdate) {
		this.minsertdate = minsertdate;
	}

	public void setMupdatedate(Date mupdatedate) {
		this.mupdatedate = mupdatedate;
	}

	public void setMdeleteyn(String mdeleteyn) {
		this.mdeleteyn = mdeleteyn;
	}
	
	
}
