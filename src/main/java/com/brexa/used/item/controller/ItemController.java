package com.brexa.used.item.controller;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.brexa.used.comm.Chaebun;
import com.brexa.used.comm.EncryptUtils;
import com.brexa.used.comm.PageHandler;
import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.service.ItemService;
import com.brexa.used.item.vo.ItemVO;
import com.brexa.used.wish.service.WishService;
import com.brexa.used.wish.vo.WishVO;

@Controller
@RequestMapping(value="/item")
public class ItemController {
   @Autowired
   private ItemService iservice;
   
   @Autowired
   private WishService wservice;
   
   //상품 등록 페이지 이동(GET)
   @GetMapping(value = "/write")
   public String itemWriteForm() {
       System.out.println("ItemController itemWriteForm(GET) 진입 >>>>");
       return "item/form"; 
   }
   
   //상품 등록(POST)
   @PostMapping(value = "/write")
   public String itemWrite(ItemVO ivo, RedirectAttributes rattr, HttpSession session,
                           @RequestParam("files") MultipartFile[] files) throws Exception {
       System.out.println("ItemController itemWrite 함수 진입 >>>>");
       System.out.println("ivo >> " + ivo);
       System.out.println("files >> " + files);

       // 1. 세션에서 로그인 아이디 가져오기 (iid와 mid 모두 체크)
       String loginId = (String) session.getAttribute("iid");
       
       if (loginId == null) {
           loginId = (String) session.getAttribute("mid");
       }

       // 2. 로그인 정보가 없을 경우
       if (loginId == null) {
           rattr.addFlashAttribute("msg", "NO_LOGIN");
           return "redirect:/login";
       }
       
       // 3. VO에 작성자 아이디 세팅
       ivo.setIid(loginId);
       System.out.println("작성자 아이디(IID) 세팅 완료 >> " + ivo.getIid());

       // 4. 비번 암호화 (EncryptUtils 활용)
       if (ivo.getIpw() != null) {
           ivo.setIpw(EncryptUtils.encryptMD5(ivo.getIpw()));
       }

       // 5. 상품 번호 채번 (Chaebun.getItem 활용)
       int maxno = iservice.itemMaxno();
       String ino = Chaebun.getItem(maxno);
       ivo.setIno(ino);
       System.out.println("생성된 상품번호(INO) >> " + ino);

       // 6. 파일 업로드 처리 (최대 10장, 쉼표 구분 저장)
       String path = "C:\\javaPro\\60.Brexa\\upload\\item\\";
       new File(path).mkdirs();

       List<String> saveNames = new ArrayList<String>();
       List<String> oriNames  = new ArrayList<String>();
       
       int order = 0;

       for (MultipartFile file : files) {
           if (file == null || file.isEmpty()) continue;
           if (order >= 10) break;

           // 6-1. 원본 파일명 및 확장자 추출
           String ori  = file.getOriginalFilename();
           String ext  = StringUtils.getFilenameExtension(ori);
           System.out.println("originalFilename >> " + ori);

           // 6-2. 파일 덮어쓰기 방지를 위한 새로운 파일명(저장명) 생성
           //      최종 저장 파일명: 날짜_시간_순번.확장자 (예: 20260306_123045_0.jpg)
           String save = new SimpleDateFormat("yyyyMMdd_HHmmss_").format(new Date()) + order + "." + ext;
           System.out.println("saveFilename >> " + save);

           // 6-3. 서버의 실제 경로에 파일 업로드
           file.transferTo(new File(path, save));

           saveNames.add(save);
           oriNames.add(ori);
           order++;
       }

       // 6-4. VO에 매칭 정보 세팅 (쉼표 구분 문자열로 저장 예: "aaa.jpg,bbb.jpg")
       if (!saveNames.isEmpty()) {
           ivo.setIphoto(String.join(",", saveNames));
           ivo.setIorphoto(String.join(",", oriNames));
       }

       // 7. DB 저장 실행
       int res = iservice.itemWrite(ivo);
       System.out.println("DB 등록 결과 >> " + res);

       // 8. 결과에 따른 페이지 이동
       if (res != 1) {
           rattr.addFlashAttribute("msg", "ITEM_WRT_ERR");
           return "redirect:/item/write"; // 실패 시 등록 폼으로
       }
       rattr.addFlashAttribute("msg", "I_WRT_SUC");
       return "redirect:/item/list"; // 성공 시 상품 목록으로
   }
      
