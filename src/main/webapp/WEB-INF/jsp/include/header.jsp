<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="h-100 header d-flex justify-content-between align-items-center">
	<%-- logo --%>
	<div class="logo ml-2">
		<h3>A-Blog</h3>
	</div>
	
	<%-- 블로그 이동 및 로그인 or 로그아웃--%>
	<div class="d-flex">
		<div class="mr-2">
			<a href="#">내 블로그</a>
		</div>
		
		<div class="mr-2">
			<a href="#">블로그 홈</a>
		</div>
		
		<%-- 로그인, 로그아웃 상태 여부 --%>
		<c:if test="${not empty userId}">
			<div class="mr-2">
				<span>${userNickname}님, 안녕하세요!</span>
				<a href="/user/sign-out" class="ml-2 font-weight-bold">로그아웃</a>
			</div>
		</c:if>
		
		<c:if test="${empty userId}">
			<div class="mr-2">
				<a href="/user/sign-in-view" class="ml-2 font-weight-bold">로그인</a>
			</div>
		</c:if>
	</div>
</div>