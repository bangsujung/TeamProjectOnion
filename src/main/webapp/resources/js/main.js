// 비밀번호 확인
function pwChk(){
		let mpw = document.getElementById('mpw');
		let mpwChk = document.getElementById('mpwChk');
		let mpwconfirm = document.querySelector('.pwConfirm');
		
		if(mpw.value !== "" && mpwChk.value !== ""){
        if(mpw.value !== mpwChk.value){
            mpwconfirm.innerText = '비밀번호 불일치';
            mpwconfirm.style.color = 'red';
        } else {
            mpwconfirm.innerText = '비밀번호 일치';
            mpwconfirm.style.color = 'green';
        }
    } else {
        mpwconfirm.innerText = '';
    }
}

// 회원가입 유효성 검사
function validationFun(){
	console.log("회원가입 유효성검사");
	
	// 이름
	const mname = document.getElementById('mname');
	if(mname.value === ''){
		alert("이름을 입력하세요.");
		mname.focus();
		return false;
	}else{
		var exp = /^[가-힣]{2,5}$/;
		if(!exp.test(mname.value)){
			alert("이름을 최대 5자 이내로 입력하세요.");
			mname.focus();
			return false;
		}
	}
	
	// 패스워드
	let mpw = document.getElementById('mpw');
	if(mpw.value === ''){
		alert("패스워드를 입력하세요.");
		mpw.focus();
		return false;
	}else{
		let exp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,}$/;
		if(!exp.test(mpw.value)){
			alert("패스워드는 영대/소문자, 숫자조합 8자 이상 작성");
			mpw.focus();
			return false;
		}
	}
	
	// 패스워드 일치여부 확인
	let mpwChk = document.getElementById('mpwChk');
	if(mpw.value !== mpwChk.value){
		alert("패스워드가 일치하지 않습니다.");
		mpwChk.focus();
		return false;
	}
	
	// 아이디 중복체크 확인
	if(document.getElementById('idCheck').value === "F"){
		alert("아이디 중복 확인을 해주세요.");
		return false;
	}
	
	// 생년월일
    let mbirth = document.getElementById('mbirth');
    if(mbirth.value !== ''){
       let exp = /^\d{4}-\d{2}-\d{2}$/;
       if(!exp.test(mbirth.value)){
          alert('2003-06-07 형식으로 입력하세요.')
          mbirth.focus();
          return false;
       }
    }
    
	// 전화번호
    let mphone = document.getElementById('mphone');
    if(mphone.value === ''){
       alert("전화번호를 입력하세요.");
       mphone.focus();
       return false;
    }else{
       var exp = /^\d{3}-\d{4}-\d{4}$/;
       if(!exp.test(mphone.value)){
          alert("010-0000-0000 형식으로 입력하세요.");
          mphone.focus();
          return false;
       }
    }
    
	// 이메일
	let mmail = document.getElementById('mmail');
	if(mmail.value !== ''){
		var exp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		if(!exp.test(mmail.value)){
			alert("이메일을 형식에 맞춰 입력해주세요.");
			mmail.focus();
			return false;
		}
	}
	
	document.memberForm.action='/member/join';
	document.memberForm.method='POST';
	document.memberForm.submit();

}

// 아이디 중복 체크
function idChk(){
	console.log('아이디 중복 확인');
	// 아이디
	const mid = document.getElementById('mid');
	
	if(mid.value === ''){
		alert("아이디를 입력하세요.");
		mid.focus();
		return false;
	}else{
		var exp = /^(?=.*[a-z])(?=.*[0-9])[a-z0-9]{5,15}$/;
		if(!exp.test(mid.value)){
			alert("아이디는 영어소문자, 숫자조합 5~15자 이내로 작성하세요");
			mid.focus();
			return false;
		}
	}
	
		$.ajax({
			type : "post", 
			url : "/member/idChk", 
			data : { 
				"mid" : mid.value
			},
			success : function(cnt){ 
				console.log("cnt >> " + cnt);
				if(cnt == 0){
					alert("사용가능한 아이디입니다.");
					$("#idCheck").val("T");
					mid.readOnly = true;
					return true;
				}else{
					alert("이미 존재하는 아이디입니다.");
					mid.value = "";
					mid.focus();
				}
			},
			error : function(err){ 
				console.log(err);
			}
		});
}

