package com.brexa.used.item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.dao.ItemDAO;
import com.brexa.used.item.vo.ItemVO;

@Service
public class ItemServiceImpl implements ItemService{
	@Autowired
	private ItemDAO idao;

	@Override
	public int itemWrite(ItemVO ivo) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemWrite 함수 진입 =======");
		System.out.println("ivo >> " + ivo);
		int res = idao.itemWrite(ivo);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int itemUpdate(ItemVO ivo) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemUpdate() 함수 진입 =======");
		System.out.println("ivo >> " + ivo);
		int res = idao.itemUpdate(ivo);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int itemDelete(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemDelete() 함수 진입 =======");
	    System.out.println("ino >> " + ino);
	    int res = idao.itemDelete(ino);
	    System.out.println("res >> "+res);
	    return res;
	}

	@Override
	public List<ItemVO> itemList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemList() 함수 진입 =======");
	    System.out.println("sc >> " + sc);
	    List<ItemVO> iList = idao.itemList(sc);
	    System.out.println("iList >> " + iList);
	    return iList;
	}

	@Override
	public List<ItemVO> itemOne(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemOne() 함수 진입 =======");
	    System.out.println("ino >> " + ino);
	    List<ItemVO> iList = idao.itemOne(ino);
	    System.out.println("iList >> " + iList);
	    return iList;
	}

	@Override
	public int itemMaxno() {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemMaxno 함수진입 =======");
		int res = idao.itemMaxno();
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int itemCnt(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemCnt() 함수 진입 =======");
	    System.out.println("ino >> " + ino);
	    int res = idao.itemCnt(ino);
	    System.out.println("res >> " + res);
	    return res;
	}

	@Override
	public int itemCount(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ItemService itemCount() 함수 진입 =======");
	    System.out.println("sc >> " + sc);
	    int cnt = idao.itemCount(sc);
	    System.out.println("cnt >> " + cnt);
	    return cnt;
	}

//	@Override
//	public List<ItemVO> itemSearch(SearchCondition sc) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public int report(String ino) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int itemLike(String ino) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ItemVO> myItemList(String iid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String pkChk(String ino) {
		// TODO Auto-generated method stub
		System.out.println("ItemServiceImpl pkChk() 함수 진입 =======");
        System.out.println("ino >> " + ino);
        String pw = idao.pkChk(ino);
        System.out.println("pw >> "+pw);
        return pw;
	}
}
