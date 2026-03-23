package com.brexa.used.comm;

import java.util.Objects;

import org.springframework.web.util.UriComponentsBuilder; 
// 검색
public class SearchCondition {
   private Integer page = 1;
   private Integer pageSize = DEFAULT_PAGE_SIZE;
   private String option;
   private String keyword;
   private int offset; //페이지 나눠주는 것
   
   //상수
   public static final int MIN_PAGE_SIZE = 5;
   public static final int DEFAULT_PAGE_SIZE = 12; 
   public static final int MAX_PAGE_SIZE = 50;
   
   //기본생성자
   public SearchCondition() {
   }
   
   public SearchCondition(Integer page, Integer pageSize) {
      this(page, pageSize,"","");
   }
   public SearchCondition(Integer page, Integer pageSize, String option, String keyword) {
      this.page = page;
      this.pageSize = pageSize;
      this.option = option;
      this.keyword = keyword;
//      this.offset = (page-1)*pageSize;
   }
   
   public Integer getPage() {
      return page;
   }

   public void setPage(Integer page) {
      this.page = page;
   }
   public Integer getPageSize() {
      return this.pageSize;
   }
   public void setPageSize(Integer pageSize) {
      this.pageSize  = Objects.requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);
      
   }
   public String getOption() {
      return option;
   }
   public void setOption(String option) {
      this.option = option;
   }
   public String getKeyword() {
      return keyword;
   }
   public void setKeyword(String keyword) {
      this.keyword = keyword;
   }

   public int getOffset() {
      return (page == 0)?page:(page-1)*pageSize;
   }

   public void setOffset(int offset) {
      this.offset = offset;
   }
   public String getQueryString(Integer page) {
//      ?page=1&option=dfd&keyword=2&pageSize=10
      return UriComponentsBuilder.newInstance()
            .queryParam("page", page)
            .queryParam("option", option)
            .queryParam("keyword", keyword)
            .queryParam("pageSize", pageSize)
            .build().toString();
   }
   @Override
   public String toString() {
      return "SearchCondition [page=" + page + ", pageSize=" + pageSize + ", option=" + option + ", keyword="
            + keyword + " ,offset = "+ offset +"]";
   }

   
}