// 로그인 확인
function login(form){
	let mid = document.getElementById("mid");
	if(mid.value === ''){
		alert("아이디를 입력해주세요.");
		return false;
	}
	let mpw = document.getElementById("mpw");
	if(mpw.value === ''){
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	
	form.action = "/login";
	form.method = "post";
	form.submit();
	
}

// 회원수정 함수
function upValidFun(){
	console.log("회원수정 유효성검사");
	
	// 1. 이름 (한글 2~5자)
	const mname = document.getElementById('mname');
    if(mname.value.trim() === '') {
        alert("이름을 입력하세요.");
        mname.focus();
        return false;
    }else{
        const nameExp = /^[가-힣]{2,5}$/;
        if(!nameExp.test(mname.value)) {
            alert("이름은 한글 2~5자 이내로 입력하세요.");
            mname.focus();
            return false;
        }
    }
	
	// 2. 생년월일 (yyyy-MM-dd 형식)
    const mbirth = document.getElementById('mbirth');
    if(mbirth.value.trim() === '') {
        alert("생년월일을 입력하세요.");
        mbirth.focus();
        return false;
    }else{
        const birthExp = /^\d{4}-\d{2}-\d{2}$/;
        if(!birthExp.test(mbirth.value)) {
            alert("생년월일은 2001-01-15 형식으로 입력하세요.");
            mbirth.focus();
            return false;
        }
    }

    // 3. 전화번호 (010-0000-0000)
    const mphone = document.getElementById('mphone');
    if(mphone.value.trim() === '') {
        alert("전화번호를 입력하세요.");
        mphone.focus();
        return false;
    }else{
        const phoneExp = /^\d{3}-\d{4}-\d{4}$/;
        if(!phoneExp.test(mphone.value)) {
            alert("전화번호는 010-0000-0000 형식으로 입력하세요.");
            mphone.focus();
            return false;
        }
    }

    // 4. 이메일
    const mmail = document.getElementById('mmail');
    if(mmail.value.trim() === '') {
        alert("이메일을 입력하세요.");
        mmail.focus();
        return false;
    }else{
        const emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,}$/;
        if(!emailExp.test(mmail.value)) {
            alert("이메일 형식이 올바르지 않습니다.");
            mmail.focus();
            return false;
        }
    }
    // 모든 검사 통과 시 최종 확인 후 전송
    if(confirm("회원 정보를 수정하시겠습니까?")) {
        const form = document.memberForm;
	    document.memberForm.action = '/member/up';
		document.memberForm.method = 'post';
		document.memberForm.submit();
	}
}

// 회원탈퇴 팝업
function popup(){
	let popupEl = document.querySelector(".popup");
	console.log("회원탈퇴 팝업");
	
	if(!popupEl.classList.contains('show')){
		popupEl.classList.add('show');
	}
}

function pwConfirm(){
	let mpw = document.getElementById('delPw').value;
	let mid = $('#mid').val();
	
	if(mpw !== ''){
		$.ajax({
			type : 'post',
			url : '/pwConfirm',
			data : {
				mid:mid,
				mpw:mpw
			},
			success:function(data){
				//비밀번호 일치 여부
				console.log(data);
				if(data === 'true'){
					document.delForm.action = '/member/del';
					document.delForm.method = 'post';
					document.delForm.submit();
				}else{
					alert("비밀번호가 일치하지 않습니다.");
				}
			},
			error : function(err){
				console.log("에러 발생!", err);
			}
		});
	}else{
		alert("비밀번호를 입력해주세요.");
	}
}

// 팝업 열기
function openPopup() {
    const popup = document.getElementById('popupBg');
    popup.classList.add('show');
}

// 팝업 닫기
function closePopup() {
    const popup = document.getElementById('popupBg');
    popup.classList.remove('show');
}

//상품 삭제
function itemDelete(){
   
    let ipw = $("#ipw").val();

    if(ipw === ""){
        alert("비밀번호를 입력하세요.");
        return;
    }

    $.ajax({
        type : "post",
        url : "/item/pkChk",
        data : {
            ino : ino,
            ipw : ipw
        },
        success : function(data){

            if(data === "true"){

                if(confirm("정말 삭제하시겠습니까?")){
                    $("#delForm")
                    .attr("action","/item/del")
                    .attr("method","post")
                    .submit();
                }

            }else{
                alert("비밀번호가 틀립니다.");
            }

        },
        error : function(err){
            console.log(err);
        }

    });

}

//비번 확인
function pwConfirm(){
   let mpw = document.getElementById('mpw').value;
   console.log(mpw);
   let mid = $('#mid').val();
   console.log(mid);
   if(mpw !== ''){
      $.ajax({
         type : 'post',
         url : '/pwConfirm',
         data : {
            mid : mid,
            mpw : mpw,
         },
         success : function(data){
            //비밀번호 일치 여부 확인
            console.log(data);
            if(data == 'true'){
               document.memberForm.action = '/member/del';
               document.memberForm.method = 'post';
               document.memberForm.submit();
            }else if(data === "false"){
               alert("비밀번호가 일치하지 않습니다.");
               return false;
            }
         },
         error : function(err){
            console.log(err);
         }
      })
   }
}

