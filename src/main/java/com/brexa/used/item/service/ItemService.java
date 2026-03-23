package com.brexa.used.item.service;

import java.util.List;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.vo.ItemVO;

public interface ItemService {
	// 상품관리
	public int itemWrite(ItemVO ivo); // 상품 등록 (원본/저장용 사진 매칭)
	public int itemUpdate(ItemVO ivo); // 상품 수정
	public int itemDelete(String ino); // 상품 삭제
	
	// 상품조회
	public List<ItemVO> itemList(SearchCondition sc); // 상품 목록 (페이징/검색 포함)
	public List<ItemVO> itemOne(String ino); // 상품 상세조회
	public int itemMaxno(); // 상품 채번
	
	// 기능 및 통계
	public int itemCnt(String ino); // 조회수 증가
	public int itemCount(SearchCondition sc); // 전체 상품 수 
	//public List<ItemVO> itemSearch(SearchCondition sc); // 상품 검색 목록
	
	// 특화 기능
	public int report(String ino); // 사기 신고 (신고 횟수 누적)
	public int itemLike(String ino); // 찜하기 (관심상품 등록)
	public List<ItemVO> myItemList(String iid); // 내 글 보기 (내가 올린 상품 목록)
	
	public String pkChk(String ino); // 비밀번호 확인
}
