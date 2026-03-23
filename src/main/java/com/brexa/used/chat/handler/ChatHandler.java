package com.brexa.used.chat.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList; // 필수!
import java.util.concurrent.ConcurrentHashMap;   // 필수!

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.brexa.used.chat.service.ChatService;
import com.brexa.used.chat.vo.ChatMsgVO;
import com.brexa.used.comm.Chaebun;
import com.google.gson.Gson;

public class ChatHandler extends TextWebSocketHandler {

    @Autowired
    private ChatService cservice;

    // 1. 전체 세션 리스트 (안전한 멀티태스킹용 리스트)
    private List<WebSocketSession> allSessions = new CopyOnWriteArrayList<WebSocketSession>();

    // 2. 방별 세션 맵 (제네릭 <> 를 확실하게 명시!)
    private Map<String, List<WebSocketSession>> roomSessionMap = new ConcurrentHashMap<String, List<WebSocketSession>>();

    // 3. JSON 변환용 객체
    private Gson gson = new Gson();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        allSessions.add(session); // 1. 일단 무조건 추가

        String query = session.getUri().getQuery();
        String roomNo = null;
        if (query != null && query.contains("roomNo=")) {
            roomNo = query.split("roomNo=")[1].split("&")[0];
        }

        if (roomNo != null) {
            session.getAttributes().put("roomNo", roomNo);
            
            // [수정] 빨간 줄 안 생기는 정석 로직
            List<WebSocketSession> sessions = roomSessionMap.get(roomNo);
            if (sessions == null) {
                // 방이 없으면 새로 만들기 (타입 명시!)
                sessions = new CopyOnWriteArrayList<WebSocketSession>();
                roomSessionMap.put(roomNo, sessions);
            }
            sessions.add(session);
        }

        System.out.println("★ 소켓 연결됨: " + session.getId() + " / roomNo: " + roomNo);
    }

 // ChatHandler.java의 handleTextMessage 부분
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        ChatMsgVO cvo = gson.fromJson(payload, ChatMsgVO.class);
        String roomNo = cvo.getRoomNo();

        // 1. 방 단위 세션 관리
        List<WebSocketSession> roomSessions = roomSessionMap.get(roomNo);
        if (roomSessions == null) {
            roomSessions = new CopyOnWriteArrayList<WebSocketSession>();
            roomSessionMap.put(roomNo, roomSessions);
        }
        if (!roomSessions.contains(session)) {
            roomSessions.add(session);
        }

        // 2. DB 저장 및 데이터 보정
        int maxno = cservice.msgMaxno();
        cvo.setCno(Chaebun.getChatMsg(maxno));
        cservice.insertChatMsg(cvo);

        // ★ 발신자 MID 조회
        String senderMid = cservice.selectMidByMno(cvo.getSenderMno());
        cvo.setSenderMid(senderMid);

        // 3. 메시지 전송
        String jsonMsg = gson.toJson(cvo);
        
        // A. 채팅방 안에 있는 사람들에게 전송 (채팅창 업데이트용)
        for (WebSocketSession s : roomSessions) {
            if (s != null && s.isOpen()) {
                s.sendMessage(new TextMessage(jsonMsg));
            }
        }

        // B. 전체 접속자 중 '채팅방 밖에 있는' 사람들에게만 전송 (목록 업데이트용)
        for (WebSocketSession s : allSessions) {
            if (s != null && s.isOpen()) {
                // 현재 채팅방 세션 리스트(roomSessions)에 포함되지 않은 사람에게만!
                if (!roomSessions.contains(s)) {
                    s.sendMessage(new TextMessage(jsonMsg));
                }
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        allSessions.remove(session);
        
        // 방별 맵에서도 제거
        for (List<WebSocketSession> sessions : roomSessionMap.values()) {
            sessions.remove(session);
        }
        System.out.println("★ 소켓 연결 종료: " + session.getId());
    }
}