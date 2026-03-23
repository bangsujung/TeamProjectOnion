<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 - 양파마켓</title>
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
    if(msg === "I_UP_SUC")  { alert("수정되었습니다."); }
    if(msg === "I_DEL_ERR") { alert("관리자에게 문의하세요."); }
    if(msg === "REPO_OK")   { alert("신고가 정상적으로 접수되었습니다."); }
    else if(msg === "REPO_ERR") { alert("신고 접수에 실패했습니다. 다시 시도해주세요."); }
</script>

<style>
/* ── 슬라이더 컨테이너 ── */
.ione-slider {
    position: relative;
    width: 100%;
    height: 100%;
    overflow: hidden;
    border-radius: 20px;
    background: var(--gray-1);
}
.ione-slide {
    display: none;
    width: 100%;
    height: 100%;
}
.ione-slide.active { display: block; }
.ione-slide img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
}

/* 이전/다음 버튼 */
.ione-slider-btn {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(0,0,0,0.4);
    color: #fff;
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    z-index: 10;
    transition: background 0.2s;
}
.ione-slider-btn:hover { background: rgba(0,0,0,0.7); }
.ione-slider-btn--prev { left: 12px; }
.ione-slider-btn--next { right: 12px; }
.ione-slider-btn .material-icons-round { font-size: 20px; }

/* 카운터 */
.ione-slider-counter {
    position: absolute;
    bottom: 12px;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(0,0,0,0.45);
    color: #fff;
    font-size: 12px;
    font-weight: 700;
    padding: 3px 14px;
    border-radius: 20px;
    pointer-events: none;
    z-index: 10;
    white-space: nowrap;
}

/* 썸네일 */
.ione-thumbnails {
    display: flex;
    gap: 8px;
    margin-top: 10px;
    overflow-x: auto;
    padding-bottom: 4px;
}
.ione-thumb {
    width: 60px;
    height: 60px;
    flex-shrink: 0;
    border-radius: 8px;
    overflow: hidden;
    border: 2px solid var(--gray-2);
    cursor: pointer;
    transition: border-color 0.18s;
}
.ione-thumb.active { border-color: var(--primary); }
.ione-thumb img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
</head>
<body>

<%-- 상품 데이터 세팅 --%>
<c:forEach items="${iList}" var="ivo">
    <c:if test="${ino eq ivo.ino}">  <c:set var="CURR" value="${ivo}"/></c:if>
    <c:if test="${ino lt ivo.ino}">  <c:set var="NEXT" value="${ivo}"/></c:if>
    <c:if test="${ino gt ivo.ino}">  <c:set var="PREV" value="${ivo}"/></c:if>
</c:forEach>

<!-- 사진 배열 미리 계산 -->
<c:set var="photoArr" value="${fn:split(CURR.iphoto, ',')}"/>
<c:set var="photoCount" value="${fn:length(photoArr)}"/>

<!-- ===== 헤더 ===== -->
<header class="header">
    <div class="header-inner">
        <a href="/" class="logo">
            <span class="logo-icon">🧅</span>
            <span class="logo-text">양파마켓</span>
        </a>
        <nav class="header-nav">
            <a href="<c:url value='/item/list${sc.queryString}'/>" class="nav-btn nav-btn--outline">
                <span class="material-icons-round" style="font-size:17px;">arrow_back</span>
                목록으로
            </a>
        </nav>
    </div>
</header>

