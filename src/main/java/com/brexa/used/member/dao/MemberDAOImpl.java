package com.brexa.used.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.member.vo.MemberVO;

@Repository // 데이터베이스에 접근하는 파일
public class MemberDAOImpl implements MemberDAO{
	@Autowired
	private SqlSession session;
	private String namespace = "com.brexa.used.mapper.MemberMapper.";
	
	@Override
	public int memberJoin(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberJoin 함수진입 >>>>");
		System.out.println("mvo >> " + mvo);
		int res = session.insert(namespace+"memberJoin",mvo);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int memberUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberUpdate 함수진입 >>>>");
		System.out.println("mvo >> " + mvo);
		int res = session.update(namespace+"memberUpdate",mvo);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int memberDelete(String mno) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberDelete 함수진입 >>>>");
		System.out.println("mno >> " + mno);
		int res = session.update(namespace+"memberDelete",mno);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public List<MemberVO> memberList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberList 함수진입 >>>>");
		System.out.println("sc >> " + sc);
		List<MemberVO> mList = session.selectList(namespace+"memberList",sc);
		System.out.println("mList >> " + mList);
		return mList;
	}

	@Override
	public MemberVO memberOne(String mno) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberOne 함수진입 >>>>");
		System.out.println("mno >> " + mno);
		MemberVO mvo = session.selectOne(namespace+"memberOne",mno);
		System.out.println("mvo >> " + mvo);
		return mvo;
	}

	@Override
	public int memberMaxno() {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberMaxno 함수진입 >>>>");
		int maxno = session.selectOne(namespace+"maxno");
		System.out.println("maxno >> " + maxno);
		return maxno;
	}
	
	@Override
	public int idCheck(String mid) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO idCheck 함수진입 >>>>");
		System.out.println("mid >> " + mid);
		int idch = session.selectOne(namespace+"idCheck",mid);
		System.out.println("idch >> " + idch);
		return idch;
	}
	
	@Override
	public MemberVO login(String mid) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO login 함수진입 >>>>");
		System.out.println("mid >> " + mid);
		MemberVO mvo = session.selectOne(namespace+"login",mid);
		System.out.println("mvo >> " + mvo);
		return mvo;
	}

	@Override
	public String searchID(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO searchID 함수진입 >>>>");
		System.out.println("mvo >> " + mvo);
		String mid = session.selectOne(namespace+"searchID",mvo);
		System.out.println("mid >> " + mid);
		return mid;
	}

	@Override
	public String searchPW(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO searchPW 함수진입 >>>>");
		System.out.println("mvo >> " + mvo);
		String mid = session.selectOne(namespace+"searchPW",mvo);
		System.out.println("mid >> " + mid);
		return mid;
	}

	@Override
	public MemberVO selectID(String mid) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO selectID 함수진입 >>>>");
		System.out.println("mid >> " + mid);
		MemberVO mvo = session.selectOne(namespace+"selectID",mid);
		System.out.println("mvo >> " + mvo);
		return mvo;
	}

	@Override
	public int memberCnt(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO memberCnt 함수진입 >>>>");
		System.out.println("sc >> " + sc);
		int totalCnt = session.selectOne(namespace+"memberCnt",sc);
		System.out.println("memberCnt >> " + totalCnt);
		return totalCnt;
	}

	@Override
	public int pwUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		System.out.println("MemberDAO pwUpdate 함수진입 >>>>");
		System.out.println("mvo >> " + mvo);
		int res = session.update(namespace+"pwUpdate",mvo);
		System.out.println("res >> " + res);
		return res;
	}


}
