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
		<div class="d-flex">
			<a href="#" class="header-subject">내 블로그</a>
			<div class="verticalLine">|</div>
		</div>
		
		<div class="d-flex">
			<a href="#" class="header-subject">블로그 홈</a>
			<div class="verticalLine">|</div>
		</div>
		
		<%-- 로그인, 로그아웃 상태 여부 --%>
		<c:if test="${not empty userId}">
			<div class="d-flex mr-2">
				<a href="/user/data-modify-view" class="nickname">${userNickname}님</a>
				<div class="verticalLine">|</div>
				<a href="/user/sign-out" class="header-subject">로그아웃</a>
			</div>
		</c:if>
		
		<c:if test="${empty userId}">
			<div class="mr-2">
				<a href="/user/sign-in-view" class="header-subject">로그인</a>
			</div>
		</c:if>
	</div>
</div>