<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<form id="signUpForm" method="post" action="/user/sign-up">
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
			<input type="password" class="form-control" id="password" name="password">
		</div>
		<div class="form-group">
			<label for="confirmPassword">confirm password</label>
			<input type="password" class="form-control" id="confirmPassword">
		</div>
		<div class="form-group">
			<label for="name">이름</label>
			<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력해주세요">
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력해주세요">
		</div>
		<button type="submit" id="signUpBtn" class="btn btn-primary">가입하기</button>
	</form>
	<script>
		$(document).ready(function() {
			
			// 아이디 중복확인
			$("#loginIdCheckBtn").on("click", function() {
				// 경고 문구 초기화
				$("#idCheckLength").addClass("d-none");
				$("#idCheckDuplicated").addClass("d-none");
				$("#idCheckOk").addClass("d-none");
				
				let loginId = $("#loginId").val().trim();
				if(loginId.length < 4) {
					$("#idCheckLength").removeClass("d-none");
					return;
				}
				
				
				$.get("/user/is-duplicated-id", {"loginId":loginId}) // request
				.done(function(data) { // response
					if(data.code == 200) {
						if(data.is_duplicated_id) { // 중복
							$("#idCheckDuplicated").removeClass("d-none");
						} else { // 사용 가능
							$("#idCheckOk").removeClass("d-none");
						}
					} else {
						alert(data.error_message);
					}
				});
				
				
			})
			
			// 회원가입
			$("#signUpForm").on("submit", function(e) {
				e.preventDefault();
				
				// validation check
				let loginId = $("#loginId").val().trim();
				let password = $("#password").val();
				let confirmPassword = $("#confirmPassword").val();
				let name = $("#name").val().trim();
				let email = $("#email").val().trim();
				
				if(!loginId) {
					alert("아이디를 입력하세요.");
					return false;
				}

				if(!password || !confirmPassword) {
					alert("비밀번호를 입력하세요.");
					return false;
				}
				
				if(password != confirmPassword) {
					alert("비밀번호가 일치하지 않습니다.");
					return false;
				}

				if(!name) {
					alert("이름을 입력하세요.");
					return false;
				}
				
				if(!email) {
					alert("이메일을 입력하세요.");
					return false;
				}
				
				// 중복 확인 후 사용 가능한 아이디인지 확인
				// => idCheckOk 클래스에 d-none이 없을 때
				if($("idCheckOk").hasClass("d-none")) {
					alert("아이디 중복확인을 다시 해주세요.");
					return false;
				}
				
				// 1) 서버 전송: submit을 js에서 동작시킴
				// $(this)[0].submit(); // 화면 이동이 된다.
				
				// 2) AJAX: 화면 이동되지 않음(콜백함수에서 이동). 응답값 JSON
				let url = $(this).attr("action");
				let params = $(this).serialize(); // form 태그에 있는 name 속성과 값으로 파라미터를 구성 

				$.post(url, params) // request
				.done(function(data) { // response
					// {"code":200, "result":"성공"}
					if(data.code == 200) {
						alert("가입을 환영합니다. 로그인 해주세요.");
						location.href = "/user/sign-in-view"; // 로그인 화면으로 이동
					} else {
						// 로직 실패
						alert(data.error_message);
					}
				});
			})
		})
	</script>
</div>