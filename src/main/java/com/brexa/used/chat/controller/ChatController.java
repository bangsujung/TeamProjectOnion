package com.brexa.used.chat.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brexa.used.chat.service.ChatService;
import com.brexa.used.chat.vo.ChatMsgVO;
import com.brexa.used.chat.vo.ChatRoomVO;
import com.brexa.used.comm.Chaebun;

@Controller
@RequestMapping(value="/chat")
public class ChatController {

   @Autowired
   private ChatService cservice;

// 1. 내 채팅방 리스트 (파일명에 맞춰 /chat/chatList로 수정!)
   @RequestMapping(value="/list")
   public String chatList(String roomNo, HttpSession session, RedirectAttributes rattr, Model model) {
       if(!isValid(session)) {
           rattr.addFlashAttribute("msg", "NO_LOGIN");
           return "redirect:/login";
       }
       
       String mno = (String)session.getAttribute("mno");
       List<ChatRoomVO> cList = cservice.selectChatRoomList(mno);
       
    // ★ 추가: 상세페이지에서 넘어온 방 번호가 있다면 모델에 담기
       if(roomNo != null && !roomNo.isEmpty()) {
           model.addAttribute("roomNo", roomNo);
       } else {
           model.addAttribute("roomNo", ""); 
       }
       
       if(cList == null) {
           cList = new ArrayList<ChatRoomVO>(); // 빈 리스트를 만들어서 넘겨주는 게 안전합니다.
       }
       
       model.addAttribute("cList", cList);
       
       return "chat/chatList"; 
   }

   // 2. 채팅방 입장 및 내역 불러오기 (새로 추가된 메서드)
   @GetMapping(value="/room")
   public String chatRoom(String roomNo, Model model, HttpSession session) {
       System.out.println("ChatController chatRoom() 함수 진입 =======");
       System.out.println("roomNo >> " + roomNo);
       
       // 대화 내역 불러오기
       List<ChatMsgVO> msgList = cservice.selectChatMsgList(roomNo);
       System.out.println("msgList >> " + msgList);
       
       // 읽음 처리
       cservice.updateReadYN(roomNo);
       
       String mid = (String) session.getAttribute("mid");
       String mno = (String) session.getAttribute("mno"); // ← 추가!
       
       model.addAttribute("roomNo", roomNo);
       model.addAttribute("msgList", msgList);
       model.addAttribute("mid", mid);
       model.addAttribute("mno", mno); // ← 추가!
       
       return "chat/chatRoom";
   }

   // 채팅방 생성 및 입장 (상품 상세페이지에서 '채팅하기' 클릭 시)
   @PostMapping(value="/start", produces="text/plain;charset=UTF-8") // 한글 깨짐 방지!
   @ResponseBody // 비동기 Ajax 방식
   public String startChat(ChatRoomVO crvo, HttpSession session) {
      System.out.println("ChatController startChat() 함수 진입 =======");
      System.out.println("crvo >> " + crvo);
      
      if(!isValid(session)) {
         return "LOGIN_REQUIRED";
      }

      // 1. 기존 방 유무 확인
      ChatRoomVO cvo = cservice.checkChatRoom(crvo);
      System.out.println("checkChatRoom 결과 >> " + cvo);
      
      if (cvo != null) {
         // 이미 방이 있으면 해당 방 번호 반환
         return cvo.getRoomNo();
      } else {
         // 2. 방이 없으면 채번 후 생성
         int maxno = cservice.roomMaxno();
         String roomNo = Chaebun.getChatRoom(maxno);
         crvo.setRoomNo(roomNo);
         
         int res = cservice.insertChatRoom(crvo);
         System.out.println("insertChatRoom res >> " + res);
         
         return (res == 1) ? roomNo : "ERR";
      }
   }
   
   //읽음표시
   @PostMapping("/read")
   @ResponseBody
   public String markAsRead(String roomNo, HttpSession session) {
       String mno = (String)session.getAttribute("mno");
       // DB에서 해당 방(roomNo)의 수신자가 나(mno)인 메시지들을 'Y'로 업데이트
       cservice.updateReadCheck(roomNo, mno); 
       return "OK";
   }

   // 세션 유효성 검사 (MemberController 스타일 유지)
   public boolean isValid(HttpSession session) {
      String mno = (String)session.getAttribute("mno");
      String mid = (String)session.getAttribute("mid");
      String mname = (String)session.getAttribute("mname");
      
      return mno != null && mid != null && mname != null;
   }
   
}