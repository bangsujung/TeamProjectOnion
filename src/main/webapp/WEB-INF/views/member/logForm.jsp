<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - 양파마켓</title>
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
    let msg = "${msg}";
    // ★ 원본 msg 코드로 통일
    if(msg === "LOG_ERR")    { alert("아이디 또는 패스워드가 일치하지 않습니다."); }
    if(msg === "NO_LOGIN")   { alert("로그인을 먼저 해주세요."); }
    if(msg === "BAN_MEMBER") { alert("신고 누적으로 인해 정지된 계정입니다. 관리자에게 문의하세요."); }
</script>
</head>
<body class="login-page">

<!-- ===== 헤더 ===== -->
<header class="header">
    <div class="header-inner">
        <a href="/" class="logo">
            <span class="logo-icon">🧅</span>
            <span class="logo-text">양파마켓</span>
        </a>
        <nav class="header-nav">
            <a href="/member/form" class="nav-btn nav-btn--outline">회원가입</a>
        </nav>
    </div>
</header>

<!-- ===== 로그인 본문 ===== -->
<main class="auth-wrap">
    <div class="auth-card">

        <div class="auth-logo">
            <span class="auth-logo-icon">🧅</span>
            <span class="auth-logo-text">양파마켓</span>
        </div>
        <p class="auth-subtitle">동네 중고 직거래의 시작</p>

        <!-- ★ 원본 폼 name: LoginForm -->
        <form name="LoginForm" method="post" onsubmit="return login(this);" class="auth-form">

            <div class="auth-input-group">
                <div class="auth-input-wrap">
                    <span class="material-icons-round auth-input-icon">person</span>
                    <input type="text" name="mid" id="mid"
                           placeholder="아이디를 입력하세요"
                           class="auth-input" autocomplete="username"/>
                </div>
                <div class="auth-input-wrap">
                    <span class="material-icons-round auth-input-icon">lock</span>
                    <input type="password" name="mpw" id="mpw"
                           placeholder="비밀번호를 입력하세요"
                           class="auth-input" autocomplete="current-password"/>
                    <button type="button" class="auth-pw-toggle" onclick="togglePw(this)" tabindex="-1">
                        <span class="material-icons-round">visibility</span>
                    </button>
                </div>
            </div>

            <button type="submit" class="auth-submit-btn">
                <span class="material-icons-round">login</span>
                로그인
            </button>

            <div class="auth-links">
                <button type="button" class="auth-link-btn" onclick="openSearchPopup('I')">아이디 찾기</button>
                <span class="auth-links-divider">|</span>
                <button type="button" class="auth-link-btn" onclick="openSearchPopup('P')">비밀번호 찾기</button>
                <span class="auth-links-divider">|</span>
                <a href="/member/form" class="auth-link-btn">회원가입</a>
            </div>
        </form>
    </div>
</main>

<!-- ===== 아이디/비번 찾기 팝업 ===== -->
<div id="searchPopup" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <div class="modal-header">
            <h3 class="modal-title" id="popupTitle">아이디 찾기</h3>
            <button class="modal-close" onclick="closeSearchPopup()">
                <span class="material-icons-round">close</span>
            </button>
        </div>
        <p class="modal-desc" id="popupDesc">이름과 전화번호로 아이디를 찾을 수 있어요.</p>

        <form name="searchForm" class="search-form">
            <input type="hidden" name="flg" id="flg">

            <div class="auth-input-wrap" style="margin-bottom:10px;">
                <span class="material-icons-round auth-input-icon">badge</span>
                <input type="text" name="mname" id="mname"
                       placeholder="이름을 입력하세요" class="auth-input"/>
            </div>

            <div class="auth-input-wrap" id="midWrap" style="display:none; margin-bottom:10px;">
                <span class="material-icons-round auth-input-icon">person</span>
                <input type="text" name="mid" id="search_mid"
                       placeholder="아이디를 입력하세요" class="auth-input"/>
            </div>

            <div class="auth-input-wrap" style="margin-bottom:20px;">
                <span class="material-icons-round auth-input-icon">phone</span>
                <input type="text" name="mphone" id="mphone"
                       placeholder="전화번호를 입력하세요 (- 없이)" class="auth-input"/>
            </div>

            <div class="modal-btn-row">
                <button type="button" class="modal-btn modal-btn--cancel" onclick="closeSearchPopup()">취소</button>
                <button type="button" class="modal-btn modal-btn--primary" onclick="searchFun()">
                    <span class="material-icons-round" style="font-size:16px;">search</span>
                    찾기
                </button>
            </div>
        </form>
    </div>
