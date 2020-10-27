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
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
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
		</form>
	</div> 
	
	<div class="product-list">
		<ul>
			<li>
				<!-- 상품이 있을 경우 -->
				<c:if test="${ not empty list }">
						<c:forEach items="${ list }" var="product">
						<dl>
								<a href="${ pageContext.request.contextPath }/product/productDetail.do?productNo=${ product.productNo }"  >
									<dt>
										<c:if test="${ not empty product.pmiList }" >
											<c:forEach items="${ product.pmiList }" var="pmi" varStatus="vs">
											<div class="img-container" >
												<img src="${ pageContext.request.contextPath }/resources/upload/mainimages/${pmi.renamedFilename}"
													 alt="img" 
													 width="250px"
													 id="imgTag"/>
											</div>
											</c:forEach>
										</c:if>
										<!-- <img id="Thums"
											 alt="Thumnail" 
											 width="250px" /> -->
										<c:if test="${ empty product.pmiList }">
											<script>
											console.log("empty");
											</script>	
										</c:if>	 
									</dt>
									<dd>
										<div class="product-name">
										상품명 : ${ product.productName }
										</div>
										<div class="product-price">
										상품 가격 : ${ product.price } 
										</div>
										<div class="product-rank">
										별점 : /10
										</div>
										<div class="product-date">
										등록일 : <fmt:formatDate value="${ product.regDate }" pattern="yyyy년MM월dd일"/>									
										</div>
										<div class="product-brand">
										제조사 ${ product.manufacturerId }
										</div>
									</dd>
							</a>
							
						</dl>
							
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