package com.brexa.used.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brexa.used.comm.Chaebun;
import com.brexa.used.comm.SearchCondition;
import com.brexa.used.member.dao.MemberDAO;
import com.brexa.used.member.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO mdao;

	@Override
	public int memberJoin(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberJoin 함수진입 >>>>");
		System.out.println("mvo >>>> " + mvo);
		
		// 1. 현재 최대 번호를 가져와서 +1 한 뒤 채번 생성
	    int maxno = mdao.memberMaxno();
	    String newMno = Chaebun.getMember(maxno + 1);
	    mvo.setMno(newMno);
	    
	    // 2. DB 저장
	    return mdao.memberJoin(mvo);
	}

	@Override
	public int memberUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberUpdate 함수진입 >>>>");
		System.out.println("mvo >>>> " + mvo);
		int res = mdao.memberUpdate(mvo);
		System.out.println("res >>>> " + res);
		return res;
	}

	@Override
	public int memberDelete(String mno) {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberDelete 함수진입 >>>>");
		System.out.println("mno >>>> " + mno);
		int res = mdao.memberDelete(mno);
		System.out.println("res >>>> " + res);
		return res;
	}

	@Override
	public List<MemberVO> memberList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberList 함수진입 >>>>");
		System.out.println("sc >>>> " + sc);
		List<MemberVO> mList = mdao.memberList(sc);
		System.out.println("mList >>>> " + mList);
		return mList;
	}

	@Override
	public MemberVO memberOne(String mno) {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberOne 함수진입 >>>>");
		System.out.println("mno >>>> " + mno);
		MemberVO mvo = mdao.memberOne(mno);
		System.out.println("mvo >>>> " + mvo);
		return mvo;
	}
	
	@Override
	public int memberMaxno() {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberMaxno 함수진입 >>>>");
		int res = mdao.memberMaxno();
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int idCheck(String mid) {
		// TODO Auto-generated method stub
		System.out.println("MemberService idCheck 함수진입 >>>>");
		System.out.println("mid >>>> " + mid);
		int idch = mdao.idCheck(mid);
		System.out.println("idch >>>> " + idch);
		return idch;
	}

	@Override
	public MemberVO login(String mid) {
		// TODO Auto-generated method stub
		System.out.println("MemberService login 함수진입 >>>>");
		System.out.println("mid >>>> " + mid);
		MemberVO mvo = mdao.login(mid);
		System.out.println("mvo >>>> " + mvo);
		return mvo;
	}

	@Override
	public String searchID(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberService searchID 함수진입 >>>>");
		System.out.println("mvo >>>> " + mvo);
		String mid = mdao.searchID(mvo);
		System.out.println("mid >>>> " + mid);
		return mid;
	}

	@Override
	public String searchPW(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberService searchPW 함수진입 >>>>");
		System.out.println("mvo >>>> " + mvo);
		String mid = mdao.searchPW(mvo);
		System.out.println("mid >>>> " + mid);
		return mid;
	}

	@Override
	public MemberVO selectID(String mid) {
		// TODO Auto-generated method stub
		System.out.println("MemberService selectID 함수진입 >>>>");
		System.out.println("mid >>>> " + mid);
		MemberVO mvo = mdao.selectID(mid);
		System.out.println("mvo >>>> " + mvo);
		return mvo;
	}

	@Override
	public int memberCnt(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("MemberService memberCnt 함수진입 >>>>");
		System.out.println("sc >>>> " + sc);
		int totalCnt = mdao.memberCnt(sc);
		System.out.println("totalCnt >>>> " + totalCnt);
		return totalCnt;
	}

	@Override
	public int pwUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberService pwUpdate 함수진입 >>>>");
		System.out.println("mvo >>>> " + mvo);
		int res = mdao.pwUpdate(mvo);
		System.out.println("res >>>> " + res);
		return res;
	}


}
