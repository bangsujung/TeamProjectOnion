<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="loginId"
       value="${pageContext.request.getSession(false) eq null
       ? ''
       : pageContext.request.session.getAttribute('mid') }"/>

<html>
<head>
<title>양파마켓 - 동네 중고거래</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
    crossorigin="anonymous"></script>
<script defer src="/resources/js/main.js"></script>
<script>
    let msg = '${msg}';
    // ✅ 원래 코드의 메시지 키 통합
    if(msg == "LOGIN_SUC")     { alert("로그인되었습니다.") }
    if(msg == "M_JOIN_OK" || msg == "M_JOIN_SUC") { alert("회원가입 성공! 양파마켓에 오신 걸 환영해요 🧅") }
    if(msg == "M_DEL_SUC")   { alert("회원탈퇴 되었습니다.") }
    if(msg == "NO_LOGIN")    { alert("로그인 후 이용해 주세요") }
</script>
</head>
<body>

<!-- ===== 상단 네비게이션 ===== -->
<header class="header">
    <div class="header-inner">
        <!-- 로고 -->
        <a href="/" class="logo">
            <span class="logo-icon">🧅</span>
            <span class="logo-text">양파마켓</span>
        </a>

        <!-- 검색창 -->
        <form action="/item/list" method="get">
          <div class="search-bar">
              <span class="material-icons-round search-icon">search</span>
              <input type="hidden" name="option" value="TI"/>
              <input type="text" name="keyword" placeholder="검색어를 입력하세요" class="search-input">
              <button type="submit" style="display:none;"></button>
          </div>
      </form> 

        <!-- 우측 메뉴 -->
        <nav class="header-nav">
            <c:if test="${loginId eq null or loginId eq ''}">
                <a href="${pageContext.request.contextPath}/member/form" class="nav-btn nav-btn--outline">회원가입</a>
                <a href="/login" class="nav-btn nav-btn--fill">로그인</a>
            </c:if>

            <c:if test="${!(loginId eq null or loginId eq '')}">
                <a href="/item/write" class="nav-btn nav-btn--fill">
                    <span class="material-icons-round" style="font-size:18px;">add</span>
                    글쓰기
                </a>
                <div class="user-menu">
                    <div class="user-avatar">${loginId.substring(0,1).toUpperCase()}</div>
                    <div class="user-dropdown">
                        <%-- ✅ 원래 코드처럼 mname(이름)으로 환영 메시지 표시 --%>
                        <span class="user-dropdown-name">${sessionScope.mname} 님</span>
                        <a href="/member/mypage" class="dropdown-item">
                            <span class="material-icons-round">person</span> 마이페이지
                        </a>
                        <c:if test="${loginId eq 'manager000'}">
                       <a href="/member/list" class="dropdown-item">
                           <span class="material-icons-round">group</span> 회원목록
                       </a>
                   </c:if>
                        <a href="/item/list" class="dropdown-item">
                            <span class="material-icons-round">list</span> 상품 목록
                        </a>
                        <c:if test="${loginId eq 'manager000'}">
                            <a href="/report/list" class="dropdown-item dropdown-item--warn">
                                <span class="material-icons-round">flag</span> 신고 목록
                            </a>
                        </c:if>
                        <hr class="dropdown-divider">
                        <a href="/logout" class="dropdown-item dropdown-item--logout">
                            <span class="material-icons-round">logout</span> 로그아웃
                        </a>
                    </div>
                </div>
            </c:if>
        </nav>
    </div>
</header>

<!-- ===== 히어로 배너 ===== -->
<section class="hero">
    <div class="hero-inner">
        <div class="hero-text">
            <p class="hero-sub">🧅 우리 동네 중고 직거래</p>
            <h1 class="hero-title">
                가깝고 믿을 수 있는<br>
                <em>양파마켓</em>
            </h1>
            <p class="hero-desc">껍질을 벗길수록 더 알찬 거래,<br>이웃과 함께하는 중고마켓</p>
            <div class="hero-actions">
                <c:if test="${loginId eq null or loginId eq ''}">
                    <a href="${pageContext.request.contextPath}/member/form" class="hero-btn hero-btn--primary">지금 시작하기</a>
                    <a href="/item/list" class="hero-btn hero-btn--secondary">구경하기</a>
                </c:if>
                <c:if test="${!(loginId eq null or loginId eq '')}">
                    <a href="/item/write" class="hero-btn hero-btn--primary">상품 등록하기</a>
                    <a href="/item/list" class="hero-btn hero-btn--secondary">상품 둘러보기</a>
                </c:if>
            </div>
        </div>
        <div class="hero-illust">
            <div class="onion-big">🧅</div>
            <div class="float-tag float-tag--1">💰 안전결제</div>
            <div class="float-tag float-tag--2">🤝 직거래</div>
            <div class="float-tag float-tag--3">⭐ 매너거래</div>
        </div>
    </div>
