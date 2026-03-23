package com.brexa.used.wish.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.vo.ItemVO;
import com.brexa.used.wish.vo.WishVO;

@Repository // 데이터베이스에 접근하는 파일
public class WishDAOImpl implements WishDAO{
	@Autowired
	private SqlSession session;
	private String namespace = "com.brexa.used.mapper.WishMapper.";
	
	@Override
	public int wishWrite(WishVO wvo) {
		// TODO Auto-generated method stub
		System.out.println("WishDAO wishWrite() 함수 진입 =======");
	    System.out.println("wvo >> " + wvo);
	    int res = session.insert(namespace + "wishWrite", wvo);
	    System.out.println("res >> " + res);
	    return res;
	}
	
	@Override
	public int wishMaxno() {
	    // TODO Auto-generated method stub
	    System.out.println("WishDAO wishMaxno() 함수 진입 =======");
	    int maxno = session.selectOne(namespace + "wishMaxno");
	    System.out.println("maxno >> " + maxno);
	    return maxno;
	 }
	
	@Override
	public int wishDelete(String wno) {
		// TODO Auto-generated method stub
		System.out.println("WishDAO wishDelete 함수 진입 >>>>");
		System.out.println("wvo >> " + wno);
		int res = session.delete(namespace+"wishDelete",wno);
		System.out.println("res >> " + res);
		return res;
	}
	
	@Override
	public int wishCancel(WishVO wvo) {
		// TODO Auto-generated method stub
		System.out.println("WishDAO wishCancel 함수 진입 >>>>");
		System.out.println("wvo >> " + wvo);
		int res = session.delete(namespace+"wishCancel",wvo);
		System.out.println("res >> " + res);
		return res;
	}
	
	@Override
	public List<ItemVO> wishList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("WishDAOImpl wishList() 함수 진입");
        System.out.println("sc >> " + sc);
        List<ItemVO> wList = session.selectList(namespace+"wishList", sc);
        System.out.println("wList >> "+wList);
        return wList;
	}

	@Override
	public int wishCheck(WishVO wvo) {
		// TODO Auto-generated method stub
		System.out.println("WishDAO wishCheck 함수 진입 >>>>");
		System.out.println("wvo >> " + wvo);
		int res = session.selectOne(namespace+"wishCheck",wvo);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int wishSelect(List<String> wnos) {
		// TODO Auto-generated method stub
		System.out.println("WishDAO wishSelect 함수 진입 >>>>");
		System.out.println("wnos >> " + wnos);
		int res = session.delete(namespace+"wishSelect",wnos);
		System.out.println("res >> " + res);
		return res;
	}

}
