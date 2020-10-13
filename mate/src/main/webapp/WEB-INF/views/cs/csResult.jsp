<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <fmt:requestEncoding value="utf-8"/> --%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp">
	<jsp:param value="글등록 결과" name="title"/>
</jsp:include>
<style>
table#tbl-demo{
	margin:0 auto;
	width:50%;
}
</style>
	<table class="table" id="tbl-cs">
		<tr>
			<th scope="col">제목</th>
			<td>${ cs.title }</td>
		</tr>			
		<tr>
			<th scope="col">내용</th>
			<td>${ cs.content }</td>
		</tr>
		<tr>
			<th scope="col">작성일</th>
			<td>${ cs.regDate }</td>
		</tr>
		<tr>
			<th scope="col">작성자</th>
			<td>${ cs.loginMember }</td>
		</tr>
	
	</table>
