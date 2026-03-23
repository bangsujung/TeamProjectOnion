<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜 목록 - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/other.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
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
<main class="other-wrap">
    <div class="other-inner">

        <!-- 페이지 타이틀 -->
        <div class="other-title-row">
            <div>
                <h2 class="other-title">❤️ 찜 목록</h2>
                <p class="other-subtitle">관심 상품을 한눈에 확인해요</p>
            </div>
            <button type="button" id="delSelectedBtn" class="other-del-btn">
                <span class="material-icons-round">delete_sweep</span>
                선택 삭제
            </button>
        </div>

        <!-- 전체 선택 바 -->
        <c:if test="${not empty wList}">
        <div class="wish-select-bar">
            <label class="wish-all-label">
                <input type="checkbox" id="all" class="wish-checkbox">
                <span class="wish-checkbox-custom"></span>
                전체 선택
            </label>
            <span class="wish-count-label" id="selectedCount">0개 선택됨</span>
        </div>
        </c:if>

        <!-- 찜 목록 -->
        <c:choose>
            <c:when test="${empty wList}">
                <div class="empty-state">
                    <div class="empty-icon">🤍</div>
                    <p class="empty-text">아직 찜한 상품이 없어요</p>
                    <a href="/item/list" class="hero-btn hero-btn--primary" style="margin-top:16px;display:inline-flex;gap:6px;">
                        <span class="material-icons-round" style="font-size:18px;">search</span>
                        상품 둘러보기
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="wish-grid">
                    <c:forEach var="item" items="${wList}">
                        <div class="wish-card">
                            <!-- 체크박스 -->
                            <label class="wish-card-check">
                                <input type="checkbox" name="chk" class="chk wish-checkbox" value="${item.wno}">
                                <span class="wish-checkbox-custom"></span>
                            </label>

                            <!-- 이미지 -->
                            <a href="/item/one?ino=${item.ino}" class="wish-card-thumb">
                                <c:choose>
                                    <c:when test="${not empty item.iphoto}">
                                        <img src="/upload/item/${item.iphoto}" alt="${item.ititle}" class="wish-card-img">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="wish-card-noimg">🧅</div>
                                    </c:otherwise>
                                </c:choose>
                            </a>

                            <!-- 정보 -->
                            <div class="wish-card-info">
                                <a href="/item/one?ino=${item.ino}" class="wish-card-title">${item.ititle}</a>
                                <div class="wish-card-actions">
                                    <a href="/item/one?ino=${item.ino}" class="wish-goto-btn">
                                        <span class="material-icons-round">arrow_forward</span>
                                        상품 보기
                                    </a>
                                </div>
                            </div>

                            <!-- 찜 해제 아이콘 -->
                            <div class="wish-heart-icon">
                                <span class="material-icons-round">favorite</span>
                            </div>
                        </div>
                    </c:forEach>
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

<script>
$(document).ready(function() {

    /* 선택 카운트 업데이트 */
    function updateCount() {
        const cnt = $("input[name='chk']:checked").length;
        $('#selectedCount').text(cnt + '개 선택됨');
        $('#delSelectedBtn').toggleClass('other-del-btn--active', cnt > 0);
    }

    /* 전체 선택/해제 */
    $("#all").click(function() {
        $("input[name='chk']").prop("checked", $(this).prop("checked"));
        updateCount();
    });

    /* 개별 체크 */
    $(document).on("change", "input[name='chk']", function() {
        const total   = $("input[name='chk']").length;
        const checked = $("input[name='chk']:checked").length;
        $("#all").prop("checked", total === checked);
        updateCount();
    });

    /* 선택 삭제 */
    $("#delSelectedBtn").click(function() {
        var wnos = [];
        $("input[name='chk']:checked").each(function() {
            wnos.push($(this).val());
        });
        if(wnos.length === 0) {
            alert("삭제할 상품을 선택해주세요.");
            return;
        }
        if(confirm("선택한 " + wnos.length + "개 상품을 찜 목록에서 삭제할까요?")) {
            $.ajax({
                url: "/wish/delSelect",
                type: "POST",
                traditional: true,
                data: { wnos: wnos },
                success: function(res) {
                    if(res === "OK") {
                        alert("삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("삭제에 실패했습니다.");
                    }
                }
            });
        }
    });
});
</script>

</body>
</html>
