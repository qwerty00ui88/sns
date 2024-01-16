<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<c:if test="${not empty userId}">
		<div>
			<textarea></textarea>
			<div><button id="uploadBtn" type="button" class="btn btn-primary">업로드</button></div>
		</div>
	</c:if>
	<c:forEach items="${postEntityList}" var="post">
		<div class="w-50">
			<div class="d-flex justify-content-between">
				<div class="font-weight-bold">${post.userId}</div>
				<button>...</button>
			</div>
			<img src="${post.imagePath}" alt="이미지" class="w-100">
			<div class="d-flex">
				<button>하트모양</button>
				<div class="font-weight-bold">좋아요 11개</div>
			</div>
			<div>
				<span class="font-weight-bold">${post.userId}</span>
				<span>${post.content}</span>
			</div>
			<%-- 댓글 --%>
			<div class="font-weight-bold">댓글</div>
		</div>
	</c:forEach>
	<script>
		$(document).ready(function(){
			// 업로드
			$("#uploadBtn").on("click", function() {
				
				$.post("/post/create", {})
			})
		})
	</script>
</div>