package com.brexa.used.comm;

import com.brexa.used.comm.SearchCondition;

//페이징(목록, 이전, 다음 버튼 등등)
public class PageHandler {
   private int totalCnt; // 총 회원수
//   private int pageSize; // 한 페이지의 크기
   private int navSize = 10; // 페이지 네비게이션의 크기. 한 페이지에 보여줄 회원 수
   private int totalPage; // 전체 페이지 수
//   private int page; // 현재 페이지
   private int beginPage; // 네비게이션의 첫번째 페이지
   private int endPage; // 네비게이션의 마지막 페이지
   private boolean showPrev; // 이전페이지로 이동하는 링크를 보여줄지 여부
   private boolean showNext; // 다음페이지로 이동하는 링크를 보여줄지 여부
   
   private SearchCondition sc;
//   private int offset;
   
   public PageHandler(int totalCnt, int page) {
      this(totalCnt, new SearchCondition(page, 10) );
   }
   public PageHandler(int totalCnt, int page, int pageSize) {
      this(totalCnt, new SearchCondition(page, pageSize) );
   }
   public PageHandler(int totalCnt ,SearchCondition sc ) {
      this.totalCnt = totalCnt;
      this.sc = sc;
      
      doPaging(totalCnt, sc);
   }
   // 페이징 데이터 가공
   public void doPaging(int totalCnt, SearchCondition sc) {
      this.totalPage = (int)Math.ceil(totalCnt/(double)sc.getPageSize());
      this.beginPage = sc.getPage() / navSize * navSize + 1;      
      this.endPage = Math.min(beginPage+ navSize -1 , totalPage); 
      
      this.showPrev = beginPage != 1;
      this.showNext = endPage != totalPage;
      this.sc.setPage(Math.min(sc.getPage(), totalPage)); // page가 totalPage보다 크지 않게
//      this.offset = (page-1)*pageSize;
   }
   public int getTotalCnt() {
      return totalCnt;
   }
   public void setTotalCnt(int totalCnt) {
      this.totalCnt = totalCnt;
   }
//   public int getPageSize() {
//      return pageSize;
//   }
//   public void setPageSize(int pageSize) {
//      this.pageSize = pageSize;
//   }
   public int getNavSize() {
      return navSize;
   }
   public void setNavSize(int navSize) {
      this.navSize = navSize;
   }
   public int getTotalPage() {
      return totalPage;
   }
   public void setTotalPage(int totalPage) {
      this.totalPage = totalPage;
   }
//   public int getPage() {
//      return page;
//   }
//   public void setPage(int page) {
//      this.page = page;
//   }
   public int getBeginPage() {
      return beginPage;
   }
   public void setBeginPage(int beginPage) {
      this.beginPage = beginPage;
   }
   public int getEndPage() {
      return endPage;
   }
   public void setEndPage(int endPage) {
      this.endPage = endPage;
   }
   public boolean isShowPrev() {
      return showPrev;
   }
   public void setShowPrev(boolean showPrev) {
      this.showPrev = showPrev;
   }
   public boolean isShowNext() {
      return showNext;
   }
   public void setShowNext(boolean showNext) {
      this.showNext = showNext;
   }
//   public int getOffset() {
//      return offset;
//   }
//   public void setOffset(int offset) {
//      this.offset = offset;
//   }
   public SearchCondition getSc() {
      return sc;
   }
   public void setSc(SearchCondition sc) {
      this.sc = sc;
   }
   @Override
   public String toString() {
      return "PageHandler [totalCnt=" + totalCnt + ", navSize=" + navSize + ", totalPage=" + totalPage
            + ", beginPage=" + beginPage + ", endPage=" + endPage + ", showPrev=" + showPrev + ", showNext="
            + showNext + ", sc=" + sc + "]";
   }


   
}
