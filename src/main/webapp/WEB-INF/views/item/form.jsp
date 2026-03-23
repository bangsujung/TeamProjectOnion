<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${ivo eq null ? '상품 등록' : '상품 수정'} - 양파마켓</title>
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
    if(msg === "ITEM_WRT_ERR") alert("상품 등록에 실패했어요. 관리자에게 문의하세요.");
    if(msg === "I_UP_ERR")     alert("상품 수정에 실패했어요. 관리자에게 문의하세요.");
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
            <a href="<c:url value='/item/list${sc.queryString}'/>" class="nav-btn nav-btn--outline">
                <span class="material-icons-round" style="font-size:17px;">arrow_back</span>
                목록으로
            </a>
        </nav>
    </div>
</header>

<!-- ===== 본문 ===== -->
<main class="iwrite-wrap">
    <div class="iwrite-inner">

        <div class="iwrite-title-row">
            <h2 class="iwrite-title">${ivo eq null ? '🧅 상품 등록' : '🧅 상품 수정'}</h2>
            <p class="iwrite-subtitle">${ivo eq null ? '판매할 상품 정보를 입력해주세요' : '상품 정보를 수정해주세요'}</p>
        </div>

        <form action="${ivo eq null ? '/item/write' : '/item/up'}"
              method="post" enctype="multipart/form-data"
              class="iwrite-form" id="iwriteForm">

            <input type="hidden" name="ino" id="ino" value="${ivo.ino}">
            <input type="hidden" name="iid" value="${ivo.iid}">

            <div class="iwrite-section">
                <div class="iwrite-section-title">
                    <span class="material-icons-round">info</span>기본 정보
                </div>

                <div class="iwrite-field">
                    <label class="iwrite-label" for="ititle">상품 제목 <span class="iwrite-required">*</span></label>
                    <div class="iwrite-input-wrap">
                        <span class="material-icons-round iwrite-input-icon">title</span>
                        <input type="text" name="ititle" id="ititle" value="${ivo.ititle}"
                               placeholder="상품 제목을 입력하세요" class="iwrite-input" required/>
                    </div>
                </div>

                <div class="iwrite-field">
                    <label class="iwrite-label" for="ipw">수정/삭제용 비밀번호 <span class="iwrite-required">*</span></label>
                    <div class="iwrite-input-wrap">
                        <span class="material-icons-round iwrite-input-icon">lock</span>
                        <input type="password" name="ipw" id="ipw"
                               placeholder="게시글 수정·삭제 시 필요한 비밀번호"
                               class="iwrite-input" required/>
                        <button type="button" class="iwrite-pw-toggle" onclick="toggleIpw(this)" tabindex="-1">
                            <span class="material-icons-round">visibility</span>
                        </button>
                    </div>
                </div>

                <div class="iwrite-field">
                    <label class="iwrite-label">카테고리 <span class="iwrite-required">*</span></label>
                    <div class="iwrite-select-wrap">
                        <select name="icategory" class="iwrite-select" required>
                            <option value="">카테고리 선택</option>
                            <option value="디지털/가전">디지털/가전</option>
                            <option value="가구/인테리어">가구/인테리어</option>
                            <option value="의류/패션">의류/패션</option>
                            <option value="도서/문구">도서/문구</option>
                            <option value="스포츠/레저">스포츠/레저</option>
                            <option value="유아동">유아동</option>
                            <option value="뷰티/미용">뷰티/미용</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                </div>

                <div class="iwrite-field">
                    <label class="iwrite-label" for="icontent">상품 설명</label>
                    <div class="iwrite-textarea-wrap">
                        <textarea name="icontent" id="icontent" rows="6"
                                  placeholder="상품 상태, 구매 시기, 하자 여부 등을 자세히 적어주세요"
                                  class="iwrite-textarea">${ivo.icontent}</textarea>
                        <span class="iwrite-textarea-count" id="contentCount">0 / 500</span>
                    </div>
                </div>

                <c:if test="${ivo ne null}">
                <div class="iwrite-field">
                    <label class="iwrite-label" for="ideal">거래 상태</label>
                    <div class="iwrite-select-wrap">
                        <span class="material-icons-round iwrite-input-icon">swap_horiz</span>
                        <select name="ideal" id="ideal" class="iwrite-select">
                            <option value="0" ${ivo.ideal == 0 ? 'selected' : ''}>🟡 거래대기</option>
                            <option value="1" ${ivo.ideal == 1 ? 'selected' : ''}>🔵 거래중</option>
                            <option value="2" ${ivo.ideal == 2 ? 'selected' : ''}>✅ 거래완료</option>
                            <option value="3" ${ivo.ideal == 3 ? 'selected' : ''}>❌ 거래취소</option>
                        </select>
                    </div>
                </div>
                </c:if>
            </div>

            <div class="iwrite-divider"></div>

            <div class="iwrite-section">
                <div class="iwrite-section-title">
                    <span class="material-icons-round">photo_camera</span>
                    상품 사진
                    <span class="iwrite-section-hint" id="photoCountHint">0 / 10장</span>
                </div>

                <div class="iwrite-upload-area" id="uploadArea"
                     onclick="document.getElementById('fileItem').click()"
                     ondragover="handleDragOver(event)"
                     ondrop="handleDrop(event)">
                    <span class="material-icons-round iwrite-upload-icon">add_photo_alternate</span>
                    <p class="iwrite-upload-text">클릭하거나 사진을 드래그해서 올려주세요</p>
                    <p class="iwrite-upload-hint">JPG, PNG, GIF · 최대 10MB · 최대 10장</p>
                </div>

                <input type="file" name="files" id="fileItem"
                       accept="image/*" multiple style="display:none;">

                <div class="iwrite-preview-area" id="imagePreview">
                    <div class="iwrite-preview-wrapper" id="previewWrapper">
                        <c:choose>
                            <c:when test="${not empty ivo.iphoto}">
                                <div class="iwrite-img-card iwrite-img-card--existing">
                                    <c:set var="firstPhoto" value="${fn:split(ivo.iphoto, ',')[0]}" />
									<img src="/upload/item/${fn:trim(firstPhoto)}" class="iwrite-preview-img" alt="기존 사진">
                                    <div class="iwrite-img-badge">기존 사진</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="iwrite-preview-empty" id="previewEmpty">
                                    <span class="material-icons-round">image_not_supported</span>
                                    <p>선택된 사진이 없어요</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="iwrite-btn-row">
                <button type="button" class="iwrite-btn iwrite-btn--cancel" onclick="history.back();">
                    <span class="material-icons-round">close</span>취소
                </button>
                <%-- type="button" 으로 바꾸고 JS에서 직접 submit --%>
                <button type="button" class="iwrite-btn iwrite-btn--submit" id="submitBtn">
                    <span class="material-icons-round">${ivo eq null ? 'upload' : 'save'}</span>
                    ${ivo eq null ? '등록하기' : '수정하기'}
                </button>
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
    const MAX_PHOTOS = 10;
    let fileList = [];

    const fileInput      = document.getElementById('fileItem');
    const previewWrapper = document.getElementById('previewWrapper');
    const countHint      = document.getElementById('photoCountHint');

    /* ── 비밀번호 표시/숨기기 ── */
    function toggleIpw(btn) {
        const input = btn.closest('.iwrite-input-wrap').querySelector('input');
        const icon  = btn.querySelector('.material-icons-round');
        input.type  = input.type === 'password' ? 'text' : 'password';
        icon.textContent = input.type === 'password' ? 'visibility' : 'visibility_off';
    }

    /* ── 글자 수 카운터 ── */
    const contentEl = document.getElementById('icontent');
    const countEl   = document.getElementById('contentCount');
    function updateCount() {
        const len = contentEl.value.length;
        countEl.textContent = len + ' / 500';
        countEl.style.color = len > 450 ? '#e74c3c' : 'var(--gray-3)';
    }
    contentEl.addEventListener('input', updateCount);
    updateCount();

    /* ── 파일 선택 ── */
    fileInput.addEventListener('change', function () {
        addFiles(Array.from(this.files));
        this.value = '';
    });

    /* ── 파일 추가 ── */
    function addFiles(newFiles) {
        const images    = newFiles.filter(f => f.type.startsWith('image/'));
        const available = MAX_PHOTOS - fileList.length;
        if (available <= 0) {
            alert('사진은 최대 ' + MAX_PHOTOS + '장까지 올릴 수 있어요.');
            return;
        }
        if (images.length > available) {
            alert(available + '장만 더 추가할 수 있어요. 초과분은 제외됩니다.');
        }
        fileList = fileList.concat(images.slice(0, available));
        renderPreviews();
    }

    /* ── 미리보기 렌더링 ── */
    function renderPreviews() {
        previewWrapper.innerHTML = '';
        countHint.textContent = fileList.length + ' / ' + MAX_PHOTOS + '장';

        if (fileList.length === 0) {
            previewWrapper.innerHTML =
                '<div class="iwrite-preview-empty">' +
                '<span class="material-icons-round">image_not_supported</span>' +
                '<p>선택된 사진이 없어요</p></div>';
            return;
        }

        fileList.forEach(function (file, index) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const card = document.createElement('div');
                card.classList.add('iwrite-img-card');

                const img = document.createElement('img');
                img.src   = e.target.result;
                img.classList.add('iwrite-preview-img');
                img.alt   = file.name;

                const del = document.createElement('button');
                del.type  = 'button';
                del.classList.add('iwrite-img-del');
                del.innerHTML = '<span class="material-icons-round">close</span>';
                del.onclick = (function (i) {
                    return function () {
                        fileList.splice(i, 1);
                        renderPreviews();
                    };
                })(index);

                card.appendChild(img);
                card.appendChild(del);
                previewWrapper.appendChild(card);
            };
            reader.readAsDataURL(file);
        });
    }

    /* ── 등록/수정 버튼: DataTransfer 동기화 후 submit ── */
    document.getElementById('submitBtn').addEventListener('click', function () {
        if (fileList.length > 0) {
            try {
                const dt = new DataTransfer();
                fileList.forEach(function (f) { dt.items.add(f); });
                fileInput.files = dt.files;
            } catch (e) {
                console.warn('DataTransfer 미지원:', e);
            }
        }
        document.getElementById('iwriteForm').submit();
    });

    /* ── 드래그 앤 드롭 ── */
    const uploadArea = document.getElementById('uploadArea');
    function handleDragOver(e) {
        e.preventDefault();
        uploadArea.classList.add('iwrite-upload-area--drag');
    }
    function handleDrop(e) {
        e.preventDefault();
        uploadArea.classList.remove('iwrite-upload-area--drag');
        addFiles(Array.from(e.dataTransfer.files));
    }
    uploadArea.addEventListener('dragleave', function () {
        this.classList.remove('iwrite-upload-area--drag');
    });
</script>

</body>
</html>
