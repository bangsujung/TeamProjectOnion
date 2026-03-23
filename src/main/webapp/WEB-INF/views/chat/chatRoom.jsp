<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/other.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
    integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script defer src="/resources/js/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
</head>
<body class="chatroom-page">

<div class="chatroom-wrap">

    <!-- ===== 헤더 ===== -->
    <div class="chatroom-header">
        <div class="chatroom-header-inner">
            <button class="chatroom-back-btn" onclick="window.close()">
             <span class="material-icons-round">close</span>
         </button>
            <div class="chatroom-header-info">
                <span class="chatroom-header-icon">🧅</span>
                <span class="chatroom-header-title">채팅방</span>
            </div>
            <div style="width:36px;"></div><!-- 레이아웃 균형용 -->
        </div>
    </div>

    <!-- ===== 메시지 영역 ===== -->
    <div class="chatroom-messages" id="msgArea">
        <c:choose>
            <c:when test="${not empty msgList}">
                <c:forEach var="msg" items="${msgList}">
                    <c:set var="isMe" value="${msg.senderMno eq mno}"/>
                    <div class="msg-row ${isMe ? 'msg-row--me' : 'msg-row--other'}">
                        <!-- 채팅방 상대 프로필을 아이디 첫글자로 -->
                        <c:if test="${!isMe}">
                          <div class="msg-avatar">${fn:substring(msg.senderMid, 0, 1)}</div>
                       </c:if>
                        <div class="msg-col">
                            <div class="msg-bubble ${isMe ? 'msg-bubble--me' : 'msg-bubble--other'}">
                                ${msg.content}
                            </div>
                            <span class="msg-time">${msg.cdate}</span>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="chatroom-empty">
                    <span style="font-size:36px;">💬</span>
                    <p>첫 메시지를 보내보세요!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ===== 입력창 ===== -->
    <div class="chatroom-input-wrap">
        <div class="chatroom-input-inner">
            <input type="text" id="msgInput"
                   placeholder="메시지를 입력하세요"
                   class="chatroom-input" autocomplete="off"/>
            <button id="btnSend" class="chatroom-send-btn">
                <span class="material-icons-round">send</span>
            </button>
        </div>
    </div>

</div>

<script>
    // 1. URL 파라미터에서 roomNo 추출 (상세페이지에서 직접 올 때 필요)
    function getParam(name) {
        var currUrl = window.location.search;
        var urlParams = new URLSearchParams(currUrl);
        return urlParams.get(name);
    }

    // 2. 서버 전달값("${roomNo}")이 없으면 URL 파라미터에서 가져옴
    var roomNo = "${roomNo}" || getParam("roomNo");
    var myMno  = "${mno}"; 

    if (!roomNo) {
        alert("방 번호를 찾을 수 없습니다.");
        window.close();
    }

    // 3. 소켓 연결 (반드시 roomNo가 결정된 후 실행!)
    var socket = new SockJS("/chat/echo?roomNo=" + roomNo);

    $(document).ready(function() {
        console.log("채팅방 연결 시도 - 방번호:", roomNo);
        
        /* 부모 창 뱃지 제거 */
        if(window.opener && !window.opener.closed && typeof window.opener.removeUnreadBadge === 'function') {
            window.opener.removeUnreadBadge(roomNo);
        }

        markAsRead(roomNo);
        scrollToBottom();

        $("#btnSend").click(function() { sendMsg(); });

        $("#msgInput").keypress(function(e) {
            if(e.which === 13) { e.preventDefault(); sendMsg(); }
        });
    });

    /* 실시간 메시지 수신 로직 */
    socket.onmessage = function(e) {
        var data = JSON.parse(e.data);
        
        // [가장 중요] myMno와 data.senderMno를 엄격하게 비교합니다.
        // 두 값을 모두 문자열로 변환(String)해서 비교하면 절대 틀리지 않아요!
        var isMe = (String(data.senderMno) === String(myMno));

        // 만약 이미 내가 보낸 메시지를 화면에 그리는 로직이 sendMsg에 '있다면' 
        // 여기(onmessage)서는 내가 보낸 걸 그리지 말아야 합니다.
        // 하지만 우리는 '서버를 거쳐온 데이터'만 그리기로 했으므로, 
        // 아래 HTML 조립 로직은 그대로 두되 isMe 판단만 정확히 하면 됩니다.

        var firstChar = data.senderMid ? data.senderMid.charAt(0).toUpperCase() : '?';
        var avatarHtml = isMe ? '' : '<div class="msg-avatar">' + firstChar + '</div>';
        var rowCls     = isMe ? 'msg-row--me'    : 'msg-row--other';
        var bubbleCls  = isMe ? 'msg-bubble--me' : 'msg-bubble--other';
        var time       = data.cdate || '방금 전';

        var html = '<div class="msg-row ' + rowCls + '">'
                 + avatarHtml
                 + '<div class="msg-col">'
                 + '<div class="msg-bubble ' + bubbleCls + '">' + data.content + '</div>'
                 + '<span class="msg-time">' + time + '</span>'
                 + '</div></div>';

        $('.chatroom-empty').remove();
        $("#msgArea").append(html);
        scrollToBottom();

        // 상대방이 보낸 거라면 읽음 처리
        if (!isMe) {
            markAsRead(roomNo);
            if (window.opener && !window.opener.closed && typeof window.opener.removeUnreadBadge === 'function') {
                window.opener.removeUnreadBadge(roomNo);
            }
        }
    };

    /* 메시지 전송 */
    function sendMsg() {
        var content = $("#msgInput").val().trim();
        if(content === "") return;
        
        // [핵심] 여기서 $("#msgArea").append(...) 같은 코드가 있다면 무조건 지우세요!
        // 화면에 그리는 건 오직 socket.onmessage가 담당하게 합니다.
        
        socket.send(JSON.stringify({ 
            roomNo: roomNo, 
            senderMno: myMno, 
            content: content 
        }));
        
        $("#msgInput").val("").focus();
        // scrollToBottom(); // 전송 직후엔 여기서 안 해도 onmessage에서 해줄 거예요.
    }
    /* 읽음 처리 */
    function markAsRead(roomNo) {
        $.ajax({
            url: "/chat/read",
            type: "POST",
            data: { roomNo: roomNo },
            success: function() { console.log("읽음 처리 완료"); }
        });
    }

    /* 스크롤 최하단 */
    function scrollToBottom() {
        var area = document.getElementById("msgArea");
        if(area) area.scrollTop = area.scrollHeight;
    }

    /* 팝업 창이 닫힐 때 부모 창 상태 정리 */
    window.onbeforeunload = function() {
        if (window.opener && !window.opener.closed) {
            // 1. 부모 창의 '활성화된 회색 배경' 제거 (새끼야, 이거지! 🧅)
            if (typeof window.opener.$ === 'function') {
                window.opener.$(".chat-item").removeClass("chat-room-card--active");
                
                // 2. 혹시 상세페이지에서 넘어온 변수가 남아있다면 초기화
                window.opener.targetRoom = "";
            }
            
            // 3. (선택사항) 만약 메시지를 읽었으니 목록의 숫자나 순서를 갱신해야 한다면 새로고침 실행
            // 새로고침이 싫다면 아래 줄은 주석 처리하세요.
            // window.opener.location.reload(); 
        }
    };

    socket.onopen  = function() { console.log("WebSocket 연결 성공"); };
    socket.onclose = function() { console.log("WebSocket 연결 종료"); };
</script>

</body>
</html>
