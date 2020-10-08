<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">

  </head>
  <body>
    <script 
    	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js">
    </script>   
    <script 
    	src="js/bootstrap.min.js">
    </script>
	<section id="info-container" class="container">
		<form class="navbar-form navbar-left" role="search">
		  <div class="form-group">
		  	<select name="category">
			    <option value="">카테고리</option>
			    <option value="pm">프라모델</option>
			    <option value="fg">피규어</option>
			    <option value="rc">RC카</option>
			    <option value="dr">드론</option>
			</select>
		  	<select name="brand">
			    <option value="">브랜드</option>
			    <option value="">1</option>
			    <option value="">2</option>
			    <option value="">3</option>
			    <option value="">4</option>
			</select>
		    <input type="text" class="form-control" placeholder="재고 수량">
			<p>이상</p>			
		    <input type="text" class="form-control" placeholder="재고 수량">
			<p>이하</p>			
		  	<select name="select">
			    <option value="">검색 분류</option>
			    <option value="">상품명</option>
			    <option value="">상품번호</option>
			</select>
		    <input type="text" class="form-control" placeholder="상품명/상품번호 조회">
		  </div>
		  <button type="submit" class="btn btn-default">검색</button>
		</form>

		<table id="tbl-productInfo" >
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>카테고리</th>
				<th>브랜드</th>
				<th>등록일</th>
				<th>재고</th>
				<th>상태</th>
			</tr>
			<tr>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
		</table>
	</section>
	</body>
</html>