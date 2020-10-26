<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.mate.product.model.vo.ProductMainImages"%>
<%@page import="com.kh.mate.product.model.vo.Product"%>
<%@page import="java.util.List"%>
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

li{
	margin 0;
	list-style: none;
	display: inline-block;
}
</style>
<script>
 function pageing(now,cnt){
	var $nowPage = $('[name = nowPage]');
	var $cntPerPage = $('[name = cntPerPage]');
	var $search = $('[name = search]');
	
	$nowPage.val(now);
	$cntPerPage.val(cnt);
	$search.submit();

	 }
</script>
<div class="product-container">
	<!-- ajax처리 -->
	 <div class="product-search">
		<form class="form-inline"
				action="${pageContext.request.contextPath}/product/searchProduct.do">
		    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="search">
			<br />
			<p>카테고리 선택</p>
				<label for="pm">프라모델</label>
				<input type="checkbox" name="category" id="pm" value="pm"/>
				<label for="fg">피규어</label>
				<input type="checkbox" name="category" id="fg" value="fg"/>
				<label for="rc">RC카</label>
				<input type="checkbox" name="category" id="rc" value="rc"/>
				<label for="dr">드론</label>
				<input type="checkbox" name="category" id="dr" value="dr"/>
		    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			<input type="hidden" name="category" value="${ category }" />
			<input type="hidden" name="nowPage" value="1" />
			<input type="hidden" name="cntPerPage" value="8" />
		</form>
	</div> 
	
	<div class="product-list">
		<ul>
			<li>
				<!-- 상품이 있을 경우 -->
				<c:if test="${ not empty list }">
					<c:forEach items="${ list }" var="product">
					<div class="card">
						<div class="top-section">
							<img src="대표이미지" alt="대표이미지" id="mainImg1"/>
						</div>
						<div class="nav">
							<c:forEach items="${list.pmiList }" var="Thumbs" varStatus="vs">
								<img src="${pageContext.request.contextPath}/resources/upload/mainimages/${Thumbs.renamedFilename}" alt="thums${vs.count}" id="thumbs${vs.count}"/>
							</c:forEach>
						</div>
						<div class="productName">
						${product.productName}
						</div>
						<div class="price">
						${product.pridce}원
						</div>
					</div>
					</c:forEach>
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
<div style="display: block; text-align: center;">
	<c:if test="${ page.startPage != 1 }">
		<a href="#"onclick="pageing('${ paging.startPage - 1}','${ paging.cntPerPage }')">&lt;</a>
	</c:if>
	<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
			<c:choose>
				<c:when test="${p == paging.nowPage }">
					<b>${p }</b>
				</c:when>
				<c:when test="${p != paging.nowPage }">
					<a href="#"onclick="pageing('${ p }','${ paging.cntPerPage }')">${p+1 }</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="#" onclick="pageing('${ paging.endPage+1 }','${ paging.cntPerPage }')">&gt;</a>
		</c:if>

</div>

<jsp:include page="/WEB-INF/views/common/footerS.jsp"></jsp:include>