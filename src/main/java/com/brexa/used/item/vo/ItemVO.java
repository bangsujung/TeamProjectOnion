package com.brexa.used.item.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ItemVO {
   @DateTimeFormat(pattern = "yyyy-MM-dd")
   private String ino;
   private String iid;
   private String ipw;
   private String ititle;
   private String icontent;
   private int icnt;
   private String iphoto;
   private String iorphoto;
   private int ideal;
   private Date iinsertdate;
   private Date iupdatedate;
   private String ideleteyn;
   private String wno; // 찜 번호를 저장할 변수 추가
   private String mno; // 회원번호 저장용
   private String icategory; //카테고리
   
   public ItemVO() {
      super();
   }

   public ItemVO(String ino, String iid, String ipw, String ititle, String icontent, int icnt, String iphoto,
         String iorphoto, int ideal, Date iinsertdate, Date iupdatedate, String ideleteyn, String mno, String icategory) {
      super();
      this.ino = ino;
      this.iid = iid;
      this.ipw = ipw;
      this.ititle = ititle;
      this.icontent = icontent;
      this.icnt = icnt;
      this.iphoto = iphoto;
      this.iorphoto = iorphoto;
      this.ideal = ideal;
      this.iinsertdate = iinsertdate;
      this.iupdatedate = iupdatedate;
      this.ideleteyn = ideleteyn;
      this.mno = mno;
   }

   public String getIno() {
      return ino;
   }

   public String getIid() {
      return iid;
   }

   public String getIpw() {
      return ipw;
   }

   public String getItitle() {
      return ititle;
   }

   public String getIcontent() {
      return icontent;
   }

   public int getIcnt() {
      return icnt;
   }

   public String getIphoto() {
      return iphoto;
   }
   
   public String getIorphoto() {
      return iorphoto;
   }

   public int getIdeal() {
      return ideal;
   }

   public Date getIinsertdate() {
      return iinsertdate;
   }

   public Date getIupdatedate() {
      return iupdatedate;
   }

   public String getIdeleteyn() {
      return ideleteyn;
   }
   
   public String getWno() {
          return wno;
   }
   
   public String getMno() {
        return mno;
    }
   
   public String getIcategory() {
        return icategory;
    }
   

   public void setIno(String ino) {
      this.ino = ino;
   }

   public void setIid(String iid) {
      this.iid = iid;
   }

   public void setIpw(String ipw) {
      this.ipw = ipw;
   }

   public void setItitle(String ititle) {
      this.ititle = ititle;
   }

   public void setIcontent(String icontent) {
      this.icontent = icontent;
   }

   public void setIcnt(int icnt) {
      this.icnt = icnt;
   }

   public void setIphoto(String iphoto) {
      this.iphoto = iphoto;
   }
   
   public void setIorphoto(String iorphoto) {
      this.iorphoto = iorphoto;
   }

   public void setIdeal(int ideal) {
      this.ideal = ideal;
   }

   public void setIinsertdate(Date iinsertdate) {
      this.iinsertdate = iinsertdate;
   }

   public void setIupdatedate(Date iupdatedate) {
      this.iupdatedate = iupdatedate;
   }

   public void setIdeleteyn(String ideleteyn) {
      this.ideleteyn = ideleteyn;
   }
   
   public void setWno(String wno) {
          this.wno = wno;
   }

   public void setMno(String mno) {
        this.mno = mno;
    }
   
   public void setIcategory(String icategory) {
        this.icategory = icategory;
    }
   
   @Override
   public String toString() {
      return "ItemVO [ino=" + ino + ", iid=" + iid + ", ipw=" + ipw + ", ititle=" + ititle + ", icontent=" + icontent
            + ", icnt=" + icnt + ", iphoto=" + iphoto + ", iorphoto=" + iorphoto + ", ideal=" + ideal
            + ", iinsertdate=" + iinsertdate + ", iupdatedate=" + iupdatedate + ", ideleteyn=" + ideleteyn 
            + ", mno=" + mno + ", icategory=" + icategory + "]";
   }

   
}