</div>

<!-- ===== 결과 팝업 ===== -->
<div id="resultPopup" class="modal-overlay" style="display:none;">
    <div class="modal-box" style="text-align:center;">
        <div class="modal-header" style="justify-content:center; border:none; margin-bottom:0;">
            <h3 class="modal-title" id="resultTitle">찾기 완료</h3>
        </div>
        <div class="result-icon">✅</div>
        <p class="modal-desc" id="resultDesc" style="text-align:center;"></p>
        <div class="modal-btn-row" style="justify-content:center;">
            <button type="button" class="modal-btn modal-btn--primary" onclick="closeResultPopup()">확인</button>
        </div>
    </div>
</div>

<script>
    function togglePw(btn) {
        const input = btn.closest('.auth-input-wrap').querySelector('input');
        const icon  = btn.querySelector('.material-icons-round');
        if (input.type === 'password') {
            input.type = 'text';
            icon.textContent = 'visibility_off';
        } else {
            input.type = 'password';
            icon.textContent = 'visibility';
        }
    }

    function openSearchPopup(flg) {
        const title   = document.getElementById('popupTitle');
        const desc    = document.getElementById('popupDesc');
        const midWrap = document.getElementById('midWrap');
        document.getElementById('flg').value = flg;

        if (flg === 'I') {
            title.textContent = '아이디 찾기';
            desc.textContent  = '이름과 전화번호로 아이디를 찾을 수 있어요.';
            midWrap.style.display = 'none';
        } else {
            title.textContent = '비밀번호 찾기';
            desc.textContent  = '이름, 아이디, 전화번호로 임시 비밀번호를 받을 수 있어요.';
            midWrap.style.display = 'flex';
        }
        document.searchForm.mname.value  = '';
        document.searchForm.mphone.value = '';
        document.getElementById('search_mid').value = '';
        document.getElementById('searchPopup').style.display = 'flex';
    }

    function closeSearchPopup() {
        document.getElementById('searchPopup').style.display = 'none';
    }

    function closeResultPopup() {
        document.getElementById('resultPopup').style.display = 'none';
    }

    function searchFun() {
        let flg    = document.getElementById('flg').value;
        let mname  = document.searchForm.mname.value.trim();
        let mphone = document.searchForm.mphone.value.trim();
        let mid    = document.getElementById('search_mid').value.trim();
        let url, data;

        if (!mname || !mphone) { alert('이름과 전화번호를 모두 입력해주세요.'); return; }

        if (flg === 'I') {
            url  = '/member/searchID';
            data = { mname, mphone };
        } else if (flg === 'P') {
            if (!mid) { alert('아이디를 입력해주세요.'); return; }
            url  = '/member/searchPW';
            data = { mname, mid, mphone };
        }

        $.ajax({
            type: 'post',
            url,
            data,
            success: function(data) {
                if (data == null || data === '') {
                    alert('일치하는 회원이 없습니다.');
                } else {
                    closeSearchPopup();
                    const resultTitle = document.getElementById('resultTitle');
                    const resultDesc  = document.getElementById('resultDesc');

                    if (flg === 'I') {
                        resultTitle.textContent = '아이디 찾기 완료';
                        resultDesc.innerHTML    = '회원님의 아이디는<br><strong style="font-size:18px;color:var(--primary);">' + data + '</strong><br>입니다.';
                        // ★ 원본 폼 name: LoginForm
                        document.LoginForm.mid.value = data;
                    } else {
                        resultTitle.textContent = '임시 비밀번호 발급';
                        resultDesc.innerHTML    = '임시 비밀번호는<br><strong style="font-size:18px;color:var(--primary);">' + data + '</strong><br>입니다. 로그인 후 변경해주세요.';
                        document.LoginForm.mpw.value = data;
                    }
                    document.getElementById('resultPopup').style.display = 'flex';
                }
            },
            error: function(err) { console.log(err); alert('오류가 발생했습니다. 다시 시도해주세요.'); }
        });
    }

    document.querySelectorAll('.modal-overlay').forEach(function(el) {
        el.addEventListener('click', function(e) {
            if (e.target === el) el.style.display = 'none';
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