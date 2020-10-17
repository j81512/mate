<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>    
<jsp:include page="/WEB-INF/views/common/headerS.jsp"></jsp:include>

<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">상품 이미지</th>
      <th scope="col">상품명</th>
      <th scope="col">카테고리</th>
      <th scope="col">가격</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
    </tr>
  </thead>
  <tbody>
    <c:if test="${ not empty cart }">
    <c:forEach items="${cart}" var="c">
    	<tr>
    		<th scope="row">1</th>
    		<td>상품 이미지 조인 한번 더 필요함</td>
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
    	</tr>
    </c:forEach>
    </c:if>
  </tbody>
</table>

<jsp:include page="/WEB-INF/views/common/footerS.jsp"></jsp:include>