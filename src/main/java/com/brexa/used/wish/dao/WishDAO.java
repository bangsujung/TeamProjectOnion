package com.brexa.used.wish.dao;

import java.util.List;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.vo.ItemVO;
import com.brexa.used.wish.vo.WishVO;

public interface WishDAO {
	public int wishWrite(WishVO wvo); // 위시 등록
	public int wishDelete(String wno); // 위시 삭제 (목록)
	public int wishCancel(WishVO wvo); // 위시 삭제 (상세페이지)
	public List<ItemVO> wishList(SearchCondition sc); // 위시 목록
	public int wishMaxno(); // 위시 채번 
	public int wishCheck(WishVO wvo); // 찜 중복 확인
	public int wishSelect(List<String> wnos); // 위시 목록 선택 (여러개 삭제)
}
