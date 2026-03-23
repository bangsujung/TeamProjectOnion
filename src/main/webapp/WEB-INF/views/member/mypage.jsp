<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
    crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script defer src="/resources/js/main.js"></script>
<script>
    let msg = "${msg}";
    // ✅ 원래 코드의 M_DEL_ERR 메시지 추가
    if(msg === "M_DEL_ERR") { alert("관리자에게 문의하세요. M3") }
    if(msg === "REPO_OK")  { alert("신고가 정상적으로 접수되었습니다.") }
    if(msg === "REPO_ERR") { alert("신고 접수에 실패했습니다. 다시 시도해주세요.") }
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
            <a href="/item/list" class="nav-btn nav-btn--outline">상품 목록</a>
            <a href="/item/write" class="nav-btn nav-btn--fill">
                <span class="material-icons-round" style="font-size:18px;">add</span>글쓰기
            </a>
            <div class="user-menu">
                <div class="user-avatar">${sessionScope.mid.substring(0,1).toUpperCase()}</div>
                <div class="user-dropdown">
                    <span class="user-dropdown-name">${sessionScope.mid} 님</span>
                    <a href="/member/mypage" class="dropdown-item">
                        <span class="material-icons-round">person</span> 마이페이지
                    </a>
                    <a href="/wish/list" class="dropdown-item">
                        <span class="material-icons-round">favorite</span> 찜 목록
                    </a>
                    <hr class="dropdown-divider">
                    <a href="/logout" class="dropdown-item dropdown-item--logout">
                        <span class="material-icons-round">logout</span> 로그아웃
                    </a>
                </div>
            </div>
        </nav>
    </div>
</header>

<!-- ===== 마이페이지 본문 ===== -->
<main class="mypage-wrap">
    <div class="mypage-inner">

        <!-- 프로필 카드 -->
        <div class="profile-card">
            <div class="profile-avatar-wrap">
                <div class="profile-avatar">${sessionScope.mname.substring(0,1)}</div>
                <div class="profile-badge">🧅</div>
            </div>
            <div class="profile-info">
                <h2 class="profile-name">${sessionScope.mname}</h2>
                <p class="profile-id">@${sessionScope.mid}</p>
            </div>
            <div class="profile-actions">
                <a href="/member/form" class="profile-action-btn">
                    <span class="material-icons-round">edit</span>
                    회원정보 수정
                </a>
                <button type="button" class="profile-action-btn profile-action-btn--danger" onclick="popup()">
                    <span class="material-icons-round">person_remove</span>
                    회원탈퇴
                </button>
            </div>
        </div>

        <!-- 메뉴 그리드 -->
        <div class="mypage-menu-grid">
            <a href="/wish/list" class="mypage-menu-card">
                <div class="menu-card-icon">❤️</div>
                <div class="menu-card-text">
                    <span class="menu-card-title">찜 목록</span>
                    <span class="menu-card-desc">관심 상품을 확인해요</span>
                </div>
                <span class="material-icons-round menu-card-arrow">chevron_right</span>
            </a>
            <a href="/chat/list" class="mypage-menu-card" style="position: relative;">
             <div class="menu-card-icon">💬</div>
             
             <c:if test="${totalUnread > 0}">
                 <span class="chat-total-unread-badge" style="
                     position: absolute;
                     top: 10px;           /* 8px보다 살짝 아래로 조정 */
                     left: 46px;          /* 아이콘 우측 상단에 걸치도록 조정 */
                     background-color: #ff4d4d;
                     color: white;
                     font-size: 10px;
                     font-weight: bold;
                     min-width: 18px;
                     height: 18px;
                     border-radius: 50%;
                     display: flex;       /* 숫자 정중앙 정렬 */
                     align-items: center;
                     justify-content: center;
                     border: 2px solid #fff;
                     box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                     z-index: 10;
                 ">
                     ${totalUnread > 99 ? '99+' : totalUnread}
                 </span>
             </c:if>
         
             <div class="menu-card-text">
                 <span class="menu-card-title">채팅 목록</span>
                 <span class="menu-card-desc">진행 중인 거래 채팅을 확인해요</span>
             </div>
             <span class="material-icons-round menu-card-arrow">chevron_right</span>
         </a>
            <a href="/item/list?my=true" class="mypage-menu-card">
                <div class="menu-card-icon">📦</div>
                <div class="menu-card-text">
                    <span class="menu-card-title">내 판매 상품</span>
                    <span class="menu-card-desc">등록한 상품을 관리해요</span>
                </div>
                <span class="material-icons-round menu-card-arrow">chevron_right</span>
            </a>
            <a href="/member/form" class="mypage-menu-card">
                <div class="menu-card-icon">⚙️</div>
                <div class="menu-card-text">
                    <span class="menu-card-title">회원정보 수정</span>
                    <span class="menu-card-desc">닉네임 · 비밀번호 변경</span>
                </div>
                <span class="material-icons-round menu-card-arrow">chevron_right</span>
            </a>
            <c:if test="${not empty sessionScope.mid}">
            <button type="button" class="mypage-menu-card mypage-menu-card--report" onclick="openReportPopup()">
                <div class="menu-card-icon">🚨</div>
                <div class="menu-card-text">
                    <span class="menu-card-title">유저 신고</span>
                    <span class="menu-card-desc">불량 유저를 신고해요</span>
                </div>
                <span class="material-icons-round menu-card-arrow">chevron_right</span>
            </button>
            </c:if>
        </div>

    </div>
