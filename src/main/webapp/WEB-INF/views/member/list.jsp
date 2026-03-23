<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
    crossorigin="anonymous"></script>
<script defer src="/resources/js/main.js"></script>
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
            <a href="/item/list" class="nav-btn nav-btn--outline">상품 목록</a>
            <a href="/member/mypage" class="nav-btn nav-btn--fill">마이페이지</a>
        </nav>
    </div>
</header>

<!-- ===== 본문 ===== -->
<main class="mypage-wrap">
    <div class="mypage-inner" style="max-width:860px;">

        <!-- 페이지 타이틀 -->
        <div class="detail-page-title">
            <h2 class="detail-heading">👥 회원 목록</h2>
        </div>

        <!-- 검색 바 -->
        <form action="/member/list" method="get" class="mlist-search-form">
            <div class="mlist-search-inner">
                <div class="mlist-select-wrap">
                    <span class="material-icons-round mlist-select-icon">tune</span>
                    <select name="option" class="mlist-select">
                        <option value="">전체</option>
                        <option value="NA" ${ph.sc.option=='NA' ? 'selected':''}>이름</option>
                        <option value="ID" ${ph.sc.option=='ID' ? 'selected':''}>아이디</option>
                    </select>
                </div>
                <div class="mlist-keyword-wrap">
                    <span class="material-icons-round mlist-keyword-icon">search</span>
                    <input type="text" name="keyword" id="keyword"
                           value="${ph.sc.keyword}"
                           placeholder="검색어를 입력하세요"
                           class="mlist-keyword-input"/>
                    <c:if test="${not empty ph.sc.keyword}">
                        <button type="button" class="mlist-keyword-clear"
                                onclick="document.getElementById('keyword').value=''; this.closest('form').submit();">
                            <span class="material-icons-round">close</span>
                        </button>
                    </c:if>
                </div>
                <button type="submit" class="mlist-search-btn">
                    <span class="material-icons-round">search</span>
                    검색
                </button>
            </div>
            <!-- 검색 결과 키워드 표시 -->
            <c:if test="${not empty ph.sc.keyword}">
                <div class="mlist-search-result-label">
                    <span class="material-icons-round" style="font-size:16px;">info_outline</span>
                    "<strong>${ph.sc.keyword}</strong>" 검색 결과
                </div>
            </c:if>
        </form>

        <!-- 회원 목록 -->
        <c:choose>
            <c:when test="${!(mList eq null)}">

                <!-- 회원 카드 그리드 -->
                <div class="mlist-grid">
                    <c:forEach var="mvo" items="${mList}">
                        <button type="button"
                                class="mlist-card btn-one"
                                data-mno="${mvo.mno}">
                            <!-- 아바타 -->
                            <div class="mlist-avatar">${mvo.mname.substring(0,1)}</div>
                            <!-- 정보 -->
                            <div class="mlist-card-info">
                                <span class="mlist-card-name">${mvo.mname}</span>
                                <span class="mlist-card-id">@${mvo.mid}</span>
                            </div>
                            <!-- 화살표 -->
                            <span class="material-icons-round mlist-card-arrow">chevron_right</span>
                        </button>
                    </c:forEach>
                </div>

                <!-- 페이지네이션 -->
                <div class="mlist-pagination">
                    <c:forEach begin="${ph.beginPage}" end="${ph.endPage}" var="i">
                        <a href="<c:url value='/member/list${ph.sc.getQueryString(i)}'/>"
                           class="mlist-page-btn ${ph.sc.page == i ? 'mlist-page-btn--active' : ''}">
                            <c:out value="${i}"/>
                        </a>
                    </c:forEach>
                </div>

            </c:when>
            <c:otherwise>
                <!-- 빈 상태 -->
                <div class="empty-state">
                    <div class="empty-icon">👥</div>
                    <p class="empty-text">
                        <c:choose>
                            <c:when test="${not empty ph.sc.keyword}">
                                "<strong>${ph.sc.keyword}</strong>"에 해당하는 회원이 없어요
                            </c:when>
                            <c:otherwise>등록된 회원이 없어요</c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</main>

<!-- 상세 이동용 hidden form -->
<form action="/member/one" method="post" name="memberOne" id="memberOne">
    <input type="hidden" name="mno" id="mno"/>
</form>

<script>
    $(document).ready(function(){
        $("button.btn-one").click(function(){
            let mno = $(this).data("mno");
            $('#mno').val(mno);
            $("#memberOne").submit();
        });
    });
</script>

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