<!-- ===== 본문 ===== -->
<main class="ione-wrap">
    <div class="ione-inner">

        <!-- 상단 레이아웃: 이미지 + 정보 -->
        <div class="ione-top">

            <!-- 이미지 + 썸네일 묶음 -->
            <div>
                <div class="ione-img-box">
                    <c:choose>
                        <c:when test="${not empty CURR.iphoto}">
                            <div class="ione-slider" id="ione-slider">

                                <%-- 슬라이드 목록 --%>
                                <c:forEach items="${photoArr}" var="photo" varStatus="st">
                                    <div class="ione-slide ${st.first ? 'active' : ''}">
                                        <img src="/upload/item/${fn:trim(photo)}" alt="${CURR.ititle}">
                                    </div>
                                </c:forEach>

                                <%-- 사진 2장 이상이면 버튼/카운터 표시 --%>
                                <c:if test="${photoCount gt 1}">
                                    <button class="ione-slider-btn ione-slider-btn--prev" onclick="slideMove(-1)">
                                        <span class="material-icons-round">chevron_left</span>
                                    </button>
                                    <button class="ione-slider-btn ione-slider-btn--next" onclick="slideMove(1)">
                                        <span class="material-icons-round">chevron_right</span>
                                    </button>
                                    <div class="ione-slider-counter" id="sliderCounter">
                                        1 / ${photoCount}
                                    </div>
                                </c:if>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ione-img-empty">
                                <span style="font-size:64px;">🧅</span>
                                <p>사진이 없어요</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- 거래완료 오버레이 -->
                    <c:if test="${CURR.ideal eq 2}">
                        <div class="ione-sold-overlay">
                            <span>거래완료</span>
                        </div>
                    </c:if>
                </div>

                <%-- 썸네일 (2장 이상일 때만) --%>
                <c:if test="${not empty CURR.iphoto and photoCount gt 1}">
                    <div class="ione-thumbnails">
                        <c:forEach items="${photoArr}" var="photo" varStatus="st">
                            <div class="ione-thumb ${st.first ? 'active' : ''}" onclick="slideTo(${st.index})">
                                <img src="/upload/item/${fn:trim(photo)}" alt="사진 ${st.index + 1}">
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <!-- 정보 영역 -->
            <div class="ione-info-box">

                <!-- 거래 상태 -->
                <div class="ione-status-row">
                    <c:choose>
                        <c:when test="${CURR.ideal == 0}"><span class="ione-badge ione-badge--wait">거래대기</span></c:when>
                        <c:when test="${CURR.ideal == 1}"><span class="ione-badge ione-badge--ing">거래중</span></c:when>
                        <c:when test="${CURR.ideal == 2}"><span class="ione-badge ione-badge--done">거래완료</span></c:when>
                        <c:otherwise>                   <span class="ione-badge ione-badge--cancel">거래취소</span></c:otherwise>
                    </c:choose>
                </div>
                <h2 class="ione-title">${CURR.ititle}</h2>

                <!-- 판매자 + 액션 버튼 -->
                <div class="ione-seller-row">
                    <div class="ione-seller-avatar">${CURR.iid.substring(0,1).toUpperCase()}</div>
                    <div class="ione-seller-info">
                        <span class="ione-seller-label">판매자</span>
                        <span class="ione-seller-id">${CURR.iid}</span>
                    </div>
                    <c:if test="${not empty sessionScope.mid and sessionScope.mid ne CURR.iid}">
                        <div class="ione-action-btns">
                            <button type="button" class="ione-action-btn ione-action-btn--chat" onclick="startChat()" title="채팅하기">
                                <span class="material-icons-round">chat</span>
                                채팅하기
                            </button>
                            <button type="button" class="ione-action-btn ione-action-btn--report" onclick="openReportPopup()" title="신고하기">
                                <span class="material-icons-round">report</span>
                            </button>
                        </div>
                    </c:if>
                </div>

                <!-- 메타 정보 -->
                <div class="ione-meta">
                    <div class="ione-meta-row">
                        <span class="material-icons-round ione-meta-icon">calendar_today</span>
                        <span class="ione-meta-label">등록일</span>
                        <span class="ione-meta-val">
                            <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${CURR.iinsertdate}"/>
                        </span>
                    </div>
                    <div class="ione-meta-row">
                        <span class="material-icons-round ione-meta-icon">visibility</span>
                        <span class="ione-meta-label">조회수</span>
                        <span class="ione-meta-val">${CURR.icnt}회</span>
                    </div>
                </div>

                <!-- 찜 + 판매자 버튼 -->
                <div class="ione-bottom-btns">
                    <button type="button" class="ione-wish-btn ${wishCheck == 1 ? 'ione-wish-btn--active' : ''}"
                            onclick="${wishCheck == 1 ? 'wishCancel(ino)' : 'wishAction()'}">
                        <span class="material-icons-round">
                            ${wishCheck == 1 ? 'favorite' : 'favorite_border'}
                        </span>
                        ${wishCheck == 1 ? '찜 취소' : '찜하기'}
                    </button>

                    <c:if test="${sessionScope.mid eq CURR.iid}">
                        <c:if test="${CURR.ideal ne 2}">
                            <a href="/item/up?ino=${CURR.ino}" class="ione-owner-btn ione-owner-btn--edit">
                                <span class="material-icons-round">edit</span>
                                수정
                            </a>
                        </c:if>
                        <button type="button" class="ione-owner-btn ione-owner-btn--del" onclick="openDeletePopup()">
                            <span class="material-icons-round">delete</span>
                            삭제
                        </button>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- 상품 설명 -->
        <div class="ione-content-card">
            <div class="ione-content-title">
                <span class="material-icons-round">description</span>
                상품 설명
            </div>
            <div class="ione-content-body">
                <c:choose>
                    <c:when test="${not empty CURR.icontent}">${CURR.icontent}</c:when>
                    <c:otherwise><span style="color:var(--gray-3);">상품 설명이 없어요.</span></c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- 이전 / 다음 상품 -->
        <div class="ione-prevnext">
            <a class="ione-prevnext-item ${PREV eq null ? 'ione-prevnext-item--disabled' : ''}"
               href="${PREV ne null ? '/item/one?ino='.concat(PREV.ino) : 'javascript:void(0)'}">
                <span class="material-icons-round">arrow_back_ios</span>
                <div class="ione-prevnext-text">
                    <span class="ione-prevnext-label">이전 상품</span>
                    <span class="ione-prevnext-title">
                        <c:choose>
                            <c:when test="${PREV ne null}">${PREV.ititle}</c:when>
                            <c:otherwise>이전 상품이 없어요</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </a>
            <a class="ione-prevnext-item ione-prevnext-item--next ${NEXT eq null ? 'ione-prevnext-item--disabled' : ''}"
               href="${NEXT ne null ? '/item/one?ino='.concat(NEXT.ino) : 'javascript:void(0)'}">
                <div class="ione-prevnext-text" style="text-align:right;">
                    <span class="ione-prevnext-label">다음 상품</span>
                    <span class="ione-prevnext-title">
                        <c:choose>
                            <c:when test="${NEXT ne null}">${NEXT.ititle}</c:when>
                            <c:otherwise>다음 상품이 없어요</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <span class="material-icons-round">arrow_forward_ios</span>
            </a>
        </div>

    </div>
