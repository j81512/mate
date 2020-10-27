<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/loginForm.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous">
</script>
<jsp:include page="/WEB-INF/views/common/headerE.jsp"/>
</head>
 	<body>  
		<div class="container">
		
			<div id="buy" class="tab-pane fade active show in">
				<div class="col-md-15">
				    <div class="form-area">  
						<table id="purchaseLog-table" class="table">
							<thead>
								<tr>
									<th>
									  	<select name="searchType" id="searchType">
										    <option value="">검색타입</option>
										    <option value="online"${ 'online' eq param.searchType ? 'selected' : '' }>온라인</option>
										    <option value="gn"${ 'gn' eq param.searchType ? 'selected' : '' }>강남점</option>
										    <option value=""${ '' eq param.searchType ? 'selected' : '' }></option>
										    <option value=""${ '' eq param.searchType ? 'selected' : '' }></option>
										    <option value=""${ '' eq param.searchType ? 'selected' : '' }></option>
										</select>
									</th>
									<th>
									  	<select name="productlist" id="productlist">
										    <option value="no">상품번호</option>
										    <option value="name">상품명</option>
										</select>
									</th>
									<th>	
									    <input type="text" class="form-control" placeholder="내용을 입력해주세요">
									</th>
									<th>
									  <button type="submit" class="btn btn-default">검색</button>
									</th>
								</tr>
							</thead>
							<tbody class="thead-dark">
								<tr>
									<th scope="col">구분</th>
									<th scope="col">보유점</th>
									<th scope="col">상품번호</th>
									<th scope="col">상품명</th>
									<th scope="col">카테고리</th>
									<th scope="col">브랜드</th>
									<th scope="col">수량</th>
									<th scope="col">업체명</th>
								</tr>
							</tbody>
							<c:if test="${ not empty list }">
								<tfoot>
								<fmt:setLocale value="ko_kr"/>
									<c:forEach items="${ list }" var="stock">
										<tr>
											<td>${ ioLog.status }</td>
											<td>${ receive.empId }</td>
											<td>${ product.productNo }</td>
											<td>${ product.productName }</td>
											<td>${ product.category }</td>
											<td>${ product.empId }</td>
											<td>${ ioLog.amount }</td>
											<td>${ product.empId }</td>
										</tr>
									</c:forEach>
								</tfoot>
							</c:if>
							<c:if test="${ empty list }">
								<tr>
									<td colspan="8">검색결과 없음</td>
								</tr>
							</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>