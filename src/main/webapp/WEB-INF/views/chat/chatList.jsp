<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 목록 - 양파마켓</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css" href="/resources/css/other.css">
<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script defer src="/resources/js/main.js"></script>
</head>
<body>

<header class="header">
    <div class="header-inner">
        <a href="/" class="logo">
            <span class="logo-icon">🧅</span>
            <span class="logo-text">양파마켓</span>
        </a>
        <nav class="header-nav">
            <a href="javascript:history.back();" class="nav-btn nav-btn--outline">
                <span class="material-icons-round" style="font-size:17px;">arrow_back</span> 뒤로가기
            </a>
            <a href="/member/mypage" class="nav-btn nav-btn--fill">마이페이지</a>
        </nav>
    </div>
</header>

<main class="other-wrap">
    <div class="other-inner" style="max-width:680px;">
        <div class="other-title-row">
            <div>
                <h2 class="other-title">💬 채팅 목록</h2>
                <p class="other-subtitle">진행 중인 거래 채팅을 확인해요</p>
            </div>
            <c:if test="${not empty cList}">
                <div class="report-total-badge">총 <strong>${cList.size()}</strong>개</div>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${not empty cList}">
                <ul class="chat-list" style="list-style: none; padding: 0;">
                    <c:forEach items="${cList}" var="cvo">
                        <li class="chat-room-item" id="room-${cvo.roomNo}" style="margin-bottom: 12px;">
                            <div class="chat-item chat-room-card btn-chat-room" 
                                 onclick="openChat('${cvo.roomNo}')"
                                 data-roomno="${cvo.roomNo}"
                                 style="display: flex; align-items: center; padding: 15px; border-radius: 12px; border: 1px solid #eee; cursor: pointer; position: relative;">
                                
                                <div class="chat-avatar" style="margin-right: 15px;">
                                    <c:choose>
                                        <c:when test="${not empty cvo.iphoto}">
                                            <img src="/upload/item/${cvo.iphoto}" alt="item" style="width: 50px; height: 50px; border-radius: 8px; object-fit: cover;" onerror="this.src='/resources/img/no-image.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/resources/img/default_user.png" alt="default" style="width: 50px; height: 50px; border-radius: 8px;">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="chat-info" style="flex: 1; min-width: 0;">
                                    <div class="chat-info-top" style="display: flex; justify-content: space-between; align-items: center;">
                                        <span class="chat-opponent-name" style="font-weight: 700; font-size: 16px; color: #333;">${cvo.opponentNickname}</span>
                                        <span class="chat-date" style="font-size: 11px; color: #999;">
                                            ${not empty cvo.lastCdate ? cvo.lastCdate.substring(11, 16) : cvo.crdate.substring(5, 10)}
                                        </span>
                                    </div>
                                    <div class="chat-info-middle" style="margin: 4px 0;">
                                        <p class="chat-last-message" style="font-size: 14px; color: #666; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin: 0;">
                                            <c:out value="${empty cvo.lastContent ? '대화 내용이 없습니다.' : cvo.lastContent}"/>
                                        </p>
                                    </div>
                                    <div class="chat-info-bottom">
                                        <span class="chat-item-title" style="font-size: 12px; color: #999;">
                                            <span style="background: #fff0f0; color: #f08080; padding: 1px 4px; border-radius: 3px; font-size: 10px;">상품</span> ${cvo.ititle}
                                        </span>
                                    </div>
                                </div>

                                <div style="display: flex; align-items: center; gap: 8px; margin-left: 10px;">
                                    <c:if test="${cvo.unreadCount > 0}">
                                        <div class="chat-unread-badge" style="background: #ff4d4d; color: white; border-radius: 12px; padding: 2px 8px; font-size: 11px; font-weight: bold;">
                                            ${cvo.unreadCount}
                                        </div>
                                    </c:if>
                                    <span class="material-icons-round" style="color: #ccc; font-size: 20px;">chevron_right</span>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="empty-state" style="text-align: center; padding: 50px 0;">
                    <div class="empty-icon" style="font-size: 40px; margin-bottom: 10px;">💬</div>
                    <p class="empty-text" style="color: #999;">진행 중인 채팅방이 없어요</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<footer class="footer">
    <div class="footer-inner">
        <div class="footer-logo"><span>🧅</span> 양파마켓</div>
        <p class="footer-desc">껍질을 벗길수록 더 알찬 거래, 양파마켓</p>
        <p class="footer-copy">© 2025 양파마켓. All rights reserved.</p>
    </div>
