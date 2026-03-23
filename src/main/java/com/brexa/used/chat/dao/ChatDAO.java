package com.brexa.used.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.brexa.used.chat.vo.ChatRoomVO;
import com.brexa.used.chat.vo.ChatMsgVO;

public interface ChatDAO {
    
    /* --- 채팅방 관련 --- */
    public List<ChatRoomVO> selectChatRoomList(String mno); // 내 방 목록
    public ChatRoomVO checkChatRoom(ChatRoomVO crvo);        // 방 중복 체크
    public int insertChatRoom(ChatRoomVO crvo);              // 방 생성

    /* --- 메시지 관련 --- */
    public int insertChatMsg(ChatMsgVO cvo);                // 메시지 저장
    public List<ChatMsgVO> selectChatMsgList(String roomNo); // 대화 내역 불러오기
    public int updateReadYN(String roomNo);                 // 읽음 처리
    
    public int countUnreadMsg(String roomNo);           // 안읽은 메시지 개수
    
    public int roomMaxno(); // 채팅방 채번
    public int msgMaxno(); // 채팅 채번
    
    // roomNo와 mno 두 개의 인자를 넘기기 위해 @Param 사용
    public int updateReadCheck(@Param("roomNo") String roomNo, @Param("mno") String mno);
    
    //채팅방 상대 프로필을 아이디 첫글자로
    public String selectMidByMno(String mno); // ★ 추가
}