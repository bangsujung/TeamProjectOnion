package com.brexa.used.wish.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brexa.used.comm.Chaebun;
import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.service.ItemService;
import com.brexa.used.item.vo.ItemVO;
import com.brexa.used.wish.service.WishService;
import com.brexa.used.wish.vo.WishVO;

@Controller
@RequestMapping(value="/wish")
public class WishController {
	@Autowired
	private WishService wservice;
	
	//찜 등록
	@PostMapping(value="/write")
	@ResponseBody
	public String wishWrite(WishVO wvo, HttpSession session) {
	    System.out.println("WishController wishWrite() 함수 진입 =======");
	    System.out.println("wvo >> " + wvo);
	    
	    // 세션에서 직접 mno 가져오기 (JSP에서 넘어온 값 대신)
	    String mno = (String) session.getAttribute("mno");
	    if (mno == null) {
	        return "LOGIN_RE";
	    }
	    wvo.setMno(mno);
	    
	    // 중복 체크
	    int dupCheck = wservice.wishCheck(wvo);
	    if (dupCheck > 0) {
	        return "2"; // 이미 찜한 상품
	    }
	    
	    // 채번
	    int maxno = wservice.wishMaxno();
	    String wno = Chaebun.getWish(maxno);
	    wvo.setWno(wno);

	    int res = wservice.wishWrite(wvo);
	    System.out.println("res >> " + res);

	    return String.valueOf(res);
	}
    
	// 1. 위시 목록에서 삭제 
    @PostMapping(value="/del")
    public String wishDelete(String wno, RedirectAttributes rattr) {
        System.out.println("WishController wishDelete 진입 (목록 삭제) 함수 진입 >>>>");
        System.out.println("wno >> " + wno);
        

        int res = wservice.wishDelete(wno);

        if(res == 1) {
            rattr.addFlashAttribute("msg", "WISH_DEL_OK");
        } else {
            rattr.addFlashAttribute("msg", "WISH_DEL_ERR");
        }
        return "redirect:/wish/list"; // 삭제 후 목록으로 이동
    }

    // 2. 상품 상세페이지에서 삭제
    @PostMapping(value="/cancel")
    @ResponseBody 
    public String wishCancel(String ino, HttpSession session) {
        System.out.println("WishController wishCancel 진입 (상세페이지 취소) 함수 진입 >>>>");
        
        String mno = (String) session.getAttribute("mno"); 
        if(mno == null) {
        	return "LOGIN_RE";
        }

        WishVO wvo = new WishVO();
        wvo.setIno(ino);
        wvo.setMno(mno);

        int res = wservice.wishCancel(wvo); 

        if (res == 1) {
            return "OK";
        } else {
            return "ERR";
        }
    }
    
    //찜 목록
    @GetMapping(value="/list")
    public String wishList(HttpSession session, SearchCondition sc, Model model) {
       System.out.println("WishController wishList() 함수진입 >>>>");
       System.out.println("sc >> "+sc);
       String mno = (String) session.getAttribute("mno");
       sc.setKeyword(mno);
       List<ItemVO> wList = wservice.wishList(sc);
       System.out.println("wList >> "+wList);
       model.addAttribute("wList", wList);
       model.addAttribute("sc",sc);
       return "wish/wishList";
    }
    
    // 찜 목록 선택
    @PostMapping(value="/delSelect")
    @ResponseBody
    public String wishSelect(@RequestParam(value="wnos") List<String> wnos) { 
        System.out.println("WishController wishlSelect() 함수진입 >>>>"); 
        System.out.println("wnos >> " + wnos);

        int res = wservice.wishSelect(wnos);
        return (res > 0) ? "OK" : "ERR";
    }
}
