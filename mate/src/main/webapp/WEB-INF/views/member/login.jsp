<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/loginForm.css" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="/WEB-INF/views/common/headerS.jsp" />
<script>
	$(function() {

		$('#login-form-link').click(function(e) {
			$("#login-form").delay(100).fadeIn(100);
			$("#register-form").fadeOut(100);
			$('#register-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		$('#register-form-link').click(function(e) {
			$("#register-form").delay(100).fadeIn(100);
			$("#login-form").fadeOut(100);
			$('#login-form-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});

	});

	$(function() {
	
		$("#phone-send").click(function(){
			var $phone = $("#phone").val();
			console.log($phone);
			$.ajax({
				url:"${ pageContext.request.contextPath}/member/phoneSend.do",
				data:{
					receiver: $phone
				},
				dataType:"json",
				method: "post",
				success: function(data){
						console.log(data);		

				},
				error: function(xhr, status, err){
						console.log(xhr);
						console.log(status);
						console.log(err);
					
				}
			}); 
			
		});
	});
</script>


<div class="container">
	<div class="row">
		<div class="col-md-3 col-md-offset-4">
			<div class="form-login">
				<form class="form-signin"
					action="${ pageContext.request.contextPath }/member/loginCheck.do"
					method="post" id="login-form">
					<h3 class="heading-desc">로그인</h3>
					<label class="radio-inline"> <input type="radio"
						name="member" id="buyMember_" value="C" checked> 일반회원
					</label> <label class="radio-inline"> <input type="radio"
						name="member" id="businessMember_" value="B"> 기업회원
					</label> <br />
					<div class="form-group">
						<input type="text" class="form-control" name="userId" id="userId_"
							placeholder="아이디" required autofocus />
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="password"
							id="password_" placeholder="비밀번호" required />
					</div>
					<label class="checkbox"> <input type="checkbox"
						value="remember" /> 아이디저장
					</label> <a class="forgotLnk" href="#">비밀번호를 잊어 버리셨나요 ?</a>
					<button class="btn btn-lg btn-block purple-bg" type="submit">
						로그인</button>
						<div class="or-box">
						<span class="or"><h3>OR</h3></span>
						<div class="row">
							<!-- 호근 수정 로그인버튼만 누르면 바로 연동되게 할 수 있게 수정  -->
							<div class="center-block">
							<div class="col-md-12 row-block" id="naver_id_login">
								<div id="naver_id_login">
									<a class="social-login-btn social-facebook" href="${url}">
										<img width="50"
										src="${pageContext.request.contextPath}/resources/images/naverLogo.jpg"
										class="img-rounded" />
									</a>
								</div>
							</div>
							</div>
							<!-- 카카오 로그인 버튼 추가  -->
							<div class="center-block">
							<div class="col-md-12 row-block" id="kakao_id_login">
								<div id="kakao_id_login">
									<a class="social-login-btn social-kakao" href="${ kakaoUrl }">
										<img width="50"
										src="${pageContext.request.contextPath}/resources/images/kakaolinkbtnsmall.png"
										class="img-rounded" />
									</a>
								</div>
							</div>
							</div>
							<!-- 구글 로그인 버튼 추가 -->
							<div class="center-block">
							<div class="col-md-12 row-block" id="google_id_login">
								<div id="google_id_login">
									<a class="social-login-btn social-google" href="${ googleUrl }">
										<img width="50"
										src="${pageContext.request.contextPath}/resources/images/googleL.png"
										class="img-rounded" />
									</a>
								</div>
							</div>
							</div>

						</div>
					</div>
					<div class="or-box row-block">
						<div class="row">
							<div class="col-md-12 row-block" id="register-form-link">
								<button class="btn btn-lg btn-block purple-bg">
									회원가입</button>
							</div>
						</div>
					</div>

				</form>
				<!-- 회원가입 폼 추가 -->
				<form id="register-form"
					action="${pageContext.request.contextPath}/member/memberEnroll.do "
					method="post" role="form" style="display: none;">
					<h3 class="heading-desc">회원가입</h3>
					<div class="form-group">
						<input type="text" name="id" id="id" tabindex="1"
							class="form-control" placeholder="아이디를 입력해 주세요" value="">
					</div>
					<div class="form-group">
						<input type="password" name="password" id="password" tabindex="2"
							class="form-control" placeholder="비밀번호를 입력해주세요">
					</div>
					<div class="form-group">
						<input type="password" name="passwordCk"
							id="password_ck" tabindex="2" class="form-control"
							placeholder="비밀번호를 확인해주세요">
					</div>
					<div class="form-group">
						<input type="text" name="name" id="name" tabindex="1"
							class="form-control" placeholder="이름을 입력해주세요" value="">
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender" id="gender0" value="M" checked>
						<label  class="form-check-label" for="gender0">남</label>&nbsp;
						<input type="radio" class="form-check-input" name="gender" id="gender1" value="F">
						<label  class="form-check-label" for="gender1">여</label>
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" 
						placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
						<div class="form-check form-check-inline">
						<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"id="phone-send">문자인증</button>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-6 col-sm-offset-3">
								<button class="btn btn-lg btn-block purple-bg" type="submit">
									가입하기</button>
							</div>
						</div>
					</div>
					<div class="or-box row-block">
						<div class="row">
							<div class="col-md-12 row-block">
								<a href="#" id="login-form-link">이전 페이지</a>
							</div>
						</div>
					</div>
				</form>

			</div>
		</div>
	</div>
</div>
<!-- 휴대폰 인증관련 modal -->
<div class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">휴대폰 인증</h4>
      </div>
      <div class="modal-body">
       
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary">인증하기</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="/WEB-INF/views/common/footerS.jsp" />