</main>

<!-- ===== 유저 신고 팝업 ===== -->
<div id="reportPopup" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div class="modal-header">
            <h3 class="modal-title">🚨 유저 신고</h3>
            <button class="modal-close" onclick="closeReportPopup()">
                <span class="material-icons-round">close</span>
            </button>
        </div>
        <p class="modal-desc">신고할 유저의 아이디를 입력해주세요.<br>허위 신고 시 제재를 받을 수 있습니다.</p>
        <div class="modal-input-wrap">
            <span class="material-icons-round modal-input-icon">person_search</span>
            <input type="text" id="reportId" placeholder="신고할 유저 아이디" class="modal-input">
        </div>
        <input type="hidden" id="sellerId" value="ANY">
        <input type="hidden" id="targetMno" value="">
        <div class="modal-btn-row">
            <button type="button" class="modal-btn modal-btn--cancel" onclick="closeReportPopup()">취소</button>
            <button type="button" class="modal-btn modal-btn--confirm" onclick="submitReportMyPage()">신고하기</button>
        </div>
    </div>
</div>

<!-- ===== 회원탈퇴 팝업 (✅ 원래 코드 구조: 비밀번호 입력이 팝업 안에 바로 있음) ===== -->
<div id="popupBg" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div class="modal-header">
            <h3 class="modal-title">회원탈퇴</h3>
            <button class="modal-close" onclick="closePopup()">
                <span class="material-icons-round">close</span>
            </button>
        </div>
        <p class="modal-desc">정말로 탈퇴하시겠어요?<br>탈퇴 후에는 복구가 어렵습니다.</p>
        <p class="modal-desc">비밀번호를 입력하여 본인을 확인해주세요.</p>
        <!-- ✅ 원래 코드의 form name="delForm" 유지 -->
        <form name="delForm" method="post">
            <div class="modal-input-wrap">
                <span class="material-icons-round modal-input-icon">lock_outline</span>
                <input type="password" name="mpw" id="delPw"
                       placeholder="비밀번호를 입력하세요" class="modal-input"/>
            </div>
            <input type="hidden" name="mid" id="mid"
                   value="<c:out value='${pageContext.request.session.getAttribute("mid")}'/>"/>
            <input type="hidden" name="mno" id="mno"
                   value="<c:out value='${pageContext.request.session.getAttribute("mno")}'/>"/>
            <div class="modal-btn-row">
                <button type="button" class="modal-btn modal-btn--cancel" onclick="closePopup()">취소</button>
                <button type="button" class="modal-btn modal-btn--danger" onclick="pwConfirm()">탈퇴 확인</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 회원탈퇴 팝업
    function popup() {
        document.getElementById('popupBg').style.display = 'flex';
    }
    function closePopup() {
        document.getElementById('popupBg').style.display = 'none';
    }

    // 유저 신고 팝업
    function openReportPopup() {
        document.getElementById('reportPopup').style.display = 'flex';
    }
    function closeReportPopup() {
        document.getElementById('reportPopup').style.display = 'none';
    }

    // 팝업 외부 클릭 시 닫기
    document.querySelectorAll('.modal-overlay').forEach(function(el) {
        el.addEventListener('click', function(e) {
            if (e.target === el) el.style.display = 'none';
        });
    });
    
    // ✅ [추가] 뒤로가기 시 안 읽은 메시지 수를 갱신하기 위한 새로고침 로직
    window.onpageshow = function(event) {
        // event.persisted는 캐시를 통해 페이지가 로드되었는지 확인합니다 (뒤로가기 시 true)
        if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
            window.location.reload();
        }
    };
    
   // 마이페이지 떠있는 동안에도 실시간으로 숫자 올리기
    var socket = new SockJS('/chat/echo');
    socket.onmessage = function(e) {
        var data = JSON.parse(e.data);
        // 내가 보낸 게 아니라 '상대방'이 보낸 메시지일 때만 새로고침!
        // sessionScope의 mno와 비교하는 로직을 넣으면 더 정확해요.
        if (data.senderMno != "${sessionScope.mno}") {
            window.location.reload(); 
        }
    };
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
