package com.brexa.used.member.dao;

import java.util.List;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.member.vo.MemberVO;

public interface MemberDAO {
	public int memberJoin(MemberVO mvo);  // 회원 가입
    public int memberUpdate(MemberVO mvo); // 회원 수정
    public int memberDelete(String mno); // 회원 삭제
    public List<MemberVO> memberList(SearchCondition sc); // 회원 목록
    public MemberVO memberOne(String mno); // 회원 상세조회
	public int memberMaxno(); // 채번
	public int idCheck(String mid); // 아이디 중복확인
    public MemberVO login(String mid); // 로그인
    public String searchID(MemberVO mvo); // 아이디 찾기 
    public String searchPW(MemberVO mvo); // 비밀번호 찾기
    public MemberVO selectID(String mid); // 로그인 체크
    public int memberCnt(SearchCondition sc); // 전체 회원수
    public int pwUpdate(MemberVO mvo); // 임시 비밀번호
}
