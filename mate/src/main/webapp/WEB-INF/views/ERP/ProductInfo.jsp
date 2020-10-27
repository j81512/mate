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
<c:if test="${not empty msg }">
<script>
	alert("${msg}");
</script>
</c:if>
</head>
<style>
.navbar-form .form-control {
    display: inline-block;
    width: 100px;
    hight: 50px;
    vertical-align: middle;
}
.form-control2 {
    display: inline-block;
    width: 200px;
    vertical-align: middle;
}
.form-group {
    display:table;
}
.child {
	display:table-cell;
}
div{
	float: left;
	margin : 5px;

}

</style>
<!-- 김찬희 발주 스크립트 -->
<script>
function orderProduct(empId,pNo,requestId){
	console.log(empId);
	console.log(pNo);
	var $eId = $('[name = eId]');
	var $requestId = $('[name = requestId]');
	var $pNo = $('[name = pNo]');
	var $order = $('[name = order]');
	$eId.val(empId);
	$pNo.val(pNo);
	$requestId.val(requestId);

	$order.submit();
	
}
</script>
  <body>
    
	<section id="info-container" class="container">
	  <div class="form-group"
	  	   style="width: 1280px">
		<form class="navbar-form navbar-left" 
			  role="search"
			  action="${pageContext.request.contextPath}/ERP/searchInfo.do">
			  <div class="child">
			  	<select name="category" id="category">
				    <option value="">카테고리</option>
				    <option value="pm">프라모델</option>
				    <option value="fg">피규어</option>
				    <option value="rc">RC카</option>
				    <option value="dr">드론</option>
				</select>
			  </div>
			  <div class="child">
			  	<select name="product-brand" id="product-brand">
				    <option value="">브랜드</option>
				    <option value="">1</option>
				    <option value="">2</option>
				    <option value="">3</option>
				    <option value="">4</option>
				</select>
			  </div>
			  <div class="child">
			    <input type="number" class="form-control" name="upper" placeholder="재고 수량">
			  </div>
			  <div class="child">
				<p>이상</p>			
			  </div>
			  <div class="child">
			    <input type="number" class="form-control" name="lower" placeholder="재고 수량">
			  </div>
			  <div class="child">
				<p>이하</p>			
			  </div>
			  <div class="child">
			  	<select name="select">
				    <option value="">검색 분류</option>
				    <option value="product_name">상품명</option>
				    <option value="product_no">상품번호</option>
				</select>
			  </div>
			  <div class="child">
			    <input type="text" class="form-control2" name="search" placeholder="상품명/상품번호 조회">
			  </div>
			  <button type="submit" class="btn btn-default">검색</button>
		</form>
	  </div>
	</section>
	
	
	<section>
		<div class="productInfo">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>카테고리</th>
				<th>브랜드</th>
				<th>등록일</th>
				<th>재고</th>
				<th>상태</th>
				<!-- 로그인 상태가 관리자인 경우 상품 삭제 버튼 추가 -->
				<c:if test="${loninEmp.status eq 0 }">
					상품 삭제
				</c:if>
				
			</tr>
		</div>
		
		
		<div class="productInfo">
			<c:if test="${ not empty list }">
					<c:forEach items="${ list }" var="product">
					<tr>
						<td>${ product.productNo }</td>
						<td><a href="${ pageContext.request.contextPath }/ERP/productUpdate.do?productNo=${product.productNo}">${ product.productName }</a></td>
						<td>${ product.category }</td>
						<td>${ product.manufacturerId }</td>
						<td><fmt:formatDate value="${ product.regDate }" pattern="yyyy년MM월dd일"/></td>
						<td>${ product.stock eq 0 ? '재고가 없습니다' : product.stock }</td>
						<td><button type="button" onclick="orderProduct('${ loginEmp.empId }',${ product.productNo },${ product.empId })">발주</button></td>
						<c:if test="${loginEmp.status eq 0 }">
						<td>
							<button type="button" onclick="productDelete();">상품 삭제</button>
						</td>
						</c:if>
					</tr>
				<form id="productDelFrm">
					<input type="hidden" name="productNo" value="${product.productNo }"/>
				</form>
				</c:forEach>		
			</c:if>
			<c:if test="${ empty list }">
				<span>검색결과 없음</span>
			</c:if>
		</div>
		<form action="${pageContext.request.contextPath}/ERP/orderERP.do" name="order">
			<input type="hidden" name="eId" value=""/>
			<input type="hidden" name="requestId" value=""/>
			<input type="hidden" name="pNo" value=""/>
		</form>
	</section>
	
	<br />
	<!-- 종완 상품 등록 버튼  -->
	<section id="product-enroll-btn">
		<div class="form-group">
			<button type="button" class="btn btn-light" onclick="history.go(-1)">뒤로 가기</button>
			<button type="button" class="btn btn-dark" onclick="productEnroll();">상품 등록</button>
		</div>
	</section>
	
	<!-- 김찬희 페이징 -->
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
  		<c:if test="${ page.nowPage != 1 }">
	      <a class="page-link" href="${pageContext.request.contextPath}/ERP/searchInfo.do?nowPage=${page.nowPage-1 }&cntPerPage=
					${page.cntPerPage}&search=${ map.search }&category=${ map.category }&
					select=${ map.select}&upper=${ upper }&lower=${ lower }">Previous</a>
  		</c:if>
  	<c:forEach begin="${page.startPage }" end="${page.endPage}" var="p">
  		<c:choose>
  		<c:when test="${ p == page.nowPage }">
		    <li class="page-item"><a class="page-link" href="#" style="color: black">${p }</a></li>
  		</c:when>
  		<c:when test="${ p != page.nowPage }">
		    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/ERP/searchInfo.do?nowPage=${p }&cntPerPage=
					${page.cntPerPage}&search=${ map.search }&category=${ map.category }&
					select=${ map.select}&upper=${ upper }&lower=${ lower }">${p }</a></li>
  		</c:when>
  		</c:choose>
  	</c:forEach>
  	<c:if test="${ page.nowPage != page.endPage }">
	      <a class="page-link" href="${pageContext.request.contextPath}/ERP/searchInfo.do?nowPage=${page.nowPage+1 }&cntPerPage=
					${page.cntPerPage}&search=${ map.search }&category=${ map.category }&
					select=${ map.select}&upper=${ upper }&lower=${ lower }">Next</a>
  	</c:if>
  </ul>
</nav>
	
	
<script>
function productEnroll(){

location.href="${ pageContext.request.contextPath }/ERP/productEnroll.do";
	
}

function productDelete(){
	var $frm = $("#productDelFrm");


	$frm.attr("action", "${pageContext.request.contextPath}/ERP/productDelete.do");
	$frm.attr("method", "post");
	$frm.submit();

}
</script>
	</body>
</html>