<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<div class="profile">
			<div class="profile-box">
				<h2 class="mt-2">회원정보 수정</h2>
				
				<div class="mt-3">
					<span class="profile-span">프로필 이미지 변경</span><br>
					<div class="file-upload d-flex justify-content-center">
						<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것과 같은 효과 --%>
						<input type="file" id="file" accept=".jpg, .jpeg, .gif, .png" class="d-none">
						
						<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
						<a href="#" id="fileUploadBtn" class="mt-2 mb-2"><img id="profileImage" width="65" src="https://cdn.pixabay.com/photo/2017/07/11/13/56/user-2493635_1280.png"></a>
						
						<%-- 업로드된 임시 이미지 파일 이름 나타내는 곳 --%>
						<div id="fileName" class="ml-2"></div>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<form id="dataModifyForm" method="post" action="/user/data-modify">
			<span class="modify-subject">아이디</span>
			<div class="d-flex ml-3 mt-2 mb-2">
				<input type="text" id="loginId" name="loginId" class="form-control col-7" placeholder="${userLoginId}" disabled>
			</div>
			
			<span class="modify-subject">비밀번호</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="password" name="password" class="form-control col-7" placeholder="비밀번호를 입력해주세요.">
			</div>
			
			<span class="modify-subject">비밀번호 확인</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="password" name="confirmPassword" class="form-control col-7" placeholder="비밀번호를 입력해주세요.">
			</div>
			
			<span class="modify-subject">이름</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="name" class="form-control col-7" placeholder="${userName}" disabled>
			</div>
			
			<span class="modify-subject">이메일</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="email" class="form-control col-7" placeholder="이메일을 입력해주세요.">
			</div>
			
			<span class="modify-subject">닉네임</span>
			<div class="d-flex ml-3 mt-2 mb-2">
				<input type="text" name="nickname" class="form-control col-7" placeholder="닉네임을 입력해주세요.">
				<button type="button" id="nicknameCheckBtn" class="btn ml-2">중복 확인</button>
			</div>
			
			<%-- 닉네임 체크 결과 --%>
			<div class="ml-3 mt-2 mb-2">
				<div id="nickCheckDuplicated" class="small text-danger d-none">이미 사용 중인 닉네임입니다.</div>
				<div id="nickCheckOk" class="small text-success d-none">사용 가능한 닉네임입니다.</div>
			</div>
			
			<br>
			<div class="d-flex justify-content-center m-2">
				<button type="submit" id="dataModifyBtn" class="btn">수정하기</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 닉네임 중복 확인
		$("#nicknameCheckBtn").on('click', function() {
			// alert("닉네임 중복 확인");
			
			// 문구 초기화
			$("#nickCheckDuplicated").addClass("d-none");
			$("#nickCheckOk").addClass("d-none");
			
			let nickname = $("input[name=nickname]").val().trim();
			if (nickname.length < 1) {
				alert("단어 1개 이상 적으셔야 중복 확인을 할 수 있습니다.");
				return;
			}
			
			$.get("/user/is-duplicated-nickname", {"nickname":nickname})
			.done(function(data) {
				if (data.code == 200) {
					if (data.is_duplicated_nickname) { // 중복
						$("#nickCheckDuplicated").removeClass("d-none");
					} else { // 사용 가능
						$("#nickCheckOk").removeClass("d-none");
					}
				} else {
					alert("닉네임 중복 확인에 실패하였습니다.");
				}
			});
		});
		
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
				$("#fileName").text(""); // 보여지는 파일명 비우기
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
				$("#fileName").text(""); // 보여지는 파일명 비우기
				return;
			}
			
			// 유효성 통과한 이미지의 경우 파일명 노출
			$("#fileName").text(fileName);
		});
		
		// 회원정보 수정
		$("#dataModifyForm").on('submit', function(e) {
			e.preventDefault();
			// alert("정보 수정");
			
			let password = $("input[name=password]").val();
			let confirmPassword = $("input[name=confirmPassword]").val();
			let email = $("input[name=email]").val().trim();
			let nickname = $("input[name=nickname]").val().trim();
			let fileName = $("#file").val();
			
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if (!email) {
				alert("이메일을 입력해주세요.");
				return false;
			}
			
			if (!nickname) {
				alert("닉네임을 입력해주세요.");
			}
			
			// 파일이 업로드된 경우에만 확장자 체크
			if (fileName) {
				// C:\fakepath\cortina-dampezzo-8504755_640.jpg
				// 확장자만 뽑은 후 소문자로 변경해서 검사한다.
				let ext = fileName.split(".").pop().toLowerCase();
			
				if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
					alert("이미지 파일만 업로드할 수 있습니다.");
					$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만 업로드될 수 있으므로 주의)
					$("#fileName").text(""); // 보여지는 파일명 비우기
					return;
				}
			}
			
			// 이미지를 업로드할 때는 반드시 form 태그로 구성한다.
			let formData = new FormData();
			formData.append("password", password);
			formData.append("email", email);
			formData.append("nickname", nickname);
			formData.append("file", $("#file")[0].files[0]);
			
			$.ajax({
				// request
				type:"POST"
				, url:"/user/data-modify"
				, data:formData
				, enctype:"multipart/form-data" // 파일 업로드를 위한 필수 설정
				, processData:false // 파일 업로드를 위한 필수 설정
				, contentType:false // 파일 업로드를 위한 필수 설정
				
				// response
				, success:function(data) {
					if (data.code == 200) {
						alert("회원정보 수정이 완료되었습니다.");
						location.href = "/post/post-list-view"; // 게시글(전체목록) 화면으로 이동
					} else if (data.code == 500) {
						alert(data.error_message);
					}
				}
				, error:function(request, status, error) {
					alert("회원정보 수정에 문제가 생겼습니다. 관리자에게 문의해주세요.");
				}
			});
		});
	});
</script>