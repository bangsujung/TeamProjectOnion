package com.brexa.used.report.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brexa.used.comm.PageHandler;
import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.service.ItemService;
import com.brexa.used.member.service.MemberService;
import com.brexa.used.member.vo.MemberVO;
import com.brexa.used.report.service.ReportService;
import com.brexa.used.report.vo.ReportVO;

@Controller
@RequestMapping(value="/report")
public class ReportController {
	
	@Autowired
	private ReportService rservice;
	
	@Autowired
	private MemberService mservice;
	
	// 신고 등록 처리
	@PostMapping("/write")
	public String repoWrite(ReportVO rvo, String ino, String mid, RedirectAttributes rattr) {
		 System.out.println("ReportController repoWrite 함수 진입 >>>>");
         System.out.println("rvo >> " + rvo);
         
         // 만약 mno가 없고 아이디(mid)만 넘어왔다면 (마이페이지 신고)
         if (rvo.getMno() == null && mid != null && !mid.isEmpty()) {
             // mservice를 이용해서 아이디로 회원정보 조회
             MemberVO targetMvo = mservice.selectID(mid);
             
             if (targetMvo != null) {
                 rvo.setMno(targetMvo.getMno());  
             } else {
                 rattr.addFlashAttribute("msg", "REPO_ERR");
                 return "redirect:/member/mypage";
             }
         }

         int res = rservice.repoWrite(rvo);

         if (res >= 1) {
             rattr.addFlashAttribute("msg", "REPO_OK");
         } else {
             rattr.addFlashAttribute("msg", "REPO_ERR");
         }

         return (ino != null && !ino.isEmpty()) ? "redirect:/item/one?ino=" + ino : "redirect:/member/mypage";
     }
	
    //신고 목록
    @GetMapping("/list")
    public String reportList(SearchCondition sc, Model model, HttpSession session, RedirectAttributes rattr) {
       //1. 세션에서 로그인 정보 가져오기(로그인 시 'mid'라는 이름으로 아이디를 저장했다고 가정)
       String mid = (String) session.getAttribute("mid");
       //2. 관리자 체크(아이디가 manager000이 아니거나 로그인이 안 된 경우)
       if(mid == null || !mid.equals("manager000")) {
          rattr.addFlashAttribute("msg", "관리자만 접근 가능한 페이지입니다.");
          return "redirect:/"; //메인 페이지로 튕겨내기
      }
       /*
        * //3.페이지 번호 보정(로그에 page=0으로 찍히는 문제 해결) 
        * if(sc.getPage()==null ||
        * sc.getPage()<=0) { sc.setPage(1); }
        */
       //4. 서비스 호출
       //4-1. 전체 게시글 개수 조회
       int totalCnt = rservice.repoCnt(sc);
       //4-2. 페이징 계산을 위한 PageHandler 생성
       PageHandler ph = new PageHandler(totalCnt, sc);
       //4-3. 목록 데이터 조회
       List<ReportVO> list = rservice.repoList(sc);
      
       model.addAttribute("list", list);
       model.addAttribute("ph", ph);
      
       return "report/repoList"; //jsp 경로
    }
}
