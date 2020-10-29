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
.product-list{
	display: inline-block;
}
.card{
	width: 360px;
	background : #F1F1F1;
	display:inline-block;
}
.top-section{
	height: 310px;
	overflow: hidden;
	background: #fff;
	position: relative;
}
#mainImg{
	weight: 360px;
	height: 240px;
}
.imgNav{
	text-align: center;
}
.imgNav img{
	width: 80px;
	height: 50px;
	border: 1px solid #ddd;
	margin: 8px 2px;
	cursor:pointer;
	transition: 0.3s;
}
.imgNav img:hover{
	border-color: #6AB04C;
}
.product-info{
	padding: 25px;
}
.name{
	text-transform: uppercase;
	font-size: 24px;
	color: #333;
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

 function sReset(){
	 location.href="${ pageContext.request.contextPath }/product/productList.do";
	 }
</script>
<div class="container">
	<!-- ajax처리 -->
	 <div class="product-search">
		<form class="form-inline"
				action="${pageContext.request.contextPath}/product/searchProduct.do">
		    <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="search" value="${ search }">
			<br />
			<p>카테고리 선택</p>
				<label for="pm">프라모델</label>
				<input type="checkbox" name="category" id="pm" value="pm" ${ sCategory.contains("pm") ? 'checked' : '' }/>
				<label for="fg">피규어</label>
				<input type="checkbox" name="category" id="fg" value="fg" ${ sCategory.contains("fg") ? 'checked' : '' }/>
				<label for="rc">RC카</label>
				<input type="checkbox" name="category" id="rc" value="rc" ${ sCategory.contains("rc") ? 'checked' : '' }/>
				<label for="dr">드론</label>
				<input type="checkbox" name="category" id="dr" value="dr" ${ sCategory.contains("dr") ? 'checked' : '' }/>
		    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			<input type="hidden" name="category" value="${ category }" />
			<input type="hidden" name="nowPage" value="1" />
			<input type="hidden" name="cntPerPage" value="4" />
		</form>
		<input type="button" class="btn btn-outline-success my-2 my-sm-0" value="검색초기화" onclick="sReset()"/>
	</div>
	
	<div class="product-list">
				<!-- 상품이 있을 경우 -->
				<c:if test="${ not empty list }">
					<c:forEach items="${ list }" var="product">
					<div class="card">
						<div class="top-section">
						<a href="${pageContext.request.contextPath}/product/productDetail.do?productNo=${product.productNo}">
							<img src="${pageContext.request.contextPath}/resources/upload/mainimages/${product.pmiList[0].renamedFilename}"
								 alt="대표이미지" class="mainImg"
								 width="200px"/>
						</a>
						</div>
						<div class="imgNav">
							<c:forEach items="${product.pmiList }" var="Thumbs" varStatus="vs">
								<img src="${pageContext.request.contextPath}/resources/upload/mainimages/${Thumbs.renamedFilename}"
									 alt="thums${vs.count}"
									 width="50px" class="imgNav-img"/>
							</c:forEach>
						</div>
						<hr />
						<a href="${pageContext.request.contextPath}/product/productDetail.do?productNo=${product.productNo}">
						<div class="product-info">
							<div class="productName">
							상품명 : ${product.productName}
							</div>
							<div class="price">
							가격 : ${product.price}원
							</div>
							<div class="category">
							카테고리 :
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
							</div>
							<div class="manufac">
							제조사 : ${product.manufacturerId}
							</div>
						</div>
						</a>
					</div>
					</c:forEach>
				</c:if>
				<!-- 상품이 없을 경우 -->
				<c:if test="${ empty list }">
						<span>상품이 존재하지 않습니다.</span>
				</c:if>
	</div>
</div>
<script>
$(".imgNav-img").click(function(){
	
	var src = $(this).attr("src");
	var $topSectionImg = $(this).parent().siblings().siblings(".top-section").find("img");
	$topSectionImg.attr("src", src);
});
</script>
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
  		<c:if test="${ page.nowPage != 1 }">
	      <a class="page-link" href="${pageContext.request.contextPath}/product/searchProduct.do?nowPage=${page.nowPage-1 }&cntPerPage=${page.cntPerPage}&search=${ search }&category=${ sCategory }" tabindex="-1" aria-disabled="true">Previous</a>
  		</c:if>
  	<c:forEach begin="${page.startPage }" end="${page.endPage}" var="p">
  		<c:choose>
  		<c:when test="${ p == page.nowPage }">
		    <li class="page-item"><a class="page-link" href="#" style="color: black">${p }</a></li>
  		</c:when>
  		<c:when test="${ p != page.nowPage }">
		    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/product/searchProduct.do?nowPage=${p }&cntPerPage=${page.cntPerPage}&search=${ search }&category=${ sCategory }">${p }</a></li>
  		</c:when>
  		</c:choose>
  	</c:forEach>
  	<c:if test="${ page.nowPage != page.endPage }">
	      <a class="page-link" href="${pageContext.request.contextPath}/product/searchProduct.do?nowPage=${page.nowPage+1 }&cntPerPage=${page.cntPerPage}&search=${ search }&category=${ sCategory }">Next</a>
  	</c:if>
  </ul>
</nav>
<%-- <jsp:include page="/WEB-INF/views/common/footerS.jsp"></jsp:include> --%>