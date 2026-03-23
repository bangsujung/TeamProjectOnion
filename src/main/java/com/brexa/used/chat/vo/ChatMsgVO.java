package com.brexa.used.chat.vo;

public class ChatMsgVO {
    private String cno;       // 메시지 번호 (CNO)
    private String roomNo;    // 방 번호 (ROOM_NO)
    private String senderMno; // 보낸 사람 번호 (SENDER_MNO)
    private String senderMid; // ★ 추가
    private String content;   // 대화 내용 (CONTENT)
    private String cdate;     // 보낸 시간 (CDATE)
    private String readyn;    // 읽음 여부 (READYN) Y/N
    
   public ChatMsgVO() {
      super();
   }

   public ChatMsgVO(String cno, String roomNo, String senderMno, String content, String cdate, String readyn) {
      super();
      this.cno = cno;
      this.roomNo = roomNo;
      this.senderMno = senderMno;
      this.senderMid = senderMid; // ★ 추가
      this.content = content;
      this.cdate = cdate;
      this.readyn = readyn;
   }
   
   public String getSenderMid() { 
	  return senderMid; 
   } // ★ 추가

   public String getCno() {
      return cno;
   }

   public String getRoomNo() {
      return roomNo;
   }

   public String getSenderMno() {
      return senderMno;
   }

   public String getContent() {
      return content;
   }

   public String getCdate() {
      return cdate;
   }

   public String getReadyn() {
      return readyn;
   }
   
   public void setSenderMid(String senderMid) { 
	  this.senderMid = senderMid; 
   } // ★ 추가

   public void setCno(String cno) {
      this.cno = cno;
   }

   public void setRoomNo(String roomNo) {
      this.roomNo = roomNo;
   }

   public void setSenderMno(String senderMno) {
      this.senderMno = senderMno;
   }

   public void setContent(String content) {
      this.content = content;
   }

   public void setCdate(String cdate) {
      this.cdate = cdate;
   }

   public void setReadyn(String readyn) {
      this.readyn = readyn;
   }

   @Override
   public String toString() {
       return "ChatMsgVO [cno=" + cno + ", roomNo=" + roomNo + ", senderMno=" + senderMno
               + ", senderMid=" + senderMid + ", content=" + content
               + ", cdate=" + cdate + ", readyn=" + readyn + "]";
   }


}