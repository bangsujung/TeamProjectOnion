package com.brexa.used.wish.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.dao.ItemDAO;
import com.brexa.used.item.vo.ItemVO;
import com.brexa.used.wish.dao.WishDAO;
import com.brexa.used.wish.vo.WishVO;

@Service
public class WishServiceImpl implements WishService{
	@Autowired
	private WishDAO wdao;

	@Override
	public int wishWrite(WishVO wvo) {
		// TODO Auto-generated method stub
		System.out.println("WishDAO wishWrite() 함수 진입 =======");
	    System.out.println("wvo >> " + wvo);
	    int res = wdao.wishWrite(wvo);
	    System.out.println("res >> " + res);
	    return res;
	}
	
	@Override
    public int wishMaxno() {
       // TODO Auto-generated method stub
       System.out.println("WishService wishMaxno() 함수 진입 =======");
       int maxno = wdao.wishMaxno();
       System.out.println("maxno >> " + maxno);
       return maxno;
    }

	@Override
	public int wishDelete(String wno) {
		// TODO Auto-generated method stub
		System.out.println("WishService WishDelete() 함수 진입");
	    System.out.println("wno >> " + wno);
	    int res = wdao.wishDelete(wno);
	    System.out.println("res >> " + res);
		return res;
	}
	
	@Override
	public int wishCancel(WishVO wvo) {
		// TODO Auto-generated method stub
		System.out.println("WishService WishCancel() 함수 진입");
	    System.out.println("wvo >> " + wvo);
	    int res = wdao.wishCancel(wvo);
	    System.out.println("res >> " + res);
		return res;
	}

	@Override
	public List<ItemVO> wishList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("WishServiceImpl wishList() 함수 진입");
	    System.out.println("sc >> " + sc);
	    List<ItemVO> wList = wdao.wishList(sc);
	    System.out.println("wList >> "+wList);
	    return wList;
	}

	@Override
	public int wishCheck(WishVO wvo) {
		// TODO Auto-generated method stub
		System.out.println("WishService wishCheck() 함수 진입");
	    System.out.println("wvo >> " + wvo);
	    int res = wdao.wishCheck(wvo);
	    System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int wishSelect(List<String> wnos) {
		// TODO Auto-generated method stub
		System.out.println("WishService wishSelect() 함수 진입");
	    System.out.println("wnos >> " + wnos);
	    int res = wdao.wishSelect(wnos);
	    System.out.println("res >> " + res);
		return res;
	}

}
