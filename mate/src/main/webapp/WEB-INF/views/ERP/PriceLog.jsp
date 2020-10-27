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
							<thead class="thead-dark">
								<tr>
									<th>날짜</th>
									<th>현황</th>			
									<th>금액</th>			
								</tr>
							</thead>
							<c:if test="${ not empty list }">
							<tbody>
								<c:forEach items="${ list }" var="IoLog">
									<tr>
										<td><fmt:formatDate value="${ IoLog.ioDate }" pattern="yyyy년MM월dd일"/></td>
										<td>
											<c:if test="${ IoLog.status eq 'I'}">매입
											</c:if>
											<c:if test="${ IoLog.status eq 'O'}">매출
											</c:if>
										</td>				
									</tr>
								</c:forEach>
							</tbody>
							</c:if>
							<c:if test="${ empty list }">
								<tr>
									<td colspan="3">검색결과 없음</td>
								</tr>
							</c:if>
						</table>
					</div>
				</div>
			</div>
		</div>			
	</body>
</html>