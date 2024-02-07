<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h3 class="m-3">회원가입</h3>
		<form id="signUpForm" method="post" action="/user/sign-up">
			<span class="sign-up-subject">아이디</span>
			<div class="d-flex ml-3 mt-2">
				<input type="text" id="loginId" name="loginId" class="form-control col-7" placeholder="아이디를 입력하세요.">
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
				<input type="password" name="password" class="form-control col-7" placeholder="비밀번호를 입력하세요.">
			</div>
			
			<span class="sign-up-subject">비밀번호 확인</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="password" name="confirmPassword" class="form-control col-7" placeholder="비밀번호를 입력하세요.">
			</div>
			
			<span class="sign-up-subject">이름</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="name" class="form-control col-7" placeholder="이름을 입력하세요.">
			</div>
			
			<span class="sign-up-subject">이메일</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="email" class="form-control col-7" placeholder="이메일을 입력하세요.">
			</div>
			
			<span class="sign-up-subject">닉네임</span>
			<div class="ml-3 mt-2 mb-2">
				<input type="text" name="nickname" class="form-control col-7" placeholder="닉네임을 입력하세요.">
			</div>
			
			<div class="file-upload d-flex">
				<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것과 같은 효과 --%>
				<input type="file" id="file" accept=".jpg, .jpeg, .gif, .png" class="d-none">
				
				<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
				<a href="#" id="fileUploadBtn" class="ml-3 mt-2 mb-2"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
			</div>
		</form>
	</div>
</div>