<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- 호근 헤더 처리-->
<title></title>
<script>
$(function(){
	$("tr[data-no]").click(function(){
		var no = $(this).attr("data-no");
		console.log(no);
		location.href = "${ pageContext.request.contextPath }/ERP/EmpBoardDetail.do?no=" + no;
		});
});

function empBoardEnroll(){
	location.href = "${pageContext.request.contextPath}/ERP/EmpBoardEnroll.do";
}

</script>
<jsp:include page="/WEB-INF/views/common/headerE.jsp" />


	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="empBoardEnroll();"/>
	<table id="tbl-board" class="table table-striped table-hover">
         <tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>카테고리</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>활성화 여부</th> 
		</tr>
		<c:if test="${ not empty empBoardList }">
		<c:forEach items="${ empBoardList }" var="board">
		<tr data-no="${ board.boardNo }">
				<td>${ board.boardNo }</td> 
				<td>${ board.title }</td>
				<td>${ board.empId }</td>	
				<td>${ board.category == 'ntc' ? "공지사항"  : board.category eq 'req' ? '요청' : board.category eq 'adv' ? '광고' : board.category eq 'def' ? '일반' : board.category eq 'evt' ? '이벤트' : ''}</td> 
				<td><fmt:formatDate value="${ board.regDate }" pattern="yyyy-MM-dd"/></td>
				<td><a href="${ pageContext.request.contextPath }/ERP/boardReadCount"></a></td>
				<td>${ board.enabled }</td> 
		</tr>
		</c:forEach>
		</c:if>
	</table>
<jsp:include page="/WEB-INF/views/common/footerE.jsp" />