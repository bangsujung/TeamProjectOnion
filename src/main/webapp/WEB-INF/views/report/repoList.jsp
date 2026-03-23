<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 목록 - 양파마켓</title>
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
            <a href="/member/list" class="nav-btn nav-btn--outline">회원 목록</a>
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
                <h2 class="other-title">🚨 신고 목록</h2>
                <p class="other-subtitle">누적 신고 횟수가 높은 순으로 표시돼요</p>
            </div>
            <div class="report-total-badge">
                총 <strong>${empty list ? 0 : list.size()}</strong>건
            </div>
        </div>

        <!-- 목록 -->
        <c:choose>
            <c:when test="${empty list}">
                <div class="empty-state">
                    <div class="empty-icon">✅</div>
                    <p class="empty-text">신고 내역이 없어요</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="report-list">
                    <c:forEach var="repo" items="${list}" varStatus="vs">
                        <div class="report-card ${repo.rcnt >= 5 ? 'report-card--danger' : repo.rcnt >= 3 ? 'report-card--warn' : ''}">

                            <!-- 순번 -->
                            <div class="report-rank">
                                <c:choose>
                                    <c:when test="${vs.index == 0}">🥇</c:when>
                                    <c:when test="${vs.index == 1}">🥈</c:when>
                                    <c:when test="${vs.index == 2}">🥉</c:when>
                                    <c:otherwise><span class="report-rank-num">${vs.index + 1}</span></c:otherwise>
                                </c:choose>
                            </div>

                            <!-- 아바타 + 아이디 -->
                            <div class="report-user">
                                <div class="report-avatar">${repo.mid.substring(0,1).toUpperCase()}</div>
                                <div class="report-user-info">
                                    <a href="/member/one?mno=${repo.mno}" class="report-mid">${repo.mid}</a>
                                    <span class="report-mno">회원번호 #${repo.mno}</span>
                                </div>
                            </div>

                            <!-- 신고 횟수 -->
                            <div class="report-cnt-wrap">
                                <div class="report-cnt-bar-wrap">
                                    <div class="report-cnt-bar"
                                         style="width: min(${repo.rcnt * 10}%, 100%);
                                                background: ${repo.rcnt >= 5 ? '#c0392b' : repo.rcnt >= 3 ? '#e67e22' : 'var(--primary)'};">
                                    </div>
                                </div>
                                <span class="report-cnt ${repo.rcnt >= 5 ? 'report-cnt--danger' : repo.rcnt >= 3 ? 'report-cnt--warn' : ''}">
                                    ${repo.rcnt}회
                                </span>
                            </div>

                            <!-- 상세 보기 -->
                            <a href="/member/one?mno=${repo.mno}" class="report-detail-btn">
                                <span class="material-icons-round">chevron_right</span>
                            </a>

                        </div>
                    </c:forEach>
                </div>

                <!-- 기준 안내 -->
                <div class="report-legend">
                    <span class="report-legend-item report-legend-item--safe">
                        <span class="report-legend-dot"></span> 1~2회
                    </span>
                    <span class="report-legend-item report-legend-item--warn">
                        <span class="report-legend-dot"></span> 3~4회 주의
                    </span>
                    <span class="report-legend-item report-legend-item--danger">
                        <span class="report-legend-dot"></span> 5회 이상 위험
                    </span>
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
