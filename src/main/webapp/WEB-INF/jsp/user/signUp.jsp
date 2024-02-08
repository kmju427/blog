<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<div class="profile">
			<div class="profile-box">
				<h2 class="mt-2">회원가입</h2>
				
				<div class="mt-3">
					<span class="profile-span">프로필 설정</span><br>
					<span>나중에 언제든지 추가, 변경할 수 있습니다.</span>
					<div class="file-upload d-flex justify-content-center">
						<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것과 같은 효과 --%>
						<input type="file" id="file" accept=".jpg, .jpeg, .gif, .png" class="d-none">
						
						<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
						<a href="#" id="fileUploadBtn" class="mt-2 mb-2"><img id="profileImage" width="65" src="https://cdn.pixabay.com/photo/2017/07/11/13/56/user-2493635_1280.png"></a>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<form id="signUpForm" method="post" action="/user/sign-up">
			<span class="sign-up-subject">아이디</span>
			<div class="d-flex ml-3 mt-2">
				<input type="text" id="loginId" name="loginId" class="form-control col-7" placeholder="아이디를 입력해주세요.">
				<button type="button" id="loginIdCheckBtn" class="btn ml-2">중복 확인</button>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<div class="ml-3 mt-2 mb-2">
				<div id="idCheckLength" class="small text-danger d-none">아이디를 4자 이상 입력하세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용 중인 아이디입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 아이디입니다.</div>
			</div>
			
			<span class="sign-up-subject">비밀번호</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="password" name="password" class="form-control col-7" placeholder="비밀번호를 입력해주세요.">
			</div>
			
			<span class="sign-up-subject">비밀번호 확인</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="password" name="confirmPassword" class="form-control col-7" placeholder="비밀번호를 입력해주세요.">
			</div>
			
			<span class="sign-up-subject">이름</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="name" class="form-control col-7" placeholder="이름을 입력해주세요.">
			</div>
			
			<span class="sign-up-subject">이메일</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="email" class="form-control col-7" placeholder="이메일을 입력해주세요.">
			</div>
			
			<span class="sign-up-subject">닉네임</span>
			<div class="d-flex ml-3 mt-2 mb-2">
				<input type="text" name="nickname" class="form-control col-7" placeholder="닉네임을 입력해주세요.">
				<button type="button" id="nicknameCheckBtn" class="btn ml-2">중복 확인</button>
			</div>
			
			<br>
			<div class="d-flex justify-content-center m-2">
				<button type="submit" id="signUpBtn" class="btn">가입하기</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 파일 업로드 이미지 클릭 -> 숨겨져 있는 id="file" 동작시킨다.
		$("#fileUploadBtn").on('click', function(e) {
			e.preventDefault(); // a 태그의 기본 동작을 멈춤(스크롤 위로 올라가는 것)
			$("#file").click(); // input file을 클릭한 효과
		});
		
		// 사용자가 업로드할 이미지를 선택하는 순간 유효성 확인 및 업로드된 파일명 노출
		$("#file").on('change', function(e) {
			// alert("이미지 선택");
			
			// 업로드할 이미지를 선택하지 않고 취소하거나, 한 번 선택 후 또 선택하는 과정에서 취소할 때 비어있는 경우 처리
			let file = e.target.files[0];
			if (file == null) {
				$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만 업로드될 수 있으므로 주의)
				return;
			}
			
			// 업로드할 이미지 선택할 때
			let fileName = e.target.files[0].name; // desert-8460850_640.jpg
			console.log(fileName);
			
			// 확장자 유효성 체크
			let ext = fileName.split(".").pop().toLowerCase();
			// alert(ext);
			if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
				alert("이미지 파일만 업로드할 수 있습니다.");
				$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만 업로드될 수 있으므로 주의)
				return;
			}
		});
		
		// 회원가입
		$("#signUpForm").on('submit', function(e) {
			e.preventDefault();
			// alert("회원가입");
			
			// validation check
			let loginId = $("#loginId").val().trim();
			let password = $("input[name=password]").val();
			let confirmPassword = $("input[name=confirmPassword]").val();
			let name = $("input[name=name]").val().trim();
			let email = $("input[name=email]").val().trim();
			let nickname = $("input[name=nickname]").val().trim();
			
			if (!loginId) {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if (!name) {
				alert("이름을 입력해주세요.");
				return false;
			}
			
			if (!email) {
				alert("이메일을 입력해주세요.");
				return false;
			}
			
			if (!nickname) {
				alert("닉네임을 입력해주세요.");
			}
		});
	});
</script>