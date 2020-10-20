<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/loginForm.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
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

		if(${ not empty snsMember }){
			
			console.log("${ NaverMember }");
			$("#register-form").delay(100).fadeIn(100);
			$("#login-form").fadeOut(100);
			$('#login-form-link').removeClass('active');
			$("#register-form").addClass('active');
			
		}
		
	});

	$(function() {
	
		$("#phone-send").click(function(){
			var $phone = $("#phone").val();
		    var popUrl ="${ pageContext.request.contextPath }/member/pCheck.do";
		    var popOption = "width=650px, height=550px, resizable=no, location=no, top=300px, left=300px;"
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
						var $num = data;		
						window.open(popUrl + "/" +  $num ,"휴대폰 인증 ",popOption); 		
				},
				error: function(xhr, status, err){
						console.log(xhr);
						console.log(status);
						console.log(err);
					
				}
			}); 
			
		});
	});

	$(document).ready(function(){
		var key = getCookie("key");	
		var $memberId = $("#memberId_").val(key);
		var $remember = $("#remember_");

		if( $memberId != ""){
			$remember.prop("checked", true);
		}else{
			$remember.prop("checked", false)

		}

		$("#remember_").change(function(){

			if($remember.is(":checked")){
				setCookie("key", $("#memberId_").val(), 7);
			}else{
				deleteCookie("key");
				$remember.prop("checked", false)
			}
		});

		$($memberId).keyup(function(){
			if($remember.is(":checked")){
				setCookie("key", $("#memberId_").val(), 7);
			}else{
				deleteCookie("key");
				$remember.prop("checked", false)
			}	
		});
		
	});

	function setCookie(cookieName, value, exdays){
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);

		var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" +cookieValue;
		
	}

	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
</script>


<div class="container">
	<div class="row">
		<div class="col-md-3 col-md-offset-4">
		 <ul class="nav nav-tabs">
             <li class="active"><a href="#member" data-toggle="tab">일반 회원</a></li>
             <li><a href="#adminTab" data-toggle="tab">관리자 회원</a></li>
         </ul>
          <div id="myTabContent" class="tab-content">
          <div class="tab-pane active in" id="member">
			<div class="form">
				<form class="form"
					action="${ pageContext.request.contextPath }/member/loginCheck.do"
					method="post" id="login-form">
					<h3 class="heading-desc">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" name="memberId" id="memberId_"
							placeholder="아이디" required autofocus />
					</div>
					<div class="form-group">
						<input type="password" class="form-control" name="memberPWD"
							id="memberPWD_" placeholder="비밀번호" required />
					</div>
					<label class="checkbox"> 
						<input type="checkbox" name="remember" id="remember_"  /> 아이디저장
					</label> 
					<a class="forgotLnk" href="#" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#modalPassword">비밀번호를 잊어 버리셨나요 ?</a>
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
					action="${pageContext.request.contextPath}/member/memberEnroll.do"
					method="post" role="form" style="display: none;">
					<h3 class="heading-desc">회원가입</h3>
					<div class="form-group">
						<input type="text" name="memberId" id="memberId_" tabindex="1"
							class="form-control" placeholder="아이디를 입력해 주세요" value="${ snsMember.memberId != null ? snsMember.memberId : ''}"  ${ not empty snsMember ? "readOnly" : "" }>
					</div>
					<div class="form-group">
						<input type="password" name="memberPWD" id="memberPWD_" tabindex="2"
							class="form-control" placeholder="비밀번호를 입력해주세요" value="${ snsMember.memberPWD != null ? snsMember.memberPWD : ''}"  ${ not empty snsMember ? "readOnly" : "" }>
					</div>
					<div class="form-group">
						<input type="password" name="memberPWDCK"
							id="memberPWDCK_" tabindex="2" class="form-control"
							placeholder="비밀번호를 확인해주세요" value="${ snsMember.memberPWD != null ? snsMember.memberPWD : ''}"  ${ not empty snsMember ? "readOnly" : "" }>
					</div>
					<div class="form-group">
						<input type="text" name="memberName" id="memberName_" tabindex="1"
							class="form-control" placeholder="이름을 입력해주세요" value="${ snsMember.memberName != null ? snsMember.memberName : ''}" ${ not empty snsMember ? "readOnly" : "" }>
					</div>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender" id="gender0" value="M" ${ snsMember.gender eq  "M" ? "checked readonly" :"" }>
						<label  class="form-check-label" for="gender0">남</label>&nbsp;
						<input type="radio" class="form-check-input" name="gender" id="gender1" value="F" ${ snsMember.gender eq  "F" ? "checked readonly" :"" } >
						<label  class="form-check-label" for="gender1">여</label>
					</div>
					<div class="form-group">
						<input type="tel" class="form-control" 
						placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
						<div class="form-check form-check-inline">
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg"id="phone-send">문자인증</button>
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
					<!-- 관리자용 로그인 화면 -->
	
				  <div class="tab-pane fade" id="adminTab">
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
                      <form id="adminTab">
                     	<h3 class="heading-desc">관리자 로그인</h3>
                     	<div class="form-group">
	                        <label for="empName_">아이디</label>
	                        <input type="text" name="empName" value="" class="input-xlarge">
	                    </div>
	                    <div class="form-group">   
	                        <label for="empPassword_">비밀번호</label>
	                        <input type="password" name="empPassword"  class="input-xlarge">
=======
<<<<<<< HEAD
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
                      <form id="adminTab" action="${ pageContext.request.contextPath }/ERP/erpLogin.do" method="post">
                     	<h3 class="heading-desc">관리자 로그인</h3>
                     	<div class="form-group">
	                        <label for="empId_">아이디</label>
	                        <input type="text" name="empId" id="empId" class="input-xlarge">
	                    </div>
	                    <div class="form-group">   
	                        <label for="empPassword_">비밀번호</label>
	                        <input type="password" name="empPwd"  class="input-xlarge">
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                      <form id="adminTab">
                     	<h3 class="heading-desc">관리자 로그인</h3>
                     	<div class="form-group">
	                        <label for="empName_">아이디</label>
	                        <input type="text" name="empName" value="" class="input-xlarge">
	                    </div>
	                    <div class="form-group">   
	                        <label for="empPassword_">비밀번호</label>
	                        <input type="password" name="empPassword"  class="input-xlarge">
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
                       	</div>
                       	<div class="form-check form-check-inline">
							<input type="radio" class="form-check-input" name="status" id="status2" value="2" checked>
							<label  class="form-check-label" for="status2">제조사</label>&nbsp;
							<input type="radio" class="form-check-input" name="status" id="status1" value="1" >
							<label  class="form-check-label" for="status1">지점</label>
							<input type="radio" class="form-check-input" name="status" id="status0" value="0" >
							<label  class="form-check-label" for="status0">본사</label>
						</div>
                        <div>
                          <button type="submit" class="btn btn-primary">로그인</button>
                        </div>
                      </form>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 비밀번호 찾기용 모달 창 -->

<jsp:include page="/WEB-INF/views/common/footerS.jsp" />