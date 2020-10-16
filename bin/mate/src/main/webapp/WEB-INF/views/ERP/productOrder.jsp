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
<<<<<<< HEAD
<script>
function orderModal(){

	$("#modelTest").modal()
	
}
</script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
</head>
  	<body onload="orderModal()">
		<section>
			
			<div class="modal" id="modelTest" tabindex="-1">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">발주</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			      
			      	<form action="productOrder" method="post">
			      	
			      		<p>현재수량 : ${ product.stock }</p>
			      		<p>상품번호 : ${ product.productNo }</p>
			      		<p>신청지점 : ${ product.empId }</p>
			      		<p>요청수량 : <input type="number" name="order" id="order" /></p>
			      		
					      <div class="modal-footer">
					        <button type="submit" class="btn btn-secondary" data-dismiss="modal">Close</button>
					        <button type="button" class="btn btn-primary">Save changes</button>
					      </div>
			      		
			      	
			      	</form>
			      
			      </div>
			    </div>
			  </div>
			</div>
					
=======

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
</head>
  	<body>
		<section>
			<div class="productInfo">
				<tr>
					<th>상품번호</th>
					<th>상품명</th>
					<th>카테고리</th>
					<th>브랜드</th>
					<th>입출고 날짜</th>
					<th>수량</th>
					<th>업체명</th>
					<th>상태</th>
				</tr>
			</div>
			
			
			<div class="productInfo">
				<tr>
					<td>${ product.no }</td>
					<td>${ product.productName }</td>
					<td>${ product.category }</td>
					<td>${ product.empId }</td>
					<td><fmt:formatDate value="${ product.regDate }" pattern="yyyy년MM월dd일"/></td>
					<td>${ receive.amount }</td>
					<td>${ emp.emp_id }</td>
					<td>
						<button type="submit">확인</button>
						<button type="submit">거절</button>
					</td>
				</tr>
			</div>
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
		</section>
	</body>
</html>