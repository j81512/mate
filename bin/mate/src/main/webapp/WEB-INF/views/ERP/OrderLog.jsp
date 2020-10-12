<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
</head>
  <body>  
	<section id="info-container" class="container">
	  <div class="form-group"
	  	   style="width: 1280px">
		<form class="navbar-form navbar-left" 
			  role="search"
			  action="${pageContext.request.contextPath}/ERP/searchInfo.do">
			  <div class="child">
			  	<select name="orderemplist" id="orderemplist">
				    <option value="all">전체</option>
				    <option value="online">온라인</option>
				    <option value="gn">강남점</option>
				    <option value="yn">용인점</option>
				</select>
			  	<select name="status" id="status">
				    <option value="">상태</option>
				    <option value="all">전체</option>
				    <option value="process">처리중</option>
				    <option value="cancel">취소</option>
				    <option value="complete">처리완료</option>
				</select>
				<input type="date" />
				<select name="productlist" id="productlist">
				    <option value="no">상품번호</option>
				    <option value="name">상품명</option>
				</select>
			    <input type="text" class="form-control" placeholder="내용을 입력해주세요">
			  	<button type="submit" class="btn btn-default">검색</button>
			  </div>
		</form>
	  </div>
	</section>
	
	<section>
		<div class="productInfo">
			<tr>
				<th>발주번호</th>
				<th>상품명</th>
				<th>발주자</th>
				<th>발주 날짜</th>
				<th>발주량</th>
				<th>상태</th>
			</tr>
		</div>
		
		
		<div class="productInfo">
			<tr>
				<td>${ request_log.no }</td>
				<td>${ product.productName }</td>
				<td>${ emp.emp_id }</td>
				<td><fmt:formatDate value="${ request_log.request_date }" pattern="yyyy년MM월dd일"/></td>
				<td>${ request_log.amount }</td>
				<td>${ request_log.confirm }</td>
			</tr>
		</div>
	</section>

	</body>
</html>