</main>

<!-- ===== 삭제 팝업 ===== -->
<div id="deletePopup" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div class="modal-header">
            <h3 class="modal-title">🗑️ 상품 삭제</h3>
            <button class="modal-close" onclick="closeDeletePopup()">
                <span class="material-icons-round">close</span>
            </button>
        </div>
        <p class="modal-desc">삭제하려면 게시글 비밀번호를 입력해주세요.<br>삭제 후에는 복구가 어렵습니다.</p>
        <div class="modal-input-wrap">
            <span class="material-icons-round modal-input-icon">lock</span>
            <input type="password" id="ipw" placeholder="비밀번호 입력" class="modal-input"/>
        </div>
        <div class="modal-btn-row">
            <button type="button" class="modal-btn modal-btn--cancel" onclick="closeDeletePopup()">취소</button>
            <button type="button" class="modal-btn modal-btn--danger" onclick="itemDelete()">
                <span class="material-icons-round" style="font-size:16px;">delete</span>삭제
            </button>
        </div>
    </div>
</div>

<!-- ===== 신고 팝업 ===== -->
<div id="reportPopup" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div class="modal-header">
            <h3 class="modal-title">🚨 유저 신고</h3>
            <button class="modal-close" onclick="closeReportPopup()">
                <span class="material-icons-round">close</span>
            </button>
        </div>
        <p class="modal-desc">
            판매자 아이디(<strong>${CURR.iid}</strong>)를 입력해주세요.<br>
            허위 신고 시 제재를 받을 수 있습니다.
        </p>
        <div class="modal-input-wrap">
            <span class="material-icons-round modal-input-icon">person_search</span>
            <input type="text" id="reportId" placeholder="아이디 입력" class="modal-input"/>
        </div>
        <input type="hidden" id="sellerId"  value="${CURR.iid}">
        <input type="hidden" id="targetMno" value="${CURR.mno}">
        <div class="modal-btn-row">
            <button type="button" class="modal-btn modal-btn--cancel" onclick="closeReportPopup()">취소</button>
            <button type="button" class="modal-btn modal-btn--confirm" onclick="submitReport()">신고하기</button>
        </div>
    </div>
