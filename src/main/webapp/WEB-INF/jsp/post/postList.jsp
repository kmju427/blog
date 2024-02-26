<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="post-list d-flex">
	<div class="post-left pt-3">
		<ul>
			<li>전체글보기 <a href="#" class="btn">edit</a></li>
		</ul>
		<hr>
		<ul>
			<li>카테고리1</li>
			<li>카테고리2</li>
			<li>카테고리3</li>
		</ul>
	</div>
	<div class="post-right p-3">
		<h3>전체글보기</h3>
		
		<table class="table">
			<c:forEach items="${postList}" var="post">
			<tr>
				<td>
					<div><img src="${post.imagePath}" width="300"></div>
					<div>${post.subject}</div>
					<div>${post.content}</div>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>