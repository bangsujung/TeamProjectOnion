package com.brexa.used.chat.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.brexa.used.chat.vo.ChatMsgVO;
import com.brexa.used.chat.vo.ChatRoomVO;

@Repository
public class ChatDAOImpl implements ChatDAO{
   @Autowired
   private SqlSession session;
   private String namespace = "com.brexa.used.mapper.ChatMapper.";
   
   // 방 목록
   @Override
   public List<ChatRoomVO> selectChatRoomList(String mno) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO selectChatRoomList() 함수 진입 ========");
      System.out.println("mno >> " + mno);
      List<ChatRoomVO> croomList = session.selectList(namespace + "selectChatRoomList", mno);
      System.out.println("croomList >> " + croomList);
      return croomList;
   }
   
   // 방 중복 체크
   @Override
   public ChatRoomVO checkChatRoom(ChatRoomVO crvo) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO checkChatRoom() 함수 진입 ========");
      System.out.println("crvo >> " + crvo);
      ChatRoomVO croomvo = session.selectOne(namespace + "checkChatRoom", crvo);
      System.out.println("croomvo >> " + croomvo);
      return croomvo;
   }
   
   // 방 생성
   @Override
   public int insertChatRoom(ChatRoomVO crvo) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO insertChatRoom() 함수 진입 ========");
      System.out.println("crvo >> " + crvo);
      int res = session.insert(namespace + "insertChatRoom", crvo);
      System.out.println("res >> " + res);
      return res;
   }
   
   
   // 메세지 저장
   @Override
   public int insertChatMsg(ChatMsgVO cvo) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO insertChatMsg() 함수 진입 ========");
      System.out.println("cvo >> " + cvo);
      int res = session.insert(namespace + "insertChatMsg", cvo);
      System.out.println("res >> " + res);
      return res;
   }
   
   //대화 내역 불러오기
   @Override
   public List<ChatMsgVO> selectChatMsgList(String roomNo) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO selectChatMsgList() 함수 진입 ========");
      System.out.println("roomNo >> " + roomNo);
      List<ChatMsgVO> cmvo = session.selectList(namespace + "selectChatMsgList", roomNo);
      System.out.println("cmvo >> " + cmvo);
      return cmvo;
   }
   
   // 읽음 처리
   @Override
   public int updateReadYN(String roomNo) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO updateReadYN() 함수 진입 ========");
      System.out.println("roomNo >> " + roomNo);
      int res = session.update(namespace + "updateReadYN", roomNo);
      System.out.println("res >> " + res);
      return res;
   }
   
   //안읽은 메세지 개수
   @Override
   public int countUnreadMsg(String roomNo) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO countUnreadMsg() 함수 진입 ========");
      System.out.println("roomNo >> " + roomNo);
      int mcnt = session.selectOne(namespace + "countUnreadMsg", roomNo);
      System.out.println("mcnt >> " + mcnt);
      return mcnt;
   }

   @Override
   public int roomMaxno() {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO roomMaxno() 함수 진입 =======");
      int rmaxno = session.selectOne(namespace + "roomMaxno");
      System.out.println("rmaxno >> " + rmaxno);
      return rmaxno;
   }

   @Override
   public int msgMaxno() {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO msgMaxno() 함수 진입 =======");
      int cmaxno = session.selectOne(namespace + "msgMaxno");
      System.out.println("rmaxno >> " + cmaxno);
      return cmaxno;
   }

   @Override
   public int updateReadCheck(String roomNo, String mno) {
      // TODO Auto-generated method stub
      System.out.println("ChatDAO updateReadCheck() 함수 진입 =======");
       System.out.println("roomNo >> " + roomNo + "  mno >> " + mno);
       
       // 1. 파라미터가 2개 이상일 때는 Map에 담아서 보냅니다.
       Map<String, Object> map = new HashMap<String, Object>();
       map.put("roomNo", roomNo);
       map.put("mno", mno);
       
       // 2. 업데이트 쿼리이므로 selectOne이 아니라 update를 써야 합니다.
       // 리턴값은 '업데이트된 행의 개수'입니다.
       int res = session.update(namespace + "updateReadCheck", map);
       
       return res;
   }

   //채팅방 상대 프로필을 아이디 첫글자로
   @Override
   public String selectMidByMno(String mno) {
       System.out.println("ChatDAO selectMidByMno() 함수 진입 =======");
       System.out.println("mno >> " + mno);
       String mid = session.selectOne(namespace + "selectMidByMno", mno);
       System.out.println("mid >> " + mid);
       return mid;
   }


}
