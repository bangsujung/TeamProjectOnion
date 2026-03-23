package com.brexa.used.chat.vo;

public class ChatRoomVO {
    private String roomNo;    // 방 번호 (ROOM_NO)
    private String ino;       // 상품 번호 (INO)
    private String buyerMno;  // 구매자 번호 (BUYER_MNO)
    private String sellerMno; // 판매자 번호 (SELLER_MNO)
    private String crdate;    // 방 생성일 (CRDATE)
    private String ititle;    // 상품 제목 (ITITLE)
    private String iphoto;    // 상품 사진 (IPHOTO)
    private int unreadCount; // 안 읽은 메세지 수
    
    private String opponentNickname; // 상대방 이름 (추가)
    private String lastContent;      // 마지막 메세지 내용 (추가)
    private String lastCdate;        // 마지막 메세지 시간 (추가)
    
    // 기본 생성자
    public ChatRoomVO() {
       super();
    }

    //생성자
   public ChatRoomVO(String roomNo, String ino, String buyerMno, String sellerMno, String crdate, String ititle,
         String iphoto, int unreadCount, String opponentNickname, String lastContent, String lastCdate) {
      super();
      this.roomNo = roomNo;
      this.ino = ino;
      this.buyerMno = buyerMno;
      this.sellerMno = sellerMno;
      this.crdate = crdate;
      this.ititle = ititle;
      this.iphoto = iphoto;
      this.unreadCount = unreadCount;
      this.opponentNickname = opponentNickname;
      this.lastContent = lastContent;
      this.lastCdate = lastCdate;
   }

   public String getRoomNo() {
      return roomNo;
   }

   public String getIno() {
      return ino;
   }

   public String getBuyerMno() {
      return buyerMno;
   }

   public String getSellerMno() {
      return sellerMno;
   }

   public String getCrdate() {
      return crdate;
   }

   public String getItitle() {
      return ititle;
   }

   public String getIphoto() {
      return iphoto;
   }

   public int getUnreadCount() {
      return unreadCount;
   }

   public String getOpponentNickname() {
      return opponentNickname;
   }

   public String getLastContent() {
      return lastContent;
   }

   public String getLastCdate() {
      return lastCdate;
   }

   public void setRoomNo(String roomNo) {
      this.roomNo = roomNo;
   }

   public void setIno(String ino) {
      this.ino = ino;
   }

   public void setBuyerMno(String buyerMno) {
      this.buyerMno = buyerMno;
   }

   public void setSellerMno(String sellerMno) {
      this.sellerMno = sellerMno;
   }

   public void setCrdate(String crdate) {
      this.crdate = crdate;
   }

   public void setItitle(String ititle) {
      this.ititle = ititle;
   }

   public void setIphoto(String iphoto) {
      this.iphoto = iphoto;
   }

   public void setUnreadCount(int unreadCount) {
      this.unreadCount = unreadCount;
   }

   public void setOpponentNickname(String opponentNickname) {
      this.opponentNickname = opponentNickname;
   }

   public void setLastContent(String lastContent) {
      this.lastContent = lastContent;
   }

   public void setLastCdate(String lastCdate) {
      this.lastCdate = lastCdate;
   }

   @Override
   public String toString() {
      return "ChatRoomVO [roomNo=" + roomNo + ", ino=" + ino + ", buyerMno=" + buyerMno + ", sellerMno=" + sellerMno
            + ", crdate=" + crdate + ", ititle=" + ititle + ", iphoto=" + iphoto + ", unreadCount=" + unreadCount
            + ", opponentNickname=" + opponentNickname + ", lastContent=" + lastContent + ", lastCdate=" + lastCdate
            + "]";
   }

}