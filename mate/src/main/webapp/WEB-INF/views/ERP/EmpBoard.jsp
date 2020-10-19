<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/common/headerE.jsp" />
<div id="board-container">
	<form name="boardFrm" action="${pageContext.request.contextPath}/ERP/empboardEnroll.do" 
	method="post" 	
	>
		
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footerE.jsp" />