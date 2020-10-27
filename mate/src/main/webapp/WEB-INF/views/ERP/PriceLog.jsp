<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
</head>
  <body>  
	<section>
		<div class="priceInfo">
			<tr>
				<th>날짜</th>
				<th>현황</th>			
				<th>금액</th>			
			</tr>
		</div>
		
		
		<div class="priceInfo">
			<c:if test="${ not empty list }">
				<c:forEach items="${ list }" var="IoLog">
					<tr>
						<td><fmt:formatDate value="${ IoLog.ioDate }" pattern="yyyy년MM월dd일"/></td>
						<td>
							<c:if test="${ IoLog.status eq 'I'}">매입
							</c:if>
							<c:if test="${ IoLog.status eq 'O'}">매출
							</c:if>
						</td>	
						<td></td>				
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${ empty list }">
				<span>검색결과 없음</span>
			</c:if>
		</div>
	</section>

	</body>
</html>