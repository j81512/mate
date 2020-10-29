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
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style>
html{
	overflow-y: scroll;
}
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
#brand{
	font-size: 200%;
}
.brand-div{
	width: 15%;
	text-align: center;	
}
.nav-div{
	width: 65%;
	position: relative;
	text-align: left;
	padding-top: 10px;
	min-width: 610px;
}
.nav-span{
	display: inline-block;
	width: 10%;
	text-align: center;
	vertical-align: sub;
}
.login-div{
	width: 20%;
	position: relative;
	text-align: left;
	padding-top: 15px;
	min-width: 130px;
}
.loginMember-span{
	font-size: 14px;
	display: inline-block;
	text-align: center;
	vertical-align: sub;
}
#header-nav{
	height: 60px;
	padding-top: 18px;
}
#background-img{
	position: fixed;
	z-index: -1;
	width: 100%;
}
.search-div{
	height: 320px;
}
#header-nav a{
	color: rgba(54,54,54,0.6);
}
#header-nav a:hover{
	text-decoration: none;
	color: rgb(164,80,68);
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
<img id="background-img" src="${ pageContext.request.contextPath }/resources/images/background.png" alt="" />
<header>
	 <nav id="header-nav">
		<div class="nav">
			<div class="brand-div" >
				<a id="brand" class="font-cookie" href="${ pageContext.request.contextPath }">&nbsp;MATE&nbsp;</a>
			</div>
			<div class="nav-div">
	       		<a class="" href="${ pageContext.request.contextPath }/product/productList.do">
		       		<span class="font-cookie nav-span">Toy</span>
	       		</a>

				    <c:if test='${ empty loginMember || loginMember.memberId ne "admin" }'>
					<a class="" href="${ pageContext.request.contextPath }/product/selectCart.do?memberId=${ loginMember.memberId }">
			       		<span class="font-cookie nav-span">Cart</span>
		       		</a>
	       		</c:if>
	       		<c:if test='${ ! empty loginMember && loginMember.memberId eq "admin" }'>
	       			<a class=" " href="${ pageContext.request.contextPath }/product/returnPage.do">
			       		<span class=" font-cookie nav-span">return</span>
		       		</a>
	       		</c:if>

	       		<a class=" " href="${ pageContext.request.contextPath }/company/location.do">
		       		<span class=" font-cookie nav-span">Location</span>
	       		</a>

	       		<a class=" " href="${ pageContext.request.contextPath }/cs/cs.do">
		       		<span class=" font-cookie nav-span">C/S</span>
	       		</a>

	       		<c:if test='${ empty loginMember || loginMember.memberId ne "admin" }'>
	       			<a class=" " href="${ pageContext.request.contextPath }/member/myPage.do">
	       				<span class=" font-cookie nav-span">MyPage</span>
	       			</a>
	       		</c:if>
	       		<c:if test='${ ! empty loginMember && loginMember.memberId eq "admin" }'>
	       			<a class=" " href="${ pageContext.request.contextPath }/Member/MemberList.do">
	       				<span class=" font-cookie nav-span">Manage</span>
	       			</a>
	       		</c:if>

       			<c:if test="${ empty loginMember }">
       				<a class=" " href="${ pageContext.request.contextPath}/member/memberLogin.do"><span class=" font-cookie nav-span">Login</span></a>
       			</c:if>
       			<c:if test="${! empty loginMember }">
       				<a class=" " href="${ pageContext.request.contextPath}/member/logout.do"><span class=" font-cookie nav-span">Logout</span></a>
       			</c:if>  	
    		</div>	
      
	       	<div class="login-div">
		       	<c:if test="${! empty loginMember }">
					<span class="font-cookie loginMember-span" ><b class="font-cookie ">${ loginMember.memberName }</b> 님, 반갑습니다.</span>
					<c:if test='${ loginMember.memberId eq "admin" }'>
						<input type="button" value="erp" onclick="location.href='${pageContext.request.contextPath}/ERP/erpMain.do';" />
					</c:if>
				</c:if>
			</div>
	 	</div>
	</nav>
</header>
<br />
<section id="content-sec">
<div class="container">


