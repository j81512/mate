<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<style>
@font-face {
    font-family: 'CookieRunOTF-Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/CookieRunOTF-Bold00.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.font-cookie{
	font-family: 'CookieRunOTF-Bold';
}
@font-face {
	font-family: 'UhBeeSe_hyun';
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_five@.2.0/UhBeeSe_hyun.woff') format('woff');
	font-weight: normal;
	font-style: normal;
}
.font-uhbee{
	font-family: 'UhBeeSe_hyun';
}
nav {
    position: relative;
    padding: 50px 10px 10px 10px;
    min-width: 300px;
    min-height: 200px;
}
.nav-brand{
	position: absolute;
	left: 50%;
	right: 50%;
	width: 100%;
	transform:translate(-50%, 0);
	text-align: center;
}

/* footer{
	position: absolute;
	display: block;
	background-color: white;
	bottom: 0;
	width: 100%;
	height: 10%;
}
footer p{
	margin:0;
} */
html{
	overflow-y: scroll;
}
.color-hotPink{
	color: rgb(238,80,78);
}
.color-emerald{
	color: rgb(61,171,139);
}
.color-coralBlue{
	color: rgb(9,72,178);
}
#brand{
	font-size: 400%;
	border: 4px solid white;
	border-radius: 20%;
	margin-left: 5%;
	margin-right: 5%;
}
#brand:hover{
	color: rgb(238,80,78);
	text-decoration: none;
}
.nav-list-img{
	height: 50px;
	width: 50px;
}
.nav-list{
	display: inline-block;
	text-align: left;
	margin-left: 1%;
	margin-top: 1%;
	width: 150px;
	border-radius: 100%;
}
.nav-list:hover{
	background-color: rgba(255,255,255,0.3);
	text-align: center;
}
.nav-list-text{
	vertical-align: bottom;
	color: white;
	margin-left:2px;
	text-decoration: underline;
}
#back-img{
	position:absolute;
	width: 30px;
	height: 30px;
	margin: 30px;
}
#back-img:hover{
	width: 35px;
	margin-left: 20px;
	cursor: pointer;
}
.nav-list-div{
	width: 100%;
	height: 100%;
	text-align: left;
	position: absolute;
}
#loginMember-span{
	position: absolute;
	top: 20%;
	left: 80%;
	color: white;
}

body{
	background-image: url("/mate/resources/images/background.png");
	background-size: cover;
}
.container{
	border: 1px solid white;
	background-color: white;
	border-radius: 10%;
	min-height: 500px;
	padding: 30px;
	margin-left: auto;
	margin-right: auto;
 	box-sizing: border-box;
  	max-width: 70%;
  	text-align: center;
}

</style>
<script>
$(function(){
	$("#back-img").click(function(){
		window.history.go(-1);
	});	

	if(${! empty msg}){
		alert('${msg}');
	}

});
</script>
</head>
<body>
<header>
	 <nav>
		<div class="nav">
			<div class="nav-brand" >
				<a id="brand" class="color-hotPink font-uhbee" href="${ pageContext.request.contextPath }">&nbsp;메이트&nbsp;</a>
				<br />
				<div class="nav-list-div">
		       		<a class="nav-list " href="${ pageContext.request.contextPath }/product/productList.do">
			       		<img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/toy.png" alt="" />
			       		<span class="nav-list-text font-cookie">Toy</span>
		       		</a>
		       		<br />
 				    <c:if test='${ empty loginMember || loginMember.memberId ne "admin" }'>
						<a class="nav-list " href="${ pageContext.request.contextPath }/product/selectCart.do?memberId=${ loginMember.memberId }">
				       		<img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/cart.png" alt="" />
				       		<span class="nav-list-text font-cookie">Cart</span>
			       		</a>
		       		</c:if>
		       		<c:if test='${ ! empty loginMember && loginMember.memberId eq "admin" }'>
		       			<a class="nav-list " href="${ pageContext.request.contextPath }/product/returnPage.do">
				       		<img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/cart.png" alt="" />
				       		<span class="nav-list-text font-cookie">return</span>
			       		</a>
		       		</c:if>
		       		<br />
		       		<a class="nav-list " href="${ pageContext.request.contextPath }/company/location.do">
			       		<img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/location.png" alt="" />
			       		<span class="nav-list-text font-cookie">Location</span>
		       		</a>
		       		<br />
		       		<a class="nav-list " href="${ pageContext.request.contextPath }/cs/cs.do">
			       		<img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/cs.png" alt="" />
			       		<span class="nav-list-text font-cookie">C/S</span>
		       		</a>
		       		<br />
		       		<c:if test='${ empty loginMember || loginMember.memberId ne "admin" }'>
		       			<a class="nav-list " href="${ pageContext.request.contextPath }/member/myPage.do">
    					    <img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/mypage.png" alt="" />
		       				<span class="nav-list-text font-cookie">MyPage</span>
		       			</a>
		       		</c:if>
		       		<c:if test='${ ! empty loginMember && loginMember.memberId eq "admin" }'>
		       			<a class="nav-list " href="${ pageContext.request.contextPath }/Member/MemberList.do">
 							<img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/mypage.png" alt="" />
		       				<span class="nav-list-text font-cookie">Manage</span>
		       			</a>
		       		</c:if>
		       		<br />
	       			<c:if test="${ empty loginMember }">
	       				<a class="nav-list " href="${ pageContext.request.contextPath}/member/memberLogin.do"><img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/login.png" alt="" /><span class="nav-list-text font-cookie">Login</span></a>
	       			</c:if>
	       			<c:if test="${! empty loginMember }">
	       				<a class="nav-list " href="${ pageContext.request.contextPath}/member/logout.do"><img class="nav-list-img" src="${ pageContext.request.contextPath }/resources/images/logout.png" alt="" /><span class="nav-list-text font-cookie">Logout</span></a>
	       			</c:if>  	
       			</div>
			</div>
       	</div>
       	<img src="${ pageContext.request.contextPath }/resources/images/back.png" id="back-img" alt="" />
       	<c:if test="${! empty loginMember }">
			<span class="font-cookie" id="loginMember-span"><b class="font-uhbee color-hotPink">${ loginMember.memberName }</b> 님, 반갑습니다.</span>
		</c:if>
	</nav>
</header>
<br />
<section id="content-sec">


