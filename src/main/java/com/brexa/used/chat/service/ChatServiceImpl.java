package com.brexa.used.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.brexa.used.chat.dao.ChatDAO;
import com.brexa.used.chat.vo.ChatMsgVO;
import com.brexa.used.chat.vo.ChatRoomVO;

@Service
public class ChatServiceImpl implements ChatService{
   @Autowired
   private ChatDAO cdao;

   // 방 목록
   @Override
   public List<ChatRoomVO> selectChatRoomList(String mno) {
      // TODO Auto-generated method stub
      System.out.println("ChatService selectChatRoomList() 함수 진입 ========");
      System.out.println("mno >> " + mno);
      List<ChatRoomVO> croomList = cdao.selectChatRoomList(mno);
      System.out.println("croomList >> " + croomList);
      return croomList;
   }
   
   // 방 중복 체크
   @Override
   public ChatRoomVO checkChatRoom(ChatRoomVO crvo) {
      // TODO Auto-generated method stub
      System.out.println("ChatService checkChatRoom() 함수 진입 ========");
      System.out.println("crvo >> " + crvo);
      ChatRoomVO croomvo = cdao.checkChatRoom(crvo);
      System.out.println("croomvo >> " + croomvo);
      return croomvo;
   }
   
   // 방 생성
   @Override
   public int insertChatRoom(ChatRoomVO crvo) {
      // TODO Auto-generated method stub
      System.out.println("ChatService insertChatRoom() 함수 진입 ========");
      System.out.println("crvo >> " + crvo);
      int res = cdao.insertChatRoom(crvo);
      System.out.println("res >> " + res);
      return res;
   }
   
   
   // 메세지 저장
   @Override
   public int insertChatMsg(ChatMsgVO cvo) {
      // TODO Auto-generated method stub
      System.out.println("ChatService insertChatMsg() 함수 진입 ========");
      System.out.println("cvo >> " + cvo);
      int res = cdao.insertChatMsg(cvo);
      System.out.println("res >> " + res);
      return res;
   }
   
   //대화 내역 불러오기
   @Override
   public List<ChatMsgVO> selectChatMsgList(String roomNo) {
      // TODO Auto-generated method stub
      System.out.println("ChatService selectChatMsgList() 함수 진입 ========");
      System.out.println("roomNo >> " + roomNo);
      List<ChatMsgVO> cmvo = cdao.selectChatMsgList(roomNo);
      System.out.println("cmvo >> " + cmvo);
      return cmvo;
   }
   
   // 읽음 처리
   @Override
   public int updateReadYN(String roomNo) {
      // TODO Auto-generated method stub
      System.out.println("ChatService updateReadYN() 함수 진입 ========");
      System.out.println("roomNo >> " + roomNo);
      int res = cdao.updateReadYN(roomNo);
      System.out.println("res >> " + res);
      return res;
   }
   
   //안읽은 메세지 개수
   @Override
   public int countUnreadMsg(String roomNo) {
      // TODO Auto-generated method stub
      System.out.println("ChatService countUnreadMsg() 함수 진입 ========");
      System.out.println("roomNo >> " + roomNo);
      int mcnt = cdao.countUnreadMsg(roomNo);
      System.out.println("mcnt >> " + mcnt);
      return mcnt;
   }

   @Override
   public int roomMaxno() {
      // TODO Auto-generated method stub
      System.out.println("ChatService roomMaxno() 함수 진입 =======");
      int rmaxno = cdao.roomMaxno();
      System.out.println("rmaxno >> " + rmaxno);
      return rmaxno;
   }

   @Override
   public int msgMaxno() {
      // TODO Auto-generated method stub
      System.out.println("ChatService msgMaxno() 함수 진입 =======");
      int cmaxno = cdao.msgMaxno();
      System.out.println("rmaxno >> " + cmaxno);
      return cmaxno;
   }
   
   @Override
   public int updateReadCheck(String roomNo, String mno) {
       // DAO(또는 Mapper)의 메서드를 호출할 때 값을 넘겨줍니다.
       System.out.println("ChatService updateReadCheck() 함수 진입 =======");
       System.out.println("roomNo >> " + roomNo + "  mno >> " + mno);
       int res = cdao.updateReadCheck(roomNo, mno);
       System.out.println("res >> " + res);
       return res;
   }

   //채팅방 상대 프로필을 아이디 첫글자로
   @Override
   public String selectMidByMno(String mno) {
      System.out.println("ChatService selectMidByMno() 함수 진입 =======");
       System.out.println("mno >> " + mno);
       String res = cdao.selectMidByMno(mno);
       System.out.println("res >> " + res);
       return res;
   }

   
}
