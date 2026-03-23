package com.brexa.used.member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brexa.used.comm.Chaebun;
import com.brexa.used.comm.EncryptUtils;
import com.brexa.used.comm.PageHandler;
import com.brexa.used.comm.PasswordUtil;
import com.brexa.used.comm.SearchCondition;
import com.brexa.used.member.service.MemberService;
import com.brexa.used.member.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
    private MemberService mservice; 
	
	@GetMapping(value="/form")
	public String memberForm(HttpSession session, Model model) {
	    System.out.println("MemberController memberForm 함수진입----------------");
	    //회원객체 초기화(세션에 저장된 회원정보가 있으면 저장)
	    MemberVO mvo = null;
	    if(isValid(session)) {
	    	//회원정보 있는 상태
	    	//회원의 전체 정보 조회
	    	mvo = mservice.selectID((String)session.getAttribute("mid"));
	    }
	    model.addAttribute("mvo",mvo);
	    return "/member/form"; 
	}
	
	@RequestMapping(value="/join")
	public String memberJoin(@ModelAttribute MemberVO mvo, RedirectAttributes rattr) {
	    System.out.println("MemberController memberJoin 함수진입----------------");
	    
	    // 1. 비밀번호 암호화 
	    if (mvo.getMpw() != null && !mvo.getMpw().isEmpty()) {
	        mvo.setMpw(EncryptUtils.encryptMD5(mvo.getMpw())); 
	        System.out.println("암호화된 비밀번호 확인 >> " + mvo.getMpw());
	    }

	    // 2. 가입 시 상태값은 'Y'(정상회원)
	    mvo.setMdeleteyn("Y"); 

	    // 3. 채번 로직
//	    int maxno = mservice.memberMaxno();
//	    String mno = Chaebun.getMember(maxno);
//	    System.out.println("생성된 회원번호(mno) >> " + mno);
//	    mvo.setMno(mno);
	      
	    // 4. DB 저장
	    int res = mservice.memberJoin(mvo);
	    if(res != 1) {
	        rattr.addFlashAttribute("msg", "M_JOIN_ERR");
	        return "redirect:/member/form";
	    }
	    
	    rattr.addFlashAttribute("msg", "M_JOIN_SUC");
	    return "redirect:/";
	}
	
	@PostMapping(value="/idChk")
	@ResponseBody
	public String idCheck(@RequestParam("mid") String mid) {
		System.out.println("MemberController idCheck 함수진입----------------");
		System.out.println("mid >> " + mid);
		int cnt = mservice.idCheck(mid);
		return String.valueOf(cnt);

	}
	
	@PostMapping(value="/up")
	public String memberUpdate(@ModelAttribute MemberVO mvo, RedirectAttributes rattr) {
		System.out.println("MemberController memberUpdate 함수진입----------------");
		System.out.println("mvo >> " + mvo);
		//만약 비밀번호가 넘어온다면 암호화 처리 (회원 수정 시 비밀번호 필드가 비어있지 않은 경우)
	    if(mvo.getMpw() != null && !mvo.getMpw().isEmpty()) {
	    	// 수정할 비밀번호가 입력되었다면 다시 MD5로 암호화해서 저장
	        mvo.setMpw(EncryptUtils.encryptMD5(mvo.getMpw()));
	    }
		//서비스 호출
		int res = mservice.memberUpdate(mvo);
		System.out.println("res >> " + res);
		//삼항연산자를 사용하여 메세지 코드 저장
		String msg = (res == 1) ? "M_UP_SUC" : "M_UP_ERR";
		rattr.addFlashAttribute("msg",msg);
		//수정완료 또는 수정 실패시 수정화면으로 이동
		return "redirect:/member/form";
	}
	
	@RequestMapping(value="/mypage")
	public String mypage(HttpSession session, RedirectAttributes rattr) {
		System.out.println("MemberController mypage 함수진입----------------");
		if(!isValid(session)) {
			//비로그인 상태
			String msg = "NO_LOGIN";
			rattr.addFlashAttribute("msg",msg);
			return "redirect:/login";
		}
		return "/member/mypage";
	}
	
	@PostMapping(value="/del")
	public String memberDelete(@RequestParam String mno, HttpSession session, RedirectAttributes rattr) {
		System.out.println("MemberController memberDelete 함수진입----------------");
		System.out.println("mno >> " + mno);
		
		int res = mservice.memberDelete(mno);
		System.out.println("res >> " + res);
		
		if(res != 1) {
			String msg = "M_DEL_ERR";
			rattr.addFlashAttribute("msg",msg);
			return "redirect:/member/mypage";
		}else {
			session.invalidate();
			String msg = "M_DEL_SUC";
			rattr.addFlashAttribute("msg",msg);
			return "redirect:/";
		}
		
	}
	
	@RequestMapping(value="list")
	public String memberList(SearchCondition sc, Model model, HttpSession session, RedirectAttributes rattr) {
		System.out.println("MemberController memberList 함수진입----------------");
		System.out.println("sc >> " + sc);
		
		if(!isValid(session)) {
	        String msg = "M_LST_LNK_ERR";
	        rattr.addFlashAttribute("msg",msg);
	        return "redirect:/login";
	     }
	      
	    int totalCnt = mservice.memberCnt(sc); // 총 회원수
	    PageHandler ph = new PageHandler(totalCnt, sc); // 페이징
		
		// 1. 서비스에서 회원목록 조회
		List<MemberVO> mList = mservice.memberList(sc);
		System.out.println("mList >> " + mList);
		
		// 2. 리스트가 비어있거나 null인 경우 처리
		if(mList == null || mList.isEmpty()) {
			String msg = "M_LST_ERR";
			rattr.addFlashAttribute("msg",msg);
			return "redirect:/member/mypage";
		}
		
		// 3. 데이터가 있을 경우 모델에 담아 jsp로 이동
		model.addAttribute("mList",mList);
		model.addAttribute("ph",ph);
		return "/member/list";
	}
	
	@RequestMapping(value="one")
	public String memberOne(String mno, RedirectAttributes rattr, Model model) {
		System.out.println("MemberController memberOne 함수 진입----------------");
		System.out.println("mno >> " + mno);
		if(mno == null || mno == "") {
	        String msg ="M_ONE_LNK_ERR";
	        rattr.addFlashAttribute("msg",msg);
	        return "redirect:/member/mypage";
	    }
		MemberVO mvo = mservice.memberOne(mno);
		System.out.println("mvo >> " + mvo);
		if(mvo == null) {
	        String msg = "M_ONE_ERR";
	        rattr.addFlashAttribute("msg",msg);
	        return "redirect:/member/list";
	    }
	    model.addAttribute("mvo",mvo);
	    return "/member/one";
	}
	
	@PostMapping(value="searchID")
	@ResponseBody
	public String searchID(MemberVO mvo) {
		System.out.println("MemberController searchID 함수 진입----------------");
		System.out.println("mvo >> " + mvo);
		String mid = mservice.searchID(mvo);
		System.out.println("mid >> " + mid);
		return mid;
	}
	
	@PostMapping(value="searchPW")
	@ResponseBody
	public String searchPW(MemberVO mvo) {
		System.out.println("MemberController searchPW 함수 진입----------------");
		System.out.println("mvo >> " + mvo);
		String mid = mservice.searchPW(mvo);
		System.out.println("mid >> " + mid);
		if(!mid.equals(mvo.getMid())) {
			return null; // 일치한 회원을 못찾음
		}
		// 임시 비밀번호 생성
		String tpw = PasswordUtil.makeTempPassword();
		System.out.println("tpw >> " + tpw);
		
		// 비밀번호 암호화
		String mpw = EncryptUtils.encryptMD5(tpw);
		System.out.println("mpw >> " + mpw);
		mvo.setMpw(mpw);
		
		// DB 비밀번호 저장
		int res = mservice.pwUpdate(mvo);
		System.out.println("res >> " + res);
		if(res != 1) {
			// DB 처리 중 에러 발생 시
			return null;
		}
		// 사용자 임시비번 전송
		return tpw;
	}
	
	@RequestMapping("/member/mypage")
	public String mypage(HttpSession session, RedirectAttributes rattr, Model model) {
		System.out.println("MemberController mypage 함수 진입----------------");

	    String mid = (String) session.getAttribute("mid");
	    
	    if (mid == null) {
	        return "redirect:/login";
	    }
	    
	    // DB에서 최신 회원 정보 가져오기 (신고 횟수 포함)
	    MemberVO mvo = mservice.selectID(mid);
	    model.addAttribute("mvo", mvo); 
	    
	    return "member/mypage";
	}
	
	//세션에 저장된 회원정보 유무확인
    private boolean isValid(HttpSession session) {
    	String mno = (String)session.getAttribute("mno");
    	String mid = (String)session.getAttribute("mid");
    	String mname = (String)session.getAttribute("mname");
    	System.out.println("mno >> " + mno);
    	return mno != null && mid != null && mname != null;
    }

}