</section>

<!-- ===== 카테고리 ===== -->
<section class="category-section">
    <div class="section-inner">
        <h2 class="section-title">카테고리</h2>
        <div class="category-grid">
          <a href="/item/list?option=CA&keyword=디지털/가전" class="category-card">
              <div class="category-icon">💻</div>
              <span>디지털/가전</span>
          </a>
          <a href="/item/list?option=CA&keyword=가구/인테리어" class="category-card">
              <div class="category-icon">🪑</div>
              <span>가구/인테리어</span>
          </a>
          <a href="/item/list?option=CA&keyword=의류/패션" class="category-card">
              <div class="category-icon">👗</div>
              <span>의류/패션</span>
          </a>
          <a href="/item/list?option=CA&keyword=도서/문구" class="category-card">
              <div class="category-icon">📚</div>
              <span>도서/문구</span>
          </a>
          <a href="/item/list?option=CA&keyword=스포츠/레저" class="category-card">
              <div class="category-icon">⚽</div>
              <span>스포츠/레저</span>
          </a>
          <a href="/item/list?option=CA&keyword=유아동" class="category-card">
              <div class="category-icon">🧸</div>
              <span>유아동</span>
          </a>
          <a href="/item/list?option=CA&keyword=뷰티/미용" class="category-card">
              <div class="category-icon">💄</div>
              <span>뷰티/미용</span>
          </a>
          <a href="/item/list?option=CA&keyword=기타" class="category-card">
              <div class="category-icon">📦</div>
              <span>기타</span>
          </a>
      </div>
    </div>
</section>

<!-- ===== 최근 상품 목록 ===== -->
<section class="items-section">
    <div class="section-inner">
        <div class="section-header">
            <h2 class="section-title">최근 등록된 상품</h2>
            <a href="/item/list" class="see-all">전체보기 →</a>
        </div>

        <c:choose>
            <c:when test="${not empty itemList}">
                <div class="items-grid">
                    <c:forEach var="item" items="${itemList}">
                      <a href="/item/one?ino=${item.ino}" class="item-card">  <%-- 여기 수정 --%>
                          <div class="item-img-wrap">
						     <c:choose>
							      <c:when test="${not empty item.iphoto}">
							          <%-- 쉼표로 분리해서 첫 번째 사진만 가져오는 로직 추가 --%>
							           <c:set var="firstPhoto" value="${fn:split(item.iphoto, ',')[0]}" />
							           <img src="/upload/item/${fn:trim(firstPhoto)}" alt="${item.ititle}" class="item-img">
							       </c:when>
							       <c:otherwise>
							           <div class="item-img-placeholder">🧅</div>
							       </c:otherwise>
							    </c:choose>
						  </div>
                          <div class="item-info">
                              <p class="item-title">${item.ititle}</p>
                              <p class="item-location">
                               <fmt:formatDate value="${item.iinsertdate}" pattern="yyyy.MM.dd"/>
                           </p>
                          </div>
                      </a>
                  </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">🧅</div>
                    <p class="empty-text">아직 등록된 상품이 없어요</p>
                    <c:if test="${!(loginId eq null or loginId eq '')}">
                        <a href="/item/write" class="hero-btn hero-btn--primary" style="margin-top:16px;display:inline-block;">첫 상품 등록하기</a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ===== 하단 푸터 ===== -->
<footer class="footer">
    <div class="footer-inner">
        <div class="footer-logo">
            <span>🧅</span> 양파마켓
        </div>
        <p class="footer-desc">껍질을 벗길수록 더 알찬 거래, 양파마켓</p>
        <p class="footer-copy">© 2025 양파마켓. All rights reserved.</p>
    </div>
</footer>

</body>
</html>