   //상품 파일 다운로드
   @RequestMapping(value="/filedownload")
   public void filedownload(String iphoto, String iorphoto, HttpServletRequest request, HttpServletResponse response) throws Exception {
       System.out.println("=============== BoardController filedownload 함수진입");
       System.out.println(iphoto);
       
       String path = "C:\\javaPro\\60.Brexa\\upload\\";
       File downloadFile = new File(path + iphoto);
       byte fileByte[] = FileUtils.readFileToByteArray(downloadFile);
       
       //"application/octet-stream" 은 자바에서 사용하는 파일 다운로드 응답 형식으로, 어플리케이션 파일이 리턴된다고 설정한다.
       response.setContentType("application/octet-stream");
       //가져온 파일 사이즈를 지정한다.
       response.setContentLength(fileByte.length);
       
       //"attachment;fileName="을 사용하면 다운로드시 파일 이름을 지정
       response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(iorphoto, "UTF-8") + "\";");
       //"application/octet-stream" 파일은 binary 데이터이기 때문에 binary로 인코딩
       response.setHeader("Content-Transfer-Encoding", "binary");
       
       response.getOutputStream().write(fileByte); //버퍼에 파일을 담아 스트림으로 출력
       response.getOutputStream().flush(); //버퍼에 저장된 내용을 클라이언트로 전송하고 버퍼를 비운다.
       response.getOutputStream().close(); //출력 스트림을 종료한다. 참고로 close() 함수 자체에서 flush() 함수를 호출하기 때문에 굳이 flush() 를 호출하지 않아도 된다.
   }
   
   //상품 수정 페이지 이동(GET)
   @GetMapping(value="/up")
   public String itemUpdateForm(String ino, Model model) {
       System.out.println("ItemControlelr itemUpdateForm() 함수 진입 =======");
       System.out.println("ino >> " + ino);
     
       // 전체 리스트 가져오기
       List<ItemVO> iList = iservice.itemOne(ino);
     
       // 리스트 중에서 현재 내가 보고 있는 글과 일치하는 것 찾기
       if (iList != null) {
           for (ItemVO ivo : iList) {
               if (ivo.getIno().equals(ino)) {
                   // 찾으면 ivo라는 이름에 모델 담음
                   model.addAttribute("ivo", ivo);
                   break; //찾았으니 루프 종료
               }
           }
       }
     
       return "item/form"; //등록 / 수정 폼 통합 사용
   }
   
   //상품 수정 실행(POST)
   @PostMapping(value="/up")
   public String itemUpdate(ItemVO ivo,
                            @RequestParam("files") MultipartFile[] files,
                            @RequestParam(value = "keepPhotos",   required = false, defaultValue = "") String keepPhotos,
                            @RequestParam(value = "keepOrphotos", required = false, defaultValue = "") String keepOrphotos,
                            HttpSession session, RedirectAttributes rattr) throws Exception {
       System.out.println("ItemController itemUpdate() 함수 진입 =======");
       System.out.println("ivo >> " + ivo);
       
       //본인 확인(세션 id와 게시글 작성자 id 비교)
       String loginId = (String) session.getAttribute("mid");
       if (!loginId.equals(ivo.getIid())) {
           return "redirect:/item/list";
       }
       
       String path = "C:\\javaPro\\60.Brexa\\upload\\item\\";
       new File(path).mkdirs();

       // 기존 유지 사진 목록 (삭제하지 않고 남긴 사진들)
       List<String> saveNames = new ArrayList<String>();
       if (!keepPhotos.isEmpty()) {
           saveNames.addAll(Arrays.asList(keepPhotos.split(",")));
       }
       List<String> oriNames = new ArrayList<String>();
       if (!keepOrphotos.isEmpty()) {
           oriNames.addAll(Arrays.asList(keepOrphotos.split(",")));
       }

       // 새로운 사진 첨부 시 기존 유지 목록에 추가 (합쳐서 최대 10장)
       int order = saveNames.size();
       for (MultipartFile file : files) {
           if (file == null || file.isEmpty()) continue;
           if (order >= 10) break;

           // 원본 파일명 및 확장자 추출
           String ori  = file.getOriginalFilename();
           String ext  = StringUtils.getFilenameExtension(ori);

           // 파일 덮어쓰기 방지를 위한 새로운 파일명(저장명) 생성
           String save = new SimpleDateFormat("yyyyMMdd_HHmmss_").format(new Date()) + order + "." + ext;

           file.transferTo(new File(path, save));

           saveNames.add(save);
           oriNames.add(ori);
           order++;
       }

       // VO에 사진 정보 세팅 (쉼표 구분 문자열로 저장)
       if (!saveNames.isEmpty()) {
           ivo.setIphoto(String.join(",", saveNames));
           ivo.setIorphoto(String.join(",", oriNames));
       }
       
       //DB 업데이트
       int res = iservice.itemUpdate(ivo);
       System.out.println("res >> " + res);
       if (res != 1) {
           rattr.addFlashAttribute("msg", "I_UP_ERR");
           return "redirect:/item/form";
       }
       rattr.addFlashAttribute("msg", "I_UP_SUC");
       return "redirect:/item/one?ino=" + ivo.getIno();
   }
   
   //상품 목록 조회(GET)
   @GetMapping(value="/list")
   public String itemList(SearchCondition sc, String my, HttpServletRequest request, Model model) {
       System.out.println("ItemController itemList() 진입 >>>>");
       
       // 1. 세션에서 로그인한 아이디 가져오기
       HttpSession session = request.getSession();
       String mid = (String) session.getAttribute("mid");

       // 2. "내 판매 상품" 클릭 시 (my=true) 처리
       // 이 작업이 itemCount 조회보다 먼저 일어나야 내 물건 개수만 정확히 셀 수 있습니다.
       if ("true".equals(my) && mid != null) {
           sc.setOption("ID");      // 검색 옵션을 '아이디(판매자)'로 설정
           sc.setKeyword(mid);      // 키워드를 내 아이디로 설정
       }

       // 3. 검색 조건이 반영된 총 게시글 개수 조회
       int cnt = iservice.itemCount(sc);
       System.out.println("전체/검색된 게시글 수 >> " + cnt);
       
       // 4. 페이징 처리 (sc에 담긴 page, pageSize와 cnt를 이용)
       PageHandler ph = new PageHandler(cnt, sc);
       
       // 5. 실제 목록 조회
       List<ItemVO> iList = iservice.itemList(sc);
       System.out.println("조회된 목록 개수 >> " + iList.size());
       
       model.addAttribute("iList", iList);
       model.addAttribute("ph", ph);
       
       return "/item/itemList";
   }
   
   //상품 상세조회(GET)
   @RequestMapping(value="/one")
   public String itemOne(String ino, HttpSession session, RedirectAttributes rattr, Model model) {
       System.out.println("ItemController itemOne() 함수 진입 =======");
       System.out.println("ino >> " + ino);
       String mno = (String) session.getAttribute("mno");
       if (mno != null) {
           WishVO wvo = new WishVO();
           wvo.setIno(ino);
           wvo.setMno(mno);

           int wishCheck = wservice.wishCheck(wvo);
           model.addAttribute("wishCheck", wishCheck);
       }
       if (ino == null || ino == "") {
           rattr.addFlashAttribute("msg", "I_ONE_ERR");
           return "redirect:/item/list";
       }
       //조회수 증가
       iservice.itemCnt(ino);
       
       //상품 조회
       List<ItemVO> iList = iservice.itemOne(ino);
       System.out.println("iList >> " + iList);
       
       if (iList == null) {
           rattr.addFlashAttribute("msg", "I_ONE_ERR");
           return "redirect:/item/list";
       }
       model.addAttribute("iList", iList);
       model.addAttribute("ino", ino);
       
       return "/item/itemOne";
   }
   
   //비번 확인 (삭제 전 비밀번호 검증)
   @PostMapping(value="/pkChk")
   @ResponseBody
   public String pkChk(String ino, String ipw) {
       System.out.println("ItemServiceImpl pkChk() 함수 진입");
       System.out.println("ino >> " + ino);
       System.out.println("ipw >> " + ipw);
       //암호화된 패스워드
       String pw = iservice.pkChk(ino);
       System.out.println("DB pw >> " + pw);
       //입력받은 패스워드 암호화
       ipw = EncryptUtils.encryptMD5(ipw);
       System.out.println("input ipw >> " + ipw);
       //일치여부 확인
       return String.valueOf(ipw.equals(pw));
   }
   
   //상품 삭제
   @PostMapping(value="/del")
   public String itemDelete(String ino, RedirectAttributes rattr) {
       System.out.println("ItemServiceImpl itemDelete() 함수 진입");
       System.out.println("ino >> " + ino);
       int res = iservice.itemDelete(ino);
       System.out.println("res >> " + res);
       String msg = "";
       if (res != 1) {
           msg = "I_DEL_ERR";
           rattr.addFlashAttribute("msg", msg);
           return "redirect:/item/one?ino=" + ino;
       } else {
           msg = "I_DEL_SUC";
           rattr.addFlashAttribute("msg", msg);
           return "redirect:/item/list";
       }
   }
   
}
