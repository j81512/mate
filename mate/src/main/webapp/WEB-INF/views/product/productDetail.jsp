<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>

<c:if test="${ not empty msg }">
	<script>
		alert("${msg}");
	</script>
</c:if>


<div class="product-container">
<form id="productDetailFrm">
	
	<!-- 상품 번호 -->
	<input type="hidden" name="productNo" value="${ product.productNo }" />
	<input type="hidden" name="memberId" value="${ loginMember.memberId }" />
	
	<!-- 내용이 입력될 자리 -->
	<div class="product-content">
	${ product.content }
	</div>
	
	<div class="product-detail">
		<div class="product-name">
			상품명 : <span>${ product.productName }</span>
		</div>
		
		<div class="product-category">
			카테고리 : <span>
				<c:if test="${ product.category eq 'fg' }">
	    		피규어
	    		</c:if>
	    		<c:if test="${ product.category eq 'pm' }">
	    		프라모델
	    		</c:if>
	    		<c:if test="${ product.category eq 'rc' }">
	    		RC카
	    		</c:if>
	    		<c:if test="${ product.category eq 'dr' }">
	    		드론
	    		</c:if>
			</span>
		</div>
		
		<div class="product-price">
			가격 : <span><fmt:formatNumber value="${ product.price }" pattern="#,###"></fmt:formatNumber></span>원
		</div>
		
		<!-- 구입 수량 입력  -->
		<div class="product-amount">
			수량 : <input type="number" name="amount" required/> 개
		</div>
		
				<!-- 일반 쇼핑몰 회원일 경우 장바구니 | 구매하기 버튼 추가 -->
				<div class="btn-group">
					<button type="button" class="btn btn-primary" onclick="saveCart();">장바구니</button>
					<button type="submit" class="btn btn-primary" onclick="purchaseProduct();">구매하기</button>
				</div>
	
	</div>
</form>
</div>

<script>
function saveCart(){
	var $frm = $("#productDetailFrm");
	$frm.attr("action", "${ pageContext.request.contextPath}/product/saveCart.do");
	$frm.attr("method", "POST");
	$frm.submit();
	
}

function purchaseProduct(){
	var $frm = $("#productDetailFrm");
	$frm.attr("action", "${ pageContext.request.contextPath }/product/purchaseProduct.do");
	$frm.attr("method", "POST");
	$frm.submit();
	
}
</script>

<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>