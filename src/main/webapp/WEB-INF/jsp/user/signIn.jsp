<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-in-box">
		<div class="login">
			<h2 class="mt-2">로그인</h2>
		</div>
		<hr>
		<form id="loginForm" method="post" action="/user/sign-in">
			<span class="sign-in-subject">아이디</span>
			<div class="d-flex ml-3 mt-2 mb-3">
				<input type="text" id="loginId" name="loginId" class="form-control col-7" placeholder="아이디를 입력해주세요.">
			</div>
				
			<span class="sign-in-subject">비밀번호</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="password" name="password" class="form-control col-7" placeholder="비밀번호를 입력해주세요.">
			</div>
				
			<div class="d-flex justify-content-center m-3">
				<a id="signUpBtn" class="btn mr-3" href="/user/sign-up-view">가입하기</a>
				<button type="submit" id="loginBtn" class="btn">로그인</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 로그인
		$("#loginForm").on('submit', function(e) {
			// alert("로그인");
			e.preventDefault();
			
			// validation
			let loginId = $("input[name=loginId]").val().trim();
			let password = $("input[name=password]").val();
			
			if (!loginId) {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			if (!password) {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			let url = $(this).attr('action');
			let params = $(this).serialize(); // name 속성 정의가 반드시 있어야 한다.
			
			$.post(url, params) // request
			.done(function(data) { // response
				if (data.code == 200) {
					location.href = "/post/post-list-view";
				} else {
					alert(data.error_message);
				}
			});
		});
	});
</script>