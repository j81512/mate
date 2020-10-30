<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerE.jsp"/>
<c:if test="${not empty msg }">
	<script>
		alert("${msg}");
	</script>
</c:if>
<style>
.scroll-area{
	height:15px;
	overflow:auto;
}
</style>

<!-- CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<!-- jQuery and JS bundle w/ Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
	<div class="container">
		<div class="scroll-area">
			<div class="nav">
			<h2>입고 관리</h2>
				<table class="table">
				  <thead class="thead-dark">
				    <tr>
				      <th scope="col">#</th>
				      <th scope="col">상품명</th>
				      <th scope="col">카테고리</th>
				      <th scope="col">가격</th>
				      <th scope="col">제조사</th>
				      <th scope="col">재고</th>
				      <th scope="col">발주량</th>
				      <th scope="col">승인 여부</th>
				      <th scope="col">입고 승인</th>
				      <th scope="col">입고 거부</th>
				    </tr>
				  </thead>
				  
				  <tbody>
				  <!-- 입고 요청이 있을 경우 -->
				  <c:if test="${not empty list }">
					  <c:forEach items="${list}" var="rec" varStatus="vs">
					  	<tr>
					  		<td>${vs.count}</td>
					  		<td>${rec.productName }</td>
					  		<td>${rec.category }</td>
					  		<td>${rec.price }</td>
					  		<td>${rec.manufacturerId }</td>
					  		<td>${rec.stock }</td>
					  		<td>${rec.amount }</td>
					  		<td>${rec.confirm eq 0 ? '승인 대기' : '승인 거부' }</td>
					  		<td>
								<button type="button" onclick="appReceive(${rec.receiveNo});">입고 승인</button>
							</td>
					  		<td>
					  			<button type="button" onclick="refReceive(${rec.receiveNo});">입고 거부</button>
					  		</td>
					  	</tr>
					  </c:forEach>
				  </c:if>
				</div>	
				  <!-- 입고 요청이 없을 경우 -->
					  <c:if test="${empty list }">
						  <tr>
						  	<td rowspam="9">입고 목록이 없습니다.</td>
						  </tr>
					  </c:if> 
				  </tbody>
				</table>
			</div>
	</div>
<script>
function appReceive(no){
	var confirm_val = confirm("해당 상품을 입고처리 하시겠습니까?");

	if(confirm_val){
		location.href="${pageContext.request.contextPath}/ERP/appReceive.do?receiveNo="+no;
	}
	
}
function refReceive(no){
	var confirm_val = confirm("해당 상품 입고처리를 거절하시겠습니까?");

	if(confirm_val){
		location.href="${pageContext.request.contextPath}/ERP/refReceive.do?receiveNo="+no;
	}
	
}

</script>


<jsp:include page="/WEB-INF/views/common/footerE.jsp"/>