//삭제 비밀번호 팝업
function openDeletePopup(){
    $("#deletePopup").show();
}

function closeDeletePopup(){
    $("#deletePopup").hide();
}

//찜등록
let wishProcessing = false; // 전역 플래그

function wishAction(){
    if(wishProcessing) return; // 중복 호출 방지
    wishProcessing = true;

    $.ajax({
        type : "POST",
        url : "/wish/write",
        data : {
            ino : ino
        },
        success : function(data){
            console.log("data >> " + data);
            if(data === "LOGIN_RE"){
                alert("로그인 후 이용해주세요.");
                location.href="/member/login";
            } else if(data === "1"){
                alert("찜 목록에 추가되었습니다.");
                location.href = "/item/one?ino=" + ino;
            } else if(data === "2"){
                alert("이미 찜한 상품입니다.");
                location.href = "/item/one?ino=" + ino; // 페이지 갱신해서 버튼 상태 업데이트
            } else {
                alert("찜 등록 실패");
            }
        },
        error : function(err){
            console.log(err);
            alert("관리자에게 문의하세요.");
        },
        complete : function(){
            wishProcessing = false; // 완료 후 플래그 초기화
        }
    });
}

// 찜 취소 
function wishCancel(ino) {
    $.ajax({
        type : 'post',
        url : '/wish/cancel',
        data : { 
            'ino': ino 
        },
        success: function(data) {
            if (data === "LOGIN_RE") {
                alert("로그인이 필요한 서비스입니다.");
                location.href = "/member/login"; 
            } else if (data === "OK") {
                alert("찜이 취소되었습니다.");
                location.reload(); 
            } else {
                alert("처리 중 에러가 발생했습니다.");
            }
        }
    });
}

// 신고 팝업 열기
function openReportPopup() {
    $("#reportPopup").show();
}

// 신고 팝업 닫기
function closeReportPopup() {
    $("#reportPopup").hide();
    $("#reportId").val(""); 
}

function submitReport() {
    let inputId = $("#reportId").val();
    let sellerId = $("#sellerId").val();
    let targetMno = $("#targetMno").val();
    let currentIno = ino; // JSP 하단 스크립트에서 선언한 let ino = "${CURR.ino}";

    if (inputId !== sellerId) {
        alert("판매자 아이디가 일치하지 않습니다.");
        return;
    }

    if (confirm("정말 이 유저를 신고하시겠습니까?")) {
        let form = document.createElement("form");
        form.method = "POST";
        form.action = "/report/write";

        // 신고 대상자 번호
        let inputMno = document.createElement("input");
        inputMno.type = "hidden";
        inputMno.name = "mno";
        inputMno.value = targetMno;
        form.appendChild(inputMno);

        // 돌아올 상품 번호
        let inputIno = document.createElement("input");
        inputIno.type = "hidden";
        inputIno.name = "ino";
        inputIno.value = currentIno;
        form.appendChild(inputIno);

        document.body.appendChild(form);
        form.submit();
    }
}

function submitReportMyPage() {
    let inputId = $("#reportId").val(); 
    if (inputId === "") {
        alert("신고할 유저의 아이디를 입력해주세요.");
        return;
    }

    if (confirm(inputId + " 유저를 정말 신고하시겠습니까?")) {
        let form = document.createElement("form");
        form.method = "POST";
        form.action = "/report/write";

        let inputMid = document.createElement("input");
        inputMid.type = "hidden";
        inputMid.name = "mid"; 
        inputMid.value = inputId;

        form.appendChild(inputMid);
        document.body.appendChild(form);
        form.submit();
    }
}

//home.jsp에서 이름 클릭하면 창 계속 뜨게 하기 위함
// 유저 아바타 클릭 토글
const userAvatar = document.querySelector('.user-avatar');

if(userAvatar) {
    userAvatar.addEventListener('click', function(e) {
        e.stopPropagation();
        const userDropdown = document.querySelector('.user-dropdown');
        if(userDropdown) userDropdown.classList.toggle('active');
    });
}

// 바깥 클릭시 닫기
document.addEventListener('click', function() {
    const userDropdown = document.querySelector('.user-dropdown');
    if(userDropdown) userDropdown.classList.remove('active');
});

// 드롭다운 내부 링크 클릭 시 명시적으로 닫기
const userDropdown = document.querySelector('.user-dropdown');
if(userDropdown) {
    userDropdown.querySelectorAll('a').forEach(function(link) {
        link.addEventListener('click', function() {
            userDropdown.classList.remove('active');
        });
    });
}