</div>

<!-- 삭제용 hidden form -->
<form id="delForm">
    <input type="hidden" name="ino" value="${CURR.ino}">
</form>

<script>
    let mno = "${sessionScope.mno}";
    let ino = "${CURR.ino}";

    /* ── 슬라이더 ── */
    const slides  = document.querySelectorAll('.ione-slide');
    const thumbs  = document.querySelectorAll('.ione-thumb');
    const counter = document.getElementById('sliderCounter');
    const total   = slides.length;
    let   cur     = 0;

    function slideTo(idx) {
        if (total <= 1) return;
        slides[cur].classList.remove('active');
        if (thumbs[cur]) thumbs[cur].classList.remove('active');
        cur = (idx + total) % total;
        slides[cur].classList.add('active');
        if (thumbs[cur]) thumbs[cur].classList.add('active');
        if (counter) counter.textContent = (cur + 1) + ' / ' + total;
    }
    function slideMove(dir) { slideTo(cur + dir); }

    /* 키보드 좌/우 */
    document.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowLeft')  slideMove(-1);
        if (e.key === 'ArrowRight') slideMove(1);
    });

    /* ── 팝업 ── */
    function openDeletePopup()  { document.getElementById('deletePopup').style.display  = 'flex'; }
    function closeDeletePopup() { document.getElementById('deletePopup').style.display  = 'none'; }
    function openReportPopup()  { document.getElementById('reportPopup').style.display  = 'flex'; }
    function closeReportPopup() { document.getElementById('reportPopup').style.display  = 'none'; }

    document.querySelectorAll('.modal-overlay').forEach(function(el) {
        el.addEventListener('click', function(e) { if (e.target === el) el.style.display = 'none'; });
    });

    /* ── 채팅 시작 (팝업창 버전!) ── */
    function startChat() {
        // 로그인 체크 (mno가 비어있으면 로그인 페이지로)
        if (!mno || mno === "") {
            alert("로그인이 필요합니다.");
            location.href = "/login";
            return;
        }

        $.ajax({
            url: "/chat/start",
            type: "POST",
            data: { 
                ino: ino, 
                buyerMno: mno, 
                sellerMno: "${CURR.mno}" 
            },
            success: function(roomNo) {
                if (roomNo === "ERR") {
                    alert("채팅방 생성에 실패했습니다.");
                } else {
                    // [수정 포인트] 목록으로 이동하지 않고, 팝업창을 띄웁니다!
                    var url = "/chat/room?roomNo=" + roomNo;
                    var name = "chatPopup_" + roomNo;
                    var specs = "width=420,height=600,resizable=no,status=no,toolbar=no,menubar=no,location=no";
                    
                    window.open(url, name, specs);
                }
            },
            error: function() {
                alert("채팅 연결 중 오류가 발생했습니다.");
            }
        });
    }
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