</footer>

<script>
    let chatPopup = null; 
    var listSocket = new SockJS("/chat/echo"); 
    
    listSocket.onopen = function() { console.log("소켓 연결 성공!"); };
    
    listSocket.onmessage = function(e) {
        var data = JSON.parse(e.data);
        var roomNo = data.roomNo;
        var content = data.content;
        var senderMno = data.senderMno; 
        var myMno = "${sessionScope.mvo.mno}"; 

        var $roomItem = $("#room-" + roomNo);
        if ($roomItem.length > 0) {
            $roomItem.find(".chat-last-message").text(content);
            $roomItem.find(".chat-date").text("방금 전");

            var isOther = (senderMno && myMno && String(senderMno) !== String(myMno));
            if (isOther) {
                let $badge = $roomItem.find(".chat-unread-badge");
                if ($badge.length > 0) {
                    $badge.text(parseInt($badge.text()) + 1).show();
                } else {
                    let newBadge = '<div class="chat-unread-badge" style="background: #ff4d4d; color: white; border-radius: 12px; padding: 2px 8px; font-size: 11px; font-weight: bold; display: inline-block;">1</div>';
                    $roomItem.find(".material-icons-round").before(newBadge);
                }
            }
            // 업데이트 후 정렬 실행
            sortChatRoom($roomItem);
        }
    };

    // [핵심] 방 위치를 정교하게 찾아주는 공통 함수
    function sortChatRoom($roomItem) {
        var $container = $(".chat-list");
        var hasBadge = $roomItem.find(".chat-unread-badge:visible").length > 0;
        // 현재 방의 시간을 가져옴 (예: "21:35")
        var currentTime = $roomItem.find(".chat-date").text().trim();

        if (hasBadge) {
            // 안 읽은 방은 무조건 맨 위
            $roomItem.prependTo($container);
        } else {
            var $target = null;
            $container.find(".chat-room-item").each(function() {
                var $this = $(this);
                if ($this.attr('id') === $roomItem.attr('id')) return true;

                var thisHasBadge = $this.find(".chat-unread-badge:visible").length > 0;
                var thisTime = $this.find(".chat-date").text().trim();

                // 1. 상대방 방이 '안 읽은 방'이면 무조건 그 아래로 가야 함
                // 2. 상대방 방이 '읽은 방'인데 나보다 시간이 최신(값이 큼)이면 그 아래로 가야 함
                if (thisHasBadge || thisTime > currentTime) {
                    $target = $this;
                } else {
                    return false; // 나보다 오래된 시간을 만나면 멈춤
                }
            });

            if ($target) {
                $roomItem.insertAfter($target);
            } else {
                $roomItem.prependTo($container);
            }
        }
    }

    function openChat(roomNo) {
        if (chatPopup && !chatPopup.closed && chatPopup.name === "chat_" + roomNo) {
            chatPopup.focus();
            return;
        }
        window.open("/chat/room?roomNo=" + roomNo, "chat_" + roomNo, "width=430, height=650");
        removeUnreadBadge(roomNo);
    }

    function removeUnreadBadge(roomNo) {
        let $roomItem = $("#room-" + roomNo);
        let $badge = $roomItem.find(".chat-unread-badge");
        if($badge.length > 0) {
            $badge.fadeOut(300, function() {
                sortChatRoom($roomItem); // 뱃지 사라진 후 정밀 정렬 호출
            });
        }
    }
</script>

</body>
</html>