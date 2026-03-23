package com.brexa.used.item.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.vo.ItemVO;

@Repository // 데이터베이스에 접근하는 파일
public class ItemDAOImpl implements ItemDAO{
	@Autowired
	private SqlSession session;
	private String namespace = "com.brexa.used.mapper.ItemMapper.";
	
	@Override
	public int itemWrite(ItemVO ivo) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemWrite 함수 진입 >>>>");
		System.out.println("ivo >> " + ivo);
		int res = session.insert(namespace+"itemWrite",ivo);
		System.out.println("res >> " + res);
		return res;
	}
	@Override
	public int itemUpdate(ItemVO ivo) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemUpdate 함수 진입 >>>>");
		System.out.println("ivo >> " + ivo);
		int res = session.update(namespace + "itemUpdate", ivo);
	    System.out.println("res >> " + res);
	    return res;
	}
	@Override
	public int itemDelete(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemDelete 함수 진입 >>>>");
		System.out.println("ino >> " + ino);
		int res = session.update(namespace+"itemDelete", ino);
	    System.out.println("res >> "+res);
	    return res;
	}
	@Override
	public List<ItemVO> itemList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemList 함수 진입 >>>>");
		System.out.println("sc >> " + sc);
		List<ItemVO> iList = session.selectList(namespace + "itemList", sc);
	    System.out.println("iList >> " + iList);
	    return iList;
	}
	@Override
	public List<ItemVO> itemOne(String ino) {
		// TODO Auto-generated method stub
		 System.out.println("ItemDAO itemOne() 함수 진입 =======");
	     System.out.println("ino >> " + ino);
	     List<ItemVO> iList = session.selectList(namespace + "itemOne", ino);
	     System.out.println("iList >> " + iList);
	     return iList;
	}
	@Override
	public int itemMaxno() {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemMaxno 함수진입 >>>>");
		int maxno = session.selectOne(namespace+"itemMaxno");
		System.out.println("maxno >> " + maxno);
		return maxno;
	}
	@Override
	public int itemCnt(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemCnt 함수 진입 >>>>");
		System.out.println("ino >> " + ino);
		int res = session.update(namespace + "itemCnt", ino);
	    System.out.println("res >> " + res);
	    return res;
	}
	@Override
	public int itemCount(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemCount 함수 진입 >>>>");
		System.out.println("sc >> " + sc);
		int cnt = session.selectOne(namespace + "itemCount", sc);
	    System.out.println("cnt >> " + cnt);
	    return cnt;
	}
//	@Override
//	public List<ItemVO> itemSearch(SearchCondition sc) {
//		// TODO Auto-generated method stub
//		System.out.println("ItemDAO itemSearch 함수 진입 >>>>");
//		System.out.println("sc >> " + sc);
//		return null;
//	}
	@Override
	public int report(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO report 함수 진입 >>>>");
		System.out.println("ino >> " + ino);
		return 0;
	}
	@Override
	public int itemLike(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO itemLike 함수 진입 >>>>");
		System.out.println("ino >> " + ino);
		return 0;
	}
	@Override
	public List<ItemVO> myItemList(String iid) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAO myItemList 함수 진입 >>>>");
		System.out.println("iid >> " + iid);
		return null;
	}
	@Override
	public String pkChk(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemDAOImpl pkChk() 함수 진입");
	    System.out.println("ino >> " + ino);
	    String pw = session.selectOne(namespace+"pkChk", ino);
	    System.out.println("pw >> "+pw);
	    return pw;
	}

}
