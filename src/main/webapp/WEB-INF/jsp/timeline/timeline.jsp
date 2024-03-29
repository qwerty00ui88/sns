<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center">
	<div class="contents-box">
		<%-- 글쓰기 영역(로그인 된 사람만 보이게) --%>
		<c:if test="${not empty userId}">
			<div class="write-box border rounded bg-light">
				<textarea id="writeTextArea" placeholder="내용을 입력해주세요"
					class="w-100 border-0"></textarea>

				<div class="d-flex justify-content-between">
					<div class="file-upload d-flex">
						<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것과 같은 효과 --%>
						<input type="file" id="file" accept=".jpg, .jpeg, .gif, .png"
							class="d-none">
						<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
						<a href="#" id="fileUploadBtn"><img width="35"
							src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
						<%-- 업로드 된 임시 이미지 파일 이름 나타내는 곳 --%>
						<div id="fileName" class="ml-2"></div>
					</div>
					<button id="writeBtn" class="btn btn-dark">게시</button>
				</div>
			</div>
			<%--// 글쓰기 영역 끝 --%>
		</c:if>

		<%-- 타임라인 영역 --%>
		<div class="timeline-box">
			<c:forEach items="${cardViewList}" var="card">
				<%-- 카드1 --%>
				<div class="card border rounded">
					<%-- 글쓴이, 더보기(삭제) --%>
					<div class="p-2 d-flex justify-content-between align-items-center">
						<span class="font-weight-bold">${card.user.loginId}</span>

						<%-- (더보기 ... 버튼) 로그인 된 사람과 글쓴이 정보가 일치할 때 노출 --%>
						<c:if test="${userId eq card.post.userId}">
							<a href="#" class="more-btn" data-toggle="modal"
								data-target="#modal" data-post-id="${card.post.id}"><img
								src="https://www.iconninja.com/files/860/824/939/more-icon.png"
								width="30"> </a>
						</c:if>
					</div>

					<%-- 카드 이미지 --%>
					<div class="card-img">
						<img src="${card.post.imagePath}" class="w-100" alt="본문 이미지">
					</div>

					<%-- 좋아요 --%>
					<div class="card-like m-3">
						<c:if test="${card.filledLike eq false}">
							<a href="#" class="like-btn" data-post-id="${card.post.id}">
								<img
								src="https://www.iconninja.com/files/214/518/441/heart-icon.png"
								width="18" height="18" alt="empty heart">
							</a>
						</c:if>
						<c:if test="${card.filledLike eq true}">
							<a href="#" class="like-btn" data-post-id="${card.post.id}">
								<img
								src="https://www.iconninja.com/files/527/809/128/heart-icon.png"
								width="18" height="18" alt="filled heart">
							</a>
						</c:if>
						좋아요 ${card.likeCount}개
					</div>

					<%-- 글 --%>
					<div class="card-post m-3">
						<span class="font-weight-bold">${card.user.loginId}</span> <span>${card.post.content}</span>
					</div>

					<%-- 댓글 제목 --%>
					<div class="card-comment-desc border-bottom">
						<div class="ml-3 mb-1 font-weight-bold">댓글</div>
					</div>

					<%-- 댓글 목록 --%>
					<div class="card-comment-list m-2">
						<%-- 댓글 내용들 --%>
						<c:forEach items="${card.commentList}" var="commentView">
							<div class="card-comment m-1 d-flex justify-content-between">
								<div>
									<span class="font-weight-bold">${commentView.user.loginId}</span>
									<span>${commentView.comment.content}</span>
								</div>

								<c:if test="${userId eq commentView.comment.userId}">
									<%-- 댓글 삭제 버튼 --%>
									<a href="#" class="comment-del-btn"
										data-comment-id="${commentView.comment.id}"> <img
										src="https://www.iconninja.com/files/77/683/724/delete-icon.png"
										width="12" height="12">
									</a>
								</c:if>
							</div>
						</c:forEach>
						<%-- 댓글 쓰기 --%>
						<div class="comment-write d-flex border-top mt-2">
							<input type="text"
								class="form-control border-0 mr-2 comment-input"
								placeholder="댓글 달기" />
							<button type="button" class="comment-btn btn btn-light"
								data-user-id="${userId}" data-post-id="${card.post.id}">게시</button>
						</div>
					</div>
					<%--// 댓글 목록 끝 --%>
				</div>
				<%--// 카드1 끝 --%>
			</c:forEach>
		</div>
		<%--// 타임라인 영역 끝  --%>
	</div>
	<%--// contents-box 끝  --%>
</div>

