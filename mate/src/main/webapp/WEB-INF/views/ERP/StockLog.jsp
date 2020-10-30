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
			<h2>재고관리</h2>
			<div id="buy" class="tab-pane fade active show in">
				<div class="col-md-15">
				    <div class="form-area">  
						<form id="searchFrm" method="POST">
							<table id="purchaseLog-table" class="table">
								<thead>
									<tr>
										<th>
										  	<select name="branchId" id="branchId">
											    <option value="" disabled selected>지점 선택</option>
											    <c:forEach items="${empList}" var="list">
											    <c:if test="${list.status eq 1 }">
											    <option value="${list.empId}">${list.empName}</option>
											    </c:if>
											    <c:if test="${list.status eq 0  }">
											    <option value="${list.empId }">온라인</option>
											    </c:if>
											    </c:forEach>
											</select>
										</th>
										<th>
										  	<select name="searchType" id="searchType">
											    <option value="" disabled selected>검색 타입 선택</option>
											    <option value="product_no">상품번호</option>
											    <option value="product_name">상품명</option>
											</select>
										</th>
										<th>	
										    <input type="text" name="searchKeyword" class="form-control" placeholder="내용을 입력해주세요">
										</th>
										<th>
										  <button type="button" class="btn btn-default" id="searchStock">검색</button>
										</th>
									</tr>
								
								</thead>
								<tbody class="thead-dark">
									<tr>
										<th scope="col">보유점</th>
										<th scope="col">상품번호</th>
										<th scope="col">상품명</th>
										<th scope="col">카테고리</th>
										<th scope="col">제조사</th>
										<th scope="col">수량</th>
									</tr>
								</tbody>
								<tfoot class="stockInfo">
								<c:if test="${ not empty list }">
									<fmt:setLocale value="ko_kr"/>
										<c:forEach items="${ list }" var="stock">
											<tr>
												<td>${ stock.empName }</td>
												<td>${ stock.productNo }</td>
												<td>${ stock.productName }</td>
												<td>${ stock.category }</td>
												<td>${ stock.manufacturerName }</td>
												<td>${ stock.stock }</td>
											</tr>
										</c:forEach>
								</c:if>
								</tfoot>
								<c:if test="${ empty list }">
									<tr>
										<td colspan="8">검색결과 없음</td>
									</tr>
								</c:if>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>

<jsp:include page="/WEB-INF/views/common/footerE.jsp"/>
<script>
$("#searchStock").click(function(){

	var formData = $("#searchFrm").serialize();

	$.ajax({
		url : "${pageContext.request.contextPath}/ERP/searchStock.do",
		type: "POST",
		data : formData,
		success: function(data) {
			console.log(data);
			displayStock(data);
			
	    },
	    error: function(error) {
		    alert("상품이 존재하지 않습니다.");
			console.log(error);
		}
	});
	
});

function displayStock(data){
	var $container = $(".stockInfo");
	var html = "<fmt:setLocale value='ko_kr'/>";

	for(var i in data){
		var m = data[i];
		html += "<tr>"
			+"<td>" + m.empName + "</td>"
			+"<td>" + m.productNo + "</td>"
			+"<td>" + m.productName + "</td>"
			+"<td>" + m.category + "</td>"
			+"<td>" + m.manufacturerName + "</td>"
			+"<td>" + m.stock + "</td>"
			+"</tr>";
		
	}
	$container.html(html);
}

</script>	
</html>