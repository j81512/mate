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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous">
</script>
</head>
  	<body>
		<div class="container">
			<div id="buy" class="tab-pane fade active show in">
				<div class="col-md-15">
				    <div class="form-area">  
						<table id="purchaseLog-table" class="table">
							<tr>
								<th>상품번호</th>
								<th>상품명</th>
								<th>카테고리</th>
								<th>브랜드</th>
								<th>입출고 날짜</th>
								<th>수량</th>
								<th>업체명</th>
								<th>상태</th>
							</tr>
							<tr>
								<td>${ product.no }</td>
								<td>${ product.productName }</td>
								<td>${ product.category }</td>
								<td>${ product.empId }</td>
								<td><fmt:formatDate value="${ product.regDate }" pattern="yyyy년MM월dd일"/></td>
								<td>${ receive.amount }</td>
								<td>${ emp.emp_id }</td>
								<td>
									<button type="submit">확인</button>
									<button type="submit">거절</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>		
	</body>
</html>