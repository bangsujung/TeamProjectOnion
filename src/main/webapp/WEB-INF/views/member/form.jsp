<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${mvo eq null ? '회원가입' : '회원정보 수정'}"/> - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="/resources/js/main.js"></script>
<script>
    let msg = '${msg}';
    if(msg == "M_JOIN_ERR") { alert("관리자에게 문의하세요. M1"); }
    if(msg == "M_UP_ERR")   { alert("관리자에게 문의하세요. M2"); }
    if(msg == "M_UP_SUC")   {
        alert("회원정보가 수정되었습니다.");
        location.href = "/member/mypage"; // ★ 원본: 확인 누르면 마이페이지로 이동
    }
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
            <c:if test="${mvo eq null}">
                <a href="/login" class="nav-btn nav-btn--outline">로그인</a>
            </c:if>
            <c:if test="${mvo ne null}">
                <a href="/member/mypage" class="nav-btn nav-btn--outline">마이페이지</a>
            </c:if>
        </nav>
    </div>
</header>

<!-- ===== 본문 ===== -->
<main class="auth-wrap" style="align-items:flex-start; padding-top:48px;">
    <div class="auth-card" style="max-width:500px;">

        <div class="auth-logo">
            <span class="auth-logo-icon">🧅</span>
            <span class="auth-logo-text">양파마켓</span>
        </div>
        <p class="auth-subtitle">
            <c:out value="${mvo eq null ? '새 계정을 만들어보세요' : '회원정보를 수정해요'}"/>
        </p>

        <c:if test="${mvo eq null}">
        <div class="join-steps">
            <div class="join-step join-step--active" id="step1-dot">
                <div class="join-step-dot">1</div>
                <span>기본 정보</span>
            </div>
            <div class="join-step-line"></div>
            <div class="join-step" id="step2-dot">
                <div class="join-step-dot">2</div>
                <span>연락처</span>
            </div>
            <div class="join-step-line"></div>
            <div class="join-step" id="step3-dot">
                <div class="join-step-dot">3</div>
                <span>완료</span>
            </div>
        </div>
        </c:if>

        <form name="memberForm" method="post"
              action="${mvo eq null ? '/member/join' : '/member/up'}"
              class="join-form">

            <input type="hidden" name="mno" id="mno" value="<c:out value='${mvo.mno}'/>"/>
            <!-- ★ 원본: 세션 아이디 hidden -->
            <input type="hidden" name="iid" value="${sessionScope.mid}"/>

            <!-- ── STEP 1 : 기본 정보 ── -->
            <div class="join-section" id="joinStep1">
                <div class="join-section-title">
                    <span class="material-icons-round">person</span>
                    기본 정보
                </div>

                <!-- 이름 -->
                <div class="join-field">
                    <label class="join-label" for="mname">이름 <span class="join-required">*</span></label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">badge</span>
                        <input type="text" name="mname" id="mname"
                               placeholder="이름을 입력하세요"
                               class="auth-input"
                               value="<c:out value='${mvo eq null ? "" : mvo.mname}'/>"/>
                    </div>
                </div>

                <!-- 아이디 -->
                <div class="join-field">
                    <label class="join-label" for="mid">아이디 <span class="join-required">*</span></label>
                    <div class="join-id-row">
                        <div class="auth-input-wrap" style="flex:1;">
                            <span class="material-icons-round auth-input-icon">alternate_email</span>
                            <input type="text" name="mid" id="mid"
                                   placeholder="아이디를 입력하세요"
                                   class="auth-input"
                                   value="<c:out value='${mvo eq null ? "" : mvo.mid}'/>"
                                   <c:out value="${mvo eq null ? '' : 'readonly'}"/>/>
                        </div>
                        <c:if test="${mvo eq null}">
                            <!-- ★ 원본 함수명 idChk() 유지 -->
                            <button type="button" class="join-check-btn" onclick="idChk()" id="idCheckBtn">
                                중복확인
                            </button>
                            <input type="hidden" name="idCheck" id="idCheck" value="F"/>
                        </c:if>
                    </div>
                    <p class="join-feedback" id="idFeedback"></p>
                </div>

                <!-- 비밀번호 (회원가입) -->
                <c:if test="${mvo eq null}">
                <div class="join-field">
                    <label class="join-label" for="mpw">비밀번호 <span class="join-required">*</span></label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">lock</span>
                        <input type="password" name="mpw" id="mpw"
                               placeholder="비밀번호를 입력하세요"
                               class="auth-input" required
                               oninput="pwChk()"/>
                        <button type="button" class="auth-pw-toggle" onclick="togglePw('mpw',this)" tabindex="-1">
                            <span class="material-icons-round">visibility</span>
                        </button>
                    </div>
                </div>
                <div class="join-field">
                    <label class="join-label" for="mpwChk">비밀번호 확인 <span class="join-required">*</span></label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">lock_outline</span>
                        <!-- ★ 원본 name/id: mpwChk -->
                        <input type="password" name="mpwChk" id="mpwChk"
                               placeholder="비밀번호를 다시 입력하세요"
                               class="auth-input"
                               oninput="pwChk()"/>
                        <button type="button" class="auth-pw-toggle" onclick="togglePw('mpwChk',this)" tabindex="-1">
                            <span class="material-icons-round">visibility</span>
                        </button>
                    </div>
                    <p class="join-feedback pwConfirm" id="pwFeedback"></p>
                </div>
                </c:if>

                <!-- 비밀번호 변경 (수정) -->
                <c:if test="${mvo ne null}">
                <div class="join-field">
                    <label class="join-label" for="mpw">비밀번호 변경 <span class="join-optional">(선택)</span></label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">lock</span>
                        <input type="password" name="mpw" id="mpw"
                               placeholder="변경할 비밀번호 입력 (미입력 시 유지)"
                               class="auth-input"/>
                        <button type="button" class="auth-pw-toggle" onclick="togglePw('mpw',this)" tabindex="-1">
                            <span class="material-icons-round">visibility</span>
                        </button>
                    </div>
                </div>
                </c:if>

                <!-- 생년월일 -->
                <div class="join-field">
                    <label class="join-label" for="mbirth">생년월일</label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">cake</span>
                        <input type="date" name="mbirth" id="mbirth"
                               class="auth-input"
                               value="<c:out value='${mvo eq null ? "" : mvo.mbirth}'/>"
                               <c:out value="${mvo ne null ? 'readonly' : ''}"/>/>
                    </div>
                </div>
            </div>

            <div class="join-divider"></div>

            <!-- ── STEP 2 : 연락처 ── -->
            <div class="join-section" id="joinStep2">
                <div class="join-section-title">
                    <span class="material-icons-round">contact_phone</span>
                    연락처
                </div>

                <!-- 전화번호 -->
                <div class="join-field">
                    <label class="join-label" for="mphone">전화번호</label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">phone</span>
                        <input type="text" name="mphone" id="mphone"
                               placeholder="010-0000-0000"
                               class="auth-input"
                               value="<c:out value='${mvo eq null ? "" : mvo.mphone}'/>"/>
                    </div>
                </div>

                <!-- 이메일 -->
                <div class="join-field">
                    <label class="join-label" for="mmail">이메일</label>
                    <div class="auth-input-wrap">
                        <span class="material-icons-round auth-input-icon">mail</span>
                        <input type="email" name="mmail" id="mmail"
                               placeholder="example@email.com"
                               class="auth-input"
                               value="<c:out value='${mvo eq null ? "" : mvo.mmail}'/>"/>
                    </div>
                </div>
            </div>

            <!-- 제출 버튼 -->
            <div class="join-submit-wrap">
                <c:choose>
                    <c:when test="${mvo eq null}">
                        <button type="button" class="auth-submit-btn" onclick="validationFun()">
                            <span class="material-icons-round">person_add</span>
                            가입하기
                        </button>
                        <p class="join-login-link">
                            이미 계정이 있나요?
                            <a href="/login" class="auth-link-btn">로그인하기</a>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="auth-submit-btn" onclick="upValidFun()">
                            <span class="material-icons-round">save</span>
                            수정 완료
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>

        </form>
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
    function togglePw(inputId, btn) {
        const input = document.getElementById(inputId);
        const icon  = btn.querySelector('.material-icons-round');
        if (input.type === 'password') {
            input.type = 'text';
            icon.textContent = 'visibility_off';
        } else {
            input.type = 'password';
            icon.textContent = 'visibility';
        }
    }

    function pwChk() {
        const pw  = document.getElementById('mpw').value;
        const chk = document.getElementById('mpwChk').value;
        const fb  = document.getElementById('pwFeedback');
        if (!chk) { fb.textContent = ''; fb.className = 'join-feedback'; return; }
        if (pw === chk) {
            fb.textContent = '✓ 비밀번호가 일치해요';
            fb.className   = 'join-feedback join-feedback--ok';
        } else {
            fb.textContent = '✗ 비밀번호가 일치하지 않아요';
            fb.className   = 'join-feedback join-feedback--err';
        }
    }
</script>

</body>
</html>