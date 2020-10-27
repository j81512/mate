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
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/headerS.css" />
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
</head>
<body>
<header>
<div class="container-fluid">
    <!-- Second navbar for categories -->
    <nav class="navbar navbar-default">
      <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse-1">
          <span class="sr-only"><img src="${ pageContext.request.contextPath }/resources/images/play.png"  width="50px" class="menuImg"/></span>
          </button>
          <a class="navbar-brand" href="${ pageContext.request.contextPath }">Mate</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="navbar-collapse-1">
          <ul class="nav navbar-nav navbar-right">
              <a class="btn btn-default btn-outline btn-circle"  data-toggle="collapse" href="#nav-collapse1" aria-expanded="false" aria-controls="nav-collapse1">
              	<img src="${ pageContext.request.contextPath }/resources/images/play.png" width="50px" class="menuImg"/>
              </a>
          </ul>
          <ul class="collapse nav navbar-nav nav-collapse" id="nav-collapse1">
            <li><a href="${ pageContext.request.contextPath }/Member/MemberList.do">회원관리</a></li>
            <li><a href="${pageContext.request.contextPath}/cs/cs.do">C/S</a></li>
            <li><a href="${ pageContext.request.contextPath }/company/location.do">Location</a></li>
            <!-- 1. 추가 : 판매 상품 보기 -> toy -->
            <li class="nav-item dropdown">
		        <a class="nav-link dropdown-toggle" href="#"
		           id="products" role="button"
		           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          	Toy
		        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	        <!-- 종완 수정 - 주소추가 -->
	          <a class="dropdown-item" href="${ pageContext.request.contextPath }/product/productList.do">전체 상품 보기</a>
	          <div class="dropdown-divider"></div>
	           <!-- 김찬희 헤더 카테고리검색 추가함 -->
	          <a class="dropdown-item" onclick="category('PM')">프라모델</a>
	          <a class="dropdown-item" onclick="category('FG')">피규어</a>
	          <a class="dropdown-item" onclick="category('RC')">RC카</a>
	         <a class="dropdown-item" onclick="category('DR')">드론</a>
	        </div>
	   	 	</li>
   	 	
   	 		<c:if test="${not empty loginEmp }" >
			${ loginEmp.empName }님, 반갑습니다.	
			<button class="btn btn-outline-success my-2 my-sm-0"
	               type="button"
	               onclick="location.href='${ pageContext.request.contextPath}/ERP/logout.do'"><img src="${ pageContext.request.contextPath }/resources/images/cart.png" width="80px" class="loginImg"/>로그아웃</button>
			</c:if>
	   	 	</ul>
  		</div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav><!-- /.navbar -->
</div><!-- /.container-fluid -->
</header>
<section id="content-sec">