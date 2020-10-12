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

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<!-- 김찬희 카테고리 작업 스크립트 -->
<script>

function category(ct){

	console.log(ct);
	var $searchCategory = $('[name=searchCategory]');
	var $category = $('[name=category]');
	$category.val(ct);
	console.log($category.val())
	$searchCategory.submit();
	
}

</script>
<!-- 김찬희 카테고리작업 스크립트끝 -->
</head>
<body>

<header>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${ pageContext.request.contextPath }">
  	<img alt="Brand" src="${ pageContext.request.contextPath }/resources/img/home.jpg" width="45px">
  	Mate
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" 
           id="products" role="button" 
           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          	판매 상품 보기
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
      <li class="nav-item">
        <a class="nav-link" href="${ pageContext.request.contextPath }/company/location.do">판매점 위치</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">고객 센터</a>
      </li>
      <!-- 도균 수정 임시확인용 주소+링크 추가 -->
      <li class="nav-item">
        <a class="nav-link" href="${ pageContext.request.contextPath }/ERP/menu.do">ERP확인용</a>
      </li>

	<!-- 호근 수정 1. ${pageContext.request.contextPath}/member/login.do -->
	<!-- 호근 수정2. 회원가입 날림  -->
	<!-- 호근수정3. not empty로 바꿈 -->
	<c:choose>
		<c:when test="${ empty loginMember }">
			<li class="nav-item">
	        	<a class="nav-link" href="${ pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
	      	</li>
		</c:when>
		<c:otherwise >
			${ loginMember.memberName }님, 반갑습니다.	
			<button class="btn btn-outline-success my-2 my-sm-0" 
               type="button"
               onclick="location.href='${ pageContext.request.contextPath}/member/logout.do';">로그아웃</button>
		</c:otherwise>

	</c:choose>
    </ul>
  </div>
</nav>
<!-- 김찬희 작업 -->
<form action="${ pageContext.request.contextPath }/product/productCategory.do"
		name="searchCategory">
	<input type="hidden" name="category" value=""/>
</form>
<!-- 김찬희 작업끝 -->
</header>

