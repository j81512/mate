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
<style>
.contain .nevigate {
float : left;}
</style>	  
<div class="container">
<div class="nevigate">
	<h2>지점/제조사 관리</h2>
	<div id="buy" class="tab-pane fade active show in">
		<div class="col-md-15">
		    <div class="form-area">  
				<table id="purchaseLog-table" class="table">
					<tr>
						<th scope="col">계정명</th>
						<th scope="col">사업명</th>
						<th scope="col">주소</th>
						<th scope="col">연락처</th>
						<th scope="col">등록일</th>
						<th scope="col">상태</th>
						<th>
							<button type="button" 
									onclick="location.href='${ pageContext.request.contextPath }/ERP/EmpEnroll.do';">지점/제조사 생성
							</button>
						</th>
					</tr>
					<c:if test="${ not empty list }">
						<c:forEach items="${ list }" var="emp">
						<tr>
							<td>${ emp.empId }</td>
							<td><a href="${ pageContext.request.contextPath }/ERP/empInfoDetail.do?empId=${ emp.empId }">${ emp.empName }</a></td>
							<td>${ emp.empAddr2 }</td>
							<td>${ emp.empPhone }</td>
							<td><fmt:formatDate value="${ emp.empEnrollDate }" pattern="yyyy년MM월dd일"/></td>				
							<td>
								<c:if test="${ emp.status == 0}">관리자
								</c:if>
								<c:if test="${ emp.status == 1}">지점
								</c:if>
								<c:if test="${ emp.status == 2}">제조사
								</c:if>
							</td>		
						</tr>
						</c:forEach>
						</c:if>
						<!-- 상품이 없을 경우 -->
						<c:if test="${ empty list }">
							<li>
								<span>목록이 존재하지 않습니다.</span>
							</li>
						</c:if>	
				</table>
			</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footerE.jsp"/>	
	</body>
</html>