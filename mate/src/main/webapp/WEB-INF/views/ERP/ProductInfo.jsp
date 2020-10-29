
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
$(function(){
	$("#search-btn").click();
});
</script>
</c:if>
<c:if test="${not empty click }">
<script>
	$("#search-btn").click();
</script>
</c:if>
</head>
<style>
.navbar-form .form-control-custom {
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
#search-group {
}
.child {
	display:table-cell;
}
.nav-container *{
	float: none;
	margin-left: 5px;
	margin-top: 10px;
    vertical-align: middle;
    
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
	<div class="container">
		<div class="name">
		<h2>상품 관리</h2>
			<div class="nav-container">
				<div class="form-group" id="search-group">
					<form class="navbar-form navbar-left" 
						  role="search"
						  action="${pageContext.request.contextPath}/ERP/searchInfo.do">
						  <table>
							  	<tr>
								  	<th>	
									  	<select name="category" id="category">
										    <option value="">카테고리</option>
										    <option value="pm" ${ map.category eq "pm" ? "selected='selected'" : '' }>프라모델</option>
										    <option value="fg" ${ map.category eq "fg" ? "selected='selected'" : '' }>피규어</option>
										    <option value="rc" ${ map.category eq "rc" ? "selected='selected'" : '' }>RC카</option>
										    <option value="dr" ${ map.category eq "dr" ? "selected='selected'" : '' }>드론</option>
										</select>
									</th>
									<th>		
									  	<select name="product-brand" id="product-brand">
										    <option value="">브랜드</option>
										    <option value="">1</option>
										    <option value="">2</option>
										    <option value="">3</option>
										    <option value="">4</option>
										</select>
									</th>
									<th>
							    		<input type="number" class="form-control-custom" name="upper" placeholder="재고 수량" value="${ map.uNum }">
									</th>
									<th>
										<p>이상</p>			
									</th>
									<th>
									    <input type="number" class="form-control-custom" name="lower" placeholder="재고 수량" value="${ map.lNum }" >
									</th>
									<th>
										<p>이하</p>			
									</th>
									<th>
									  	<select name="select">
										    <option value="">검색 분류</option>
										    <option value="product_name" ${ map.select eq "product_name" ? "selected='selected'" : '' }>상품명</option>
										    <option value="product_no" ${ map.select eq "product_no" ? "selected='selected'" : '' }>상품번호</option>
										</select>
									</th>
									<th>
									    <input type="text" class="form-control2" name="search" placeholder="상품명/상품번호 조회" value="${ map.search }">
									</th>
									<th>
									  <button type="submit" class="btn btn-default" id="search-btn" onclick="checkNum('${ map.uNum }','${ map.lNum }')">검색</button>
									</th>
									<th>
										<button type="button" class="btn btn-dark" onclick="productEnroll();">상품 등록</button>								
									</th>
							  </tr>
					  </table>	
					</form>
				</div>
		  	</div>
		</div>

			<table id="purchaseLog-table" class="table">
				<thead>
					<tr>
						<th scope="col">상품번호</th>
						<th scope="col">상품명</th>
						<th scope="col">카테고리</th>
						<th scope="col">제조사</th>
						<th scope="col">등록일</th>
						<th scope="col">재고</th>
						<th scope="col">상태</th>
						<!-- 로그인 상태가 관리자인 경우 상품 삭제 버튼 추가 -->
						<c:if test="${loninEmp.status eq 0 }">
						상품 삭제
						</c:if>
					</tr>
				</thead>
			
				<c:if test="${ not empty list }">
					<tbody>
						<c:forEach items="${ list }" var="product">
						<tr>
							<td>${ product.productNo }</td>
							<td><a href="${ pageContext.request.contextPath }/ERP/productUpdate.do?productNo=${product.productNo}">${ product.productName }</a></td>
							<td>${ product.category }</td>
							<td>${ product.manufacturerId }</td>
							<td><fmt:formatDate value="${ product.regDate }" pattern="yyyy년MM월dd일"/></td>
							<td>${ product.stock eq 0 ? '재고가 없습니다' : product.stock }</td>
							<td><button type="button" onclick="orderProduct('${ loginEmp.empId }',${ product.productNo },'${ product.manufacturerId }')">발주</button></td>
							<c:if test="${loginEmp.status eq 0 }">
							<td>
								<!-- 상품 삭제 폼 -->
								<button type="button" onclick="productDelete(${product.productNo});">상품 삭제</button>
							</td>
							
							
							
						</c:if>
						</tr>
						</c:forEach>
						<tr>
						
						</tr>
					</tbody>
				</c:if>
				
				<!-- 상품이 없을 경우 -->
				<c:if test="${ empty list }">
					<tr>
						<td colspan="8">등록된 상품이 없습니다.</td>
					</tr>
				</c:if>
	
		</table>
		</div>
	</div>
	
	<form action="${pageContext.request.contextPath}/ERP/orderERP.do" name="order">
		<input type="hidden" name="eId" value=""/>
		<input type="hidden" name="requestId" value=""/>
		<input type="hidden" name="pNo" value=""/>
	</form>
	
	<form id="productDelFrm"></form>
	

	

	<!-- 김찬희 페이징 -->
	<c:if test="${not empty list}">
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
	</c:if>

	</div>
	</div>
	
	
<script>
function productEnroll(){

location.href="${ pageContext.request.contextPath }/ERP/productEnroll.do";
	
}

function productDelete(no){
	var $frm = $("#productDelFrm");

	var confirm_val = confirm("정말로 상품을 삭제하시겠습니까?");

	if(confirm_val){
		location.href="${pageContext.request.contextPath}/ERP/productDelete.do?productNo="+no
	}
	else{return false;}


}
</script>
	</body>

</html>