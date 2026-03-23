<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/item.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script defer src="/resources/js/main.js"></script>
<script>
    let msg = "${msg}";
    if(msg === "I_WRT_SUC") { alert("상품이 등록되었습니다."); }
    if(msg === "I_ONE_ERR") { alert("관리자에게 문의하세요."); }
    if(msg === "I_DEL_SUC") { alert("삭제되었습니다."); }
</script>
</head>
<body>

<!-- ===== 헤더 ===== -->
<header class="header">
    <div class="header-inner">
        <a href="/" class="logo">
            <span class="logo-icon">🧅</span>
            <span class="logo-text">양파마켓</span>
        </a>
        <nav class="header-nav">
            <a href="/item/write" class="nav-btn nav-btn--fill">
                <span class="material-icons-round" style="font-size:17px;">add</span>
                상품 등록
            </a>
        </nav>
    </div>
</header>

<!-- ===== 본문 ===== -->
<main class="ilist-wrap">
    <div class="ilist-inner">

        <!-- 검색 바 -->
        <form name="itemList" action="/item/list" method="get" class="ilist-search-form">
            <div class="ilist-search-inner">
                <div class="ilist-select-wrap">
                    <span class="material-icons-round ilist-select-icon">tune</span>
                    <select name="option" class="ilist-select">
                   <option value="">전체</option>
                   <option value="ID" ${ph.sc.option=='ID' ? 'selected' : ''}>판매자</option>
                   <option value="TI" ${ph.sc.option=='TI' ? 'selected' : ''}>글 제목</option>
                   <option value="TC" ${ph.sc.option=='TC' ? 'selected' : ''}>제목+내용</option>
               </select>
                </div>
                <div class="ilist-keyword-wrap">
                    <span class="material-icons-round ilist-keyword-icon">search</span>
                    <input type="text" name="keyword" id="keyword"
                           value="${ph.sc.keyword}"
                           placeholder="검색어를 입력하세요"
                           class="ilist-keyword-input"/>
                    <c:if test="${not empty ph.sc.keyword}">
                        <button type="button" class="ilist-keyword-clear"
                                onclick="document.getElementById('keyword').value=''; this.closest('form').submit();">
                            <span class="material-icons-round">close</span>
                        </button>
                    </c:if>
                </div>
                <button type="submit" class="ilist-search-btn">
                    <span class="material-icons-round">search</span>
                    검색
                </button>
            </div>
            <c:if test="${not empty ph.sc.keyword}">
                <div class="ilist-search-result-label">
                    <span class="material-icons-round" style="font-size:15px;">info_outline</span>
                    "<strong>${ph.sc.keyword}</strong>" 검색 결과
                </div>
            </c:if>
        </form>
        <c:if test="${ph.sc.option == 'CA'}">
          <div class="ilist-search-result-label">
              <span class="material-icons-round" style="font-size:15px;">category</span>
              카테고리 "<strong>${ph.sc.keyword}</strong>" 상품 목록
          </div>
      </c:if>

        <!-- 상품 목록 -->
        <c:choose>
            <c:when test="${iList eq null}">
                <div class="empty-state">
                    <div class="empty-icon">🧅</div>
                    <p class="empty-text">
                        <c:choose>
                            <c:when test="${not empty ph.sc.keyword}">"<strong>${ph.sc.keyword}</strong>"에 해당하는 상품이 없어요</c:when>
                            <c:otherwise>아직 등록된 상품이 없어요</c:otherwise>
                        </c:choose>
                    </p>
                    <a href="/item/write" class="hero-btn hero-btn--primary" style="margin-top:16px;display:inline-flex;gap:6px;">
                        <span class="material-icons-round" style="font-size:18px;">add</span>첫 상품 등록하기
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 총 개수 -->
                <div class="ilist-count-row">
                    <span class="ilist-count">총 <strong>${ph.totalCnt}</strong>개의 상품</span>
                </div>

                <!-- 카드 그리드 -->
                <div class="ilist-grid">
                    <c:set var="no" value="${ph.totalCnt - ((ph.sc.page - 1) * ph.sc.pageSize)}"/>
                    <c:forEach var="ivo" items="${iList}">
                        <a href="<c:url value='/item/one?ino=${ivo.ino}'/>" class="ilist-card">
                            <!-- 썸네일 -->
                            <div class="ilist-card-thumb">
                                <c:choose>
                                    <c:when test="${not empty ivo.iphoto}">
                                     
										<c:set var="firstPhoto" value="${fn:split(ivo.iphoto, ',')[0]}" />
										<img src="/upload/item/${fn:trim(firstPhoto)}" alt="${ivo.ititle}" class="ilist-card-img">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="ilist-card-noimg">🧅</div>
                                    </c:otherwise>
                                </c:choose>
                                <!-- 거래 상태 뱃지 -->
                                <c:choose>
                                    <c:when test="${ivo.ideal == 1}">
                                        <div class="ilist-deal-badge ilist-deal-badge--ing">거래중</div>
                                    </c:when>
                                    <c:when test="${ivo.ideal == 2}">
                                        <div class="ilist-deal-badge ilist-deal-badge--done">거래완료</div>
                                    </c:when>
                                    <c:when test="${ivo.ideal == 3}">
                                        <div class="ilist-deal-badge ilist-deal-badge--cancel">취소</div>
                                    </c:when>
                                </c:choose>
                            </div>

                            <!-- 정보 -->
                            <div class="ilist-card-info">
                                <p class="ilist-card-title">${ivo.ititle}</p>
                                <p class="ilist-card-seller">
                                    <span class="material-icons-round" style="font-size:13px;">person</span>
                                    ${ivo.iid}
                                </p>
                                <div class="ilist-card-meta">
                                    <span class="ilist-card-date">
                                        <fmt:formatDate value="${ivo.iinsertdate}" pattern="MM.dd"/>
                                    </span>
                                    <span class="ilist-card-cnt">
                                        <span class="material-icons-round" style="font-size:13px;">visibility</span>
                                        ${ivo.icnt}
                                    </span>
                                </div>
                            </div>
                        </a>
                        <c:set var="no" value="${no - 1}"/>
                    </c:forEach>
                </div>

                <!-- 페이지네이션 -->
                <div class="mlist-pagination">
                    <c:if test="${ph.totalCnt ne 0}">
                        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}" step="1">
                            <a class="mlist-page-btn ${ph.sc.page eq i ? 'mlist-page-btn--active' : ''}"
                               href="<c:url value='/item/list${ph.sc.getQueryString(i)}'/>">
                                <c:out value="${i}"/>
                            </a>
                        </c:forEach>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</main>

<!-- ===== 푸터 ===== -->
<footer class="footer">
    <div class="footer-inner">
        <div class="footer-logo"><span>🧅</span> 양파마켓</div>
        <p class="footer-desc">껍질을 벗길수록 더 알찬 거래, 양파마켓</p>
        <p class="footer-copy">© 2025 양파마켓. All rights reserved.</p>
    </div>
</footer>

</body>
</html>

