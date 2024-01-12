<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<form method="post" action="">
		<div class="form-group">
			<label for="loginId">ID</label>
			<div class="d-flex">
				<input type="text" class="form-control" id="loginId" name="loginId" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-primary">중복확인</a>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<%-- d-none 클래스: display none (보이지 않게) --%>
			<small id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</small>
			<small id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</small>
			<small id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</small>
		</div>
		<div class="form-group">
			<label for="password">password</label>
			<input type="text" class="form-control" id="password" name="password">
		</div>
		<div class="form-group">
			<label for="confirmPassword">confirm password</label>
			<input type="text" class="form-control" id="confirmPassword" name="confirmPassword">
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요">
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요">
		</div>
		<button type="submit" class="btn btn-primary">가입하기</button>
	</form>
</div>