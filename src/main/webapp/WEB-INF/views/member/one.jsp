<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 정보 - 양파마켓</title>
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
    <div class="mypage-inner">

        <!-- 페이지 타이틀 -->
        <div class="detail-page-title">
            <a href="<c:url value='/member/list'/>" class="back-btn">
                <span class="material-icons-round">arrow_back</span>
            </a>
            <h2 class="detail-heading">회원 상세 정보</h2>
        </div>

        <!-- 프로필 카드 -->
        <div class="profile-card">
            <div class="profile-avatar-wrap">
                <div class="profile-avatar">${mvo.mname.substring(0,1)}</div>
                <div class="profile-badge">🧅</div>
            </div>
            <div class="profile-info">
                <h2 class="profile-name">${mvo.mname}</h2>
                <p class="profile-id">@${mvo.mid}</p>
            </div>
            <div class="profile-actions">
                <a href="<c:url value='/member/up'/>" class="profile-action-btn">
                    <span class="material-icons-round">edit</span>
                    정보 수정
                </a>
                <a href="<c:url value='/member/list'/>" class="profile-action-btn">
                    <span class="material-icons-round">list</span>
                    목록으로
                </a>
            </div>
        </div>

        <!-- 상세 정보 카드 -->
        <div class="detail-card">
            <h3 class="detail-card-title">
                <span class="material-icons-round">badge</span>
                기본 정보
            </h3>

            <div class="detail-rows">
                <div class="detail-row">
                    <div class="detail-label">
                        <span class="material-icons-round">person</span>
                        이름
                    </div>
                    <div class="detail-value">${mvo.mname}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        <span class="material-icons-round">account_circle</span>
                        아이디
                    </div>
                    <div class="detail-value detail-value--id">@${mvo.mid}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        <span class="material-icons-round">cake</span>
                        생년월일
                    </div>
                    <div class="detail-value">
                   		<fmt:formatDate value="${mvo.mbirth}" pattern="yyyy년 MM월 dd일"/>
               		</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        <span class="material-icons-round">phone</span>
                        전화번호
                    </div>
                    <div class="detail-value">${mvo.mphone}</div>
                </div>

                <div class="detail-row">
                    <div class="detail-label">
                        <span class="material-icons-round">mail</span>
                        이메일
                    </div>
                    <div class="detail-value">
                        <a href="mailto:${mvo.mmail}" class="detail-mail-link">${mvo.mmail}</a>
                    </div>
                </div>

                <div class="detail-row detail-row--last">
                    <div class="detail-label">
                        <span class="material-icons-round">calendar_today</span>
                        가입일
                    </div>
                    <div class="detail-value">
                        <fmt:formatDate value="${mvo.minsertdate}" pattern="yyyy년 MM월 dd일"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- 하단 액션 버튼 -->
        <div class="detail-btn-row">
            <a href="<c:url value='/member/list'/>" class="detail-action-btn detail-action-btn--secondary">
                <span class="material-icons-round">arrow_back</span>
                목록으로
            </a>
            <a href="<c:url value='/member/up'/>" class="detail-action-btn detail-action-btn--primary">
                <span class="material-icons-round">edit</span>
                정보 수정
            </a>
        </div>

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