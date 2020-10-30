<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerE.jsp"/>
<c:if test="${not empty msg }">
<script>
	alert("${msg}");
</script>
</c:if>
<style>
.form-area{
	height: 650px;
	overflow:scroll;
}
.thead-dark th{
	position: sticky;
    top : 0;
}
.container .nevigate {
	float : left;}
</style>	  
</head>
	<body>
<div class="container">
	<h2>지점/제조사 관리</h2>
<div class="nevigate">
	<div id="buy" class="tab-pane fade active show in">
		<div class="col-md-15">
		    <div class="form-area">  
				<table id="purchaseLog-table" class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">계정명</th>
						<th scope="col">사업명</th>
						<th scope="col">주소</th>
						<th scope="col">연락처</th>
						<th scope="col">등록일</th>
						<th scope="col">상태</th>
						<th></th>
						<th>
							<button type="button" 
									onclick="location.href='${ pageContext.request.contextPath }/ERP/EmpEnroll.do';">지점/제조사 생성
							</button>
						</th>
					</tr>
				</thead>
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
							<tr>
								<td colspan="6">목록이 존재하지 않습니다.</td>
							</tr>
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