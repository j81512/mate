<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>    
<jsp:include page="/WEB-INF/views/common/headerS.jsp"></jsp:include>

<c:if test="${ not empty msg }">
	<script>
		alert("${msg}");
	</script>
</c:if>

<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">상품 이미지</th>
      <th scope="col">상품명</th>
      <th scope="col">카테고리</th>
      <th scope="col">가격</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
      <th scope="col">삭제</th>
    </tr>
  </thead>
  <tbody>
    <c:if test="${ not empty cart }">
    <c:forEach items="${cart}" var="c" varStatus="vs">
    	<tr>
    		<th scope="row">${vs.count }</th>
    		<td>
    			<img src="${ pageContext.request.contextPath }/resources/upload/mainimages/${ c.selectedProduct.pmiList.get(0).renamedFilename }" 
    				 alt="상품이미지" width="50px"/>
    		</td>
    		<td>${ c.selectedProduct.productName }</td>
    		<td>
	    		<c:if test="${ c.selectedProduct.category eq 'fg' }">
	    		피규어
	    		</c:if>
	    		<c:if test="${ c.selectedProduct.category eq 'pm' }">
	    		프라모델
	    		</c:if>
	    		<c:if test="${ c.selectedProduct.category eq 'rc' }">
	    		RC카
	    		</c:if>
	    		<c:if test="${ c.selectedProduct.category eq 'dr' }">
	    		드론
	    		</c:if>
    		</td>
    		<td>
    			<fmt:formatNumber value="${ c.selectedProduct.price }" pattern="#,###"/>원
    		</td>
    		<td>${ c.amount }</td>
    		<td>
    			<fmt:formatNumber value="${c.amount * c.selectedProduct.price}" pattern="#,###" />원
    		</td>
    		
    		<td>
    			<div class="btn btn-group">
    				<button type="button" class="btn btn-danger" onclick="deletFromCart(${c.productNo});">삭제</button>
    			</div>
    		</td>
    	</tr>
    </c:forEach>
    </c:if>
  </tbody>
<caption> 합계금액 : <c:forEach items="${cart}" var="sum"><fmt:formatNumber value="${ sum.amount * sum.selectedProduct.price }" pattern="#,###"/>원</c:forEach></caption>
	<form action="">
		<button type="">구매 하기</button>	
		<button type="">뒤로 가기</button>	
		<button type="">구매하기</button>	
	</form>

</table>

<script>
function deletFromCart(no) {

	location.href = "${ pageContext.request.contextPath }/product/deleteFromCart.do?productNo="+no;
	
}
</script>

<jsp:include page="/WEB-INF/views/common/footerS.jsp"></jsp:include>