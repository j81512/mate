<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>

	<div class="container">
    <div class="row">
        <div class="col-md-3 col-md-offset-4">
            <div class="account-box">
                
                <form class="form-signin" action="#">
           		<label class="radio-inline">
				  <input type="radio" name="buyMember" id="buyMember_" value="option1"> 일반회원
				</label>
				<label class="radio-inline">
				  <input type="radio" name="businessMember" id="businessMember_" value="option2"> 기업회원
				</label>
                <div class="form-group">
                    <input type="text" class="form-control" name="userId" id="userId_" placeholder="아이디" required autofocus />
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="password" id="password_"placeholder="비밀번호" required />
                </div>
                <label class="checkbox">
                    <input type="checkbox" value="remember" />
                    	아이디저장
                </label>
                <button class="btn btn-lg btn-block purple-bg" type="submit">
                    	로그인</button>
                </form>
                <a class="forgotLnk" href="#">비밀번호를 잊어 버리셨나요 ?</a>
                <div class="or-box">
                    <span class="or">OR</span>
                    <div class="row">
                    <!-- 호근 수정 로그인버튼만 누르면 바로 연동되게 할 수 있게 수정  -->
                    <div class="col-md-12 row-block" id="naver_id_login">
						<div id="naver_id_login" style="text-align:center"><a href="${url}">
						<img width="50" src="${pageContext.request.contextPath}/resources/images/naverLogo.jpg"/></a>
						</div>
                    </div>
                    <!-- 카카오 로그인 버튼 추가  -->
                    <div class="col-md-12 row-block" id="naver_id_login">
						<div id="kakao_id_login" style="text-align:center">
						<a href="${ kakaoUrl }">
						<img width="50" src="${pageContext.request.contextPath}/resources/images/kakaolinkbtnsmall.png"/></a>
						</div>
                    </div>
                    <!-- 구글 로그인 버튼 추가 -->
                    <div class="col-md-12 row-block" id="naver_id_login">
						<div id="google_id_login" style="text-align:center">
						<a href="${ googleUrl }">
						<img width="50" src="${pageContext.request.contextPath}/resources/images/googleL.png"/></a>
						</div>
                    </div>
                    </div>
                </div>
                <div class="or-box row-block" >
                    <div class="row">
                        <div class="col-md-12 row-block">
                            <a href="${ pageContext.request.contextPath }/member/memberEnroll.do';" 
                               class="btn btn-primary btn-block">회원가입</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>