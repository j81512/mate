<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<div class="product-container">
<form id="productDetailFrm">
	<div class="product-content">
	<!-- 내용이 입력될 자리 -->
	${ product.content }
	</div>
	
	<div class="product-detail">
		<div class="product-name">
			상품명 : <span>${ product.productName }</span>
		</div>
		
		<div class="product-category">
			카테고리 : <span>${ product.category }</span>
		</div>
		
		<div class="product-price">
			가격 : <span><fmt:formatNumber value="${ product.price }" pattern="#,###"></fmt:formatNumber></span>원
		</div>
		
		<c:choose>
			<c:when test="${ not empty loginMember }">
				<!-- 구입 수량 입력  -->
				<div class="product-amount">
					수량 : <input type="range" name="amount" />
				</div>
				
				<!-- 일반 쇼핑몰 회원일 경우 장바구니 | 구매하기 버튼 추가 -->
				<div class="btn-group">
					<button type="button" class="btn btn-primary">장바구니</button>
					<button type="button" class="btn btn-primary">구매하기</button>
				</div>
			</c:when>
			
			<c:otherwise>
				<!-- erp사용 회원일 경우 수정하기 | 삭제하기 버튼 추가 -->
				<div class="btn-group">
					<button type="button" class="btn btn-primary">수정하기</button>
					<button type="button" class="btn btn-primary">삭제하기</button>
				</div>
			</c:otherwise>
		</c:choose>
		
		
	
	</div>
</form>
</div>
<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>