<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<table class="table w-75 mx-auto">
<c:forEach items="${ list }" var="cs">
<tr>
	<th scope="col">번호</th>
	<th scope="col">제목</th>
	<th scope="col">작성자</th>
	<th scope="col">작성일</th>
	<th scope="col">삭제</th>
</tr>

<tr>
	<th>${ cs.csno }</th>
	<th>${ cs.title }</th>
	<th>${ cs.content }</th>
	<th>${ cs.membeId }</th>
	<th>${ cs.regDate }</th>
	<td>
	<c:forEach items="${ cs.secret }" var="secret" varStatus="vs">
	${ secret }${ vs.last ? "" : "," }
	</c:forEach>
	</td>
	<td>
	<c:forEach items="${ cs.notice }" var="notice" varStatus="vs">
	${ notice }${ vs.last ? "" : "," }
	</c:forEach>
	</td>
	<td>
		<button type="button" class="btn-danger"
				onclick="deleteCs(${ cs.no });">삭제</button>
	</td>	
</tr>
</c:forEach>
</table>
<form action="${ pageContext.request.contextPath }/cs/deleteCs.do" 
	  id="csDeleteFrm" 
	  method="POST">
	<input type="hidden" name="no" />
</form>
<script>
function deleteCs(no){
	if(confirm("정말 삭제하시겠습니까?") == false)
		return;
	var $frm = $("#csDeleteFrm");
	$frm.find("[name=no]").val(no);
	$frm.submit();
}

</script>