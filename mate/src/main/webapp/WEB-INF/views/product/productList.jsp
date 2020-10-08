<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>    
<jsp:include page="/WEB-INF/views/common/headerS.jsp"></jsp:include>
<style>
table, tr, th, td {
	border: 1px solid black;
}
</style>
<div class="product-container">
	<!-- ajax처리 -->
	<div class="product-search">
		<form class="form-inline">
		    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
	</div>
	
	<div class="product-list">
		<ul>
			<li>
				<!-- 상품이 있을 경우 -->
				<c:if test="${ not empty list }">
						<dl>
							<dt>
								<img src="${ pageContext.request.contextPath }/resources/images/default.jpg" 
									 alt="default" 
									 width="250px" />
							</dt>
							<dd>
								<div class="product-name">
								상품명
								</div>
								<div class="product-price">
								상품 가격
								</div>
								<div class="product-rank">
								별점
								</div>
								<div class="product-brand">
								브랜드명
								</div>
							</dd>
						</dl>
				</c:if>
				<!-- 상품이 없을 경우 -->
				<c:if test="${ empty list }">
					<li>
						<span>상품이 존재하지 않습니다.</span>
					</li>
				</c:if>
			</li>
		</ul>
	</div>
</div>
	

<jsp:include page="/WEB-INF/views/common/footerS.jsp"></jsp:include>