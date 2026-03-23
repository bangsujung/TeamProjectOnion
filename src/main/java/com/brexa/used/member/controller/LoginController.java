package com.brexa.used.member.controller;

import javax.servlet.http.HttpServletRequest;
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

import com.brexa.used.comm.EncryptUtils;
import com.brexa.used.member.service.MemberService;
import com.brexa.used.member.vo.MemberVO;

@Controller
public class LoginController {
	
	@Autowired
	private MemberService mservice; 
	
	@GetMapping(value="/login")
	public String logForm() {
		return "member/logForm";
	}
	
	@PostMapping(value="/login")
	public String login(@RequestParam String mid, String mpw, RedirectAttributes rattr, HttpServletRequest request) {
		System.out.println("LoginController login 함수 진입 --------------------");
		System.out.println("mid >>" + mid);
		System.out.println("mpw >>" + mpw);
		//회원정보 가져오기
	    MemberVO mvo = mservice.selectID(mid);
	      
	    //회원 존재 / 정지회원 확인
	    if(mvo != null && "S".equals(mvo.getMdeleteyn())) {
	       String msg = "BAN_MEMBER";
	       rattr.addFlashAttribute("msg", msg);
	       return "redirect:/login";
	    }
		if(!loginCheck(mid,mpw)) {
			//id 또는 pw 불일치 -> loginForm
			String msg = "LOG_ERR";
			rattr.addFlashAttribute("msg",msg);
			return "redirect:/login";
		}else {
			//login
			//세션 객체 불러오기 
			HttpSession session = request.getSession();
			//세션 객체에 데이텉 저장
			session.setAttribute("mno", mvo.getMno()); //눈에 보이지않지만 회원번호도 가지고다님
			session.setAttribute("mid", mvo.getMid());
			session.setAttribute("mname", mvo.getMname());
		}
		return "redirect:/";
	}
	
	private boolean loginCheck(String mid, String mpw) {
		System.out.println("LoginController login 함수 진입 --------------------");
		System.out.println("mid >>" + mid);
		System.out.println("mpw >>" + mpw);
		//id 와 pw 일치 확인
		MemberVO mvo = mservice.selectID(mid);
		System.out.println("mvo >>" + mvo);
		//mvo 데이터가 null 이면 일치하는 회원이 없음
		//조회된 mvo의 (암호화된)비번과 입력받아온 비번의 일치확인
		if (mvo != null && mvo.getMpw().equals(EncryptUtils.encryptMD5(mpw))) {
	        
	        // 추가된 조건: 탈퇴 여부 확인
	        if ("N".equals(mvo.getMdeleteyn())) {
	            System.out.println("로그인 실패: 탈퇴한 회원입니다. (" + mid + ")");
	            return false;
	        }
	        System.out.println("로그인 성공: " + mid);
	        return true;
	    }
	    return false;
	}
	
	@RequestMapping(value="/logout")
	public String logout(HttpSession session, RedirectAttributes rattr, Model model) {
		//세션 초기화
		session.invalidate();
		if(model.containsAttribute("msg")) {
			// Model에 담긴 내용 중 "msg"라는 키를 가진 값을 문자열로 추출
			String msg = (String)model.asMap().get("msg");
			//로그아웃 알림 메시지
		    rattr.addFlashAttribute("msg",msg);
		    return "redirect:/";
		}
		//홈으로 이동
		return "redirect:/";
	}
	
	@PostMapping(value="/pwConfirm")
	@ResponseBody
	public String pwConfirm(String mid, String mpw) {
		System.out.println("전달받은 PW: " + mpw);
		return String.valueOf(loginCheck(mid,mpw));
	}
}