<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<%-- 
		modal-sm: 작은 모달창
		modal-dialog-centered: 수직 기준 가운데 위치
	 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
			<div class="py-3 border-bottom">
				<a href="#" id="postDelete">삭제하기</a>
			</div>
			<div class="py-3">
				<a href="#" data-dismiss="modal">취소하기</a>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 파일 이미지 클릭 => 숨겨져 있는 id="file" 동작시킨다.
		$("#fileUploadBtn").on("click", function(e) {
			e.preventDefault(); // a 태그의 기본 동작을 멈춤(스크롤 위로 올라감)
			$("#file").click(); // input file을 클릭한 효과
		})

		// 사용자가 이미지를 선택하는 순간 유효성 확인 및 업로드 된 파일명 노출
		$("#file").on("change", function(e) {
			// 취소를 누를 때 비어있는 경우 처리
			let file = e.target.files[0];
			if (file == null) {
				$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
				$("#fileName").text(""); // 보여지는 파일명 비우기
				return;
			}
			//alert("이미지 선택");
			let fileName = e.target.files[0].name; // winter-8425500_640.jpg

			// 확장자 유효성 체크
			let ext = fileName.split(".").pop().toLowerCase();
			//alert(ext);
			if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$("#file").val(""); // 파일 태그 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
				$("#fileName").text(""); // 보여지는 파일명 비우기
				return;
			}

			// 유효성 통과한 이미지의 경우 파일명 노출
			$("#fileName").text(fileName);
		});

		// 글쓰기
		$("#writeBtn").on("click", function() {

			let content = $("#writeTextArea").val();

			let file = $("#file").val();
			if (file == "") {
				alert("파일을 업로드 해주세요");
				return;
			}

			// 이미지 확장자 체크
			let ext = file.split(".").pop().toLowerCase();
			if ($.inArray(ext, [ "gif", "png", "jpg", "jpeg" ]) == -1) {
				alert("gif, png, jpg, jpeg 파일만 업로드 할 수 있습니다.");
				$("#file").val("");
				return;
			}

			// form 태그 생성
			let formData = new FormData();
			formData.append("content", content);
			formData.append("file", $("#file")[0].files[0]);

			// AJAX
			$.ajax({
				type : "POST",
				url : "/post/create",
				data : formData,
				enctype : "multipart/form-data",
				processData : false,
				contentType : false,
				success : function(data) {
					if (data.code = 200) {
						alert("게시글이 저장되었습니다.");
						location.reload();
					} else if (data.code == 500) {
						location.href = "/user/sign-in-view";
					} else {
						alert(data.error_message);
					}
				},
				error : function(request, status, error) {
					alert("게시글을 저장하는데 실패했습니다.");
				}
			})

		})

		// 댓글 쓰기
		$(".comment-btn").on("click", function() {
			let userId = $(this).data("user-id");
			if (!userId) {
				// 비로그인이면 로그인 화면 이동
				alert("로그인을 해주세요.");
				location.href = "/user/sign-in-view";
				return;
			}

			let postId = $(this).data("post-id");

			// 댓글 내용 가져오기
			// 1) 이전 태그 값 가져오기
			// let content = $(this).prev().val().trim();

			// 2) 형제 태그 중 input 값 가져오기
			let content = $(this).siblings("input").val().trim();

			// validation
			if (!content) {
				alert("내용을 입력하세요.");
				return;
			}

			// ajax
			$.ajax({
				type : "POST",
				url : "/comment/create",
				data : {
					"postId" : postId,
					"content" : content
				},
				success : function(data) {
					if (data.code == 200) {
						location.reload();
					} else if (data.code == 500) {
						alert(data.error_message);
						location.href = "/user/sign-in-view";
					}
				},
				error : function(request, status, error) {
					alert("댓글을 저장하는데 실패했습니다.")
				}
			})
		})

		// 댓글 삭제
		$(".comment-del-btn").on("click", function(e) {
			e.preventDefault();

			let commentId = $(this).data("comment-id");

			// ajax
			$.ajax({
				type : "DELETE",
				url : "/comment/delete",
				data : {
					"commentId" : commentId
				},
				success : function(data) {
					if (data.code == 200) {
						alert("댓글 삭제에 성공했습니다.");
						location.reload();
					} else if (data.code == 500) {
						alert(data.error_message);
						location.href = "/user/sign-in-view";
					}
				},
				error : function(request, status, error) {
					alert("댓글을 삭제하는데 실패했습니다.");
				}
			})
		})

		// 좋아요 토글
		$(".like-btn").on("click", function(e) {
			e.preventDefault();

			let postId = $(this).data("post-id");
			$.ajax({
				// type: "GET", // 생략 가능
				url : "/like/" + postId,
				success : function(data) {
					if (data.code == 200) {
						location.reload(); // 새로고침 => timeline view 화면
					} else if (data.code == 300) {
						// 비로그인 시 로그인 페이지로 이동
						alert(data.error_message);
						location.href = "/user/sign-in-view";
					}
				},
				error : function(request, status, error) {
					alert("서버 전송에 실패했습니다.")
				}
			})
		})
		
		// 더보기(...) 클릭 -> 모달 띄우기
		$(".more-btn").on("click", function(e) {
			e.preventDefault(); // a 태그 올라가는 현상 방지

			let postId = $(this).data("post-id"); // getting

			// 1개로 존재하는 모달에 재활용을 위해 data-post-id를 심는다.
			$("#modal").data("post-id", postId); // setting
		})
		
		// 모달 안에 있는 삭제하기 클릭
		$("#modal #postDelete").on("click", function(e) {
			e.preventDefault(); // a 태그 올라가는 현상 방지
			
			let postId = $("#modal").data("post-id");

			$.ajax({
				type: "DELETE"
				, url: "/post/delete"
				, data: {"postId": postId}
				, success: function(data) {
					if(data.code == 200) {
						alert("글이 삭제되었습니다.");
						location.reload();
					} else {
						alert(data.error_message);
					}
				}
				, error: function(request, status, error) {
					alert("글 삭제에 실패했습니다.");
				}
			})
		})

	